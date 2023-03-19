import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:sha3/sha3.dart';
import 'package:xpx_chain_sdk/src/model/wallet/wallet_algorithm.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

Uint8List hexToUint8List(String hex) {
  if (hex.length % 2 != 0) {
    throw new Exception('Odd number of hex digits');
  }
  var l = hex.length ~/ 2;
  var result = new Uint8List(l);
  for (var i = 0; i < l; ++i) {
    var x = int.parse(hex.substring(i * 2, 2 * i + 1), radix: 16);
    if (x.isNaN) {
      throw Exception('Expected hex string');
    }
    result[i] = x;
  }
  return result;
}

class WalletCrypto {
  static Map<String, dynamic> encrypt(String data, Uint8List key) {
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(Key(key)));
    Encrypted encrypted = encrypter.encrypt(data, iv: iv);

    return {
      'cipherText': encrypted.base16,
      'iv': iv.base16,
    };
  }

  static Map<String, String> encodePrivateKey(
      String privateKey, String password) {
    // Errors

    final pass = WalletCrypto.derivePassSha(password, 20);
    final r = WalletCrypto.encrypt(privateKey, HexUtils.hexToBytes(pass));
    // Result
    return {
      'ciphertext': r['cipherText'],
      'iv': r['iv'],
    };
  }

  static String derivePassSha(String password, int count) {
    if (count <= 0) {
      throw new Exception('Please provide a count number above 0');
    }
    // Processing
    SHA3 sha3 = SHA3(256, SHA3_PADDING, 256);
    List<int> wordArray = sha3.update(utf8.encode(password)).s!;
    for (var i = 1; i < count; ++i) {
      wordArray = sha3.update(wordArray).s!;
    }
    var hash = sha3.digest();
    return hex.encode(hash);
  }

  static String decrypt(Map<String, String> data) {
    final encrypter = Encrypter(AES(Key(HexUtils.hexToBytes(data['key']!))));

    return encrypter.decrypt(Encrypted.fromBase16(data['cipherText']!),
        iv: IV.fromBase16(data['iv']!));
  }

  static String passwordToPrivateKey(
      String password, String encrypted, String iv, WalletAlgorithm algo) {
    if (algo == WalletAlgorithm.passBip32) {
      // Wallets from PRNG
      String pass = WalletCrypto.derivePassSha(password, 20);
      final data = {'cipherText': encrypted, 'iv': iv, 'key': pass};

      return WalletCrypto.decrypt(data);
    }
    return '';
  }
}
