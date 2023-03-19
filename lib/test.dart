import 'package:xpx_chain_sdk/src/model/wallet/wallet_crypto.dart';

/* Uint8List randomBytes(int n) {
  final Random generator = Random.secure();
  final Uint8List random = Uint8List(n);
  for (int i = 0; i < random.length; i++) {
    random[i] = generator.nextInt(255);
  }
  return random;
}

void main() {
  print(randomBytes(23));
}
 */

void main() {
  WalletCrypto.encodePrivateKey(
      '6D93A6D1612C99F93699A75C9A981EE51B75DEE3D8519EDE35329E00BBE4E4AD',
      'J88198300m');
  /* String a = randomHexString(32);
  print(a); // 1401280aa29717e4940f0845f0d43abd
  print(a.toString()); */
}

/* Random _random = Random();

String randomHexString(int length) {
  StringBuffer sb = StringBuffer();
  for (var i = 0; i < length; i++) {
    sb.write(_random.nextInt(16).toRadixString(16));
  }
  return sb.toString();
}
 */