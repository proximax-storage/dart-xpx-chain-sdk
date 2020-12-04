part of xpx_chain_sdk.utils;

/// A utility class that provides functions for converting Bytes.
class ByteUtils {
  static List<String> hexArray = '0123456789ABCDEF'.split('');

  /// Decode a BigInt from bytes in big-endian encoding.
  static BigInt _decodeBigInt(List<int> bytes) {
    var result = BigInt.from(0);
    for (var i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  /// Convert a byte array [bytes] into a hex string.
  ///
  /// Used to get a hex string representation of raw bytes.
  /// Should not be used for UTF-8 encoded data such as message encryption.
  static String bytesToHex(final List<int> bytes) {
    final result = StringBuffer();
    for (var part in bytes) {
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return result.toString();
  }

  /// Converts bytes to [BigInt].
  static BigInt bytesToBigInt(Uint8List bigIntBytes) {
    return _decodeBigInt(bigIntBytes);
  }

  /// Converts a bigint to a byte array.
  static Uint8List bigIntTo16Bytes(BigInt bigInt) {
    return HexUtils.hexToBytes(bigInt.toRadixString(16).padLeft(32, '0'));
  }

  /// Converts a binary string into a hex string.
  static String binaryToHex(String binary) {
    return BigInt.parse(binary, radix: 2).toRadixString(16).toUpperCase();
  }

  /// Reverse the bytes.
  static Uint8List reverseBytes(Uint8List bytes) {
    var reversed = Uint8List(bytes.length);
    for (var i = bytes.length; i > 0; i--) {
      reversed[bytes.length - i] = bytes[i - 1];
    }
    return reversed;
  }

  /// Converts an integer to a byte array.
  static Uint8List intToBytes(int long, int length) {
    // we want to represent the input as a 8-bytes array
    final byteArray = Uint8List(length);

    for (var index = length - 1; index >= 0; index--) {
      final byte = long & 0xff;
      byteArray[index] = byte;
      long = (long - byte) ~/ 256;
    }

    // Cleaner implementation but breaks in dart2js/flutter web
    // return Uint8List(8)..buffer.asByteData().setInt64(0, long);

    return reverseBytes(byteArray);
  }

  /// Converts byte array to string UTF-8.
  static String bytesToUtf8String(Uint8List bytes) {
    return utf8.decode(bytes);
  }

  /// Converts a UTF-8 [input] string to an encoded byte array.
  static List<int> stringToBytesUtf8(final String input) {
    return utf8.encode(input);
  }

  /// Converts a UTF-8 [input] string to an encoded byte array.
  static Uint8List utf8StringToBytes(final String input) {
    return Uint8List.fromList(utf8.encode(input));
  }

  /// Concatenates one or more byte arrays.
  static Uint8List concat(List<Uint8List> bytes) {
    var hex = '';
    bytes.forEach((v) {
      hex += bytesToHex(v);
    });
    return HexUtils.hexToBytes(hex);
  }

  /// Converts an byte array to a integer.
  static int bytesToInt(List<int> bytes) {
    var value = 0;

    for (var i = 0, length = bytes.length; i < length; i++) {
      value += bytes[i] * pow(256, i);
    }
    return value;
  }
}
