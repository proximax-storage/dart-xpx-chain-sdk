part of xpx_chain_sdk.utils;

/// A utility class that provides functions for converting hex strings.
class HexUtils {
  /// Converts a hex string to a [Uint8List].
  static Uint8List hexToBytes(String hexString) => Uint8List.fromList(hex.decode(hexString));

  /// Converts [hex] string to a byte array.
  ///
  /// Throws an exception upon failing.
  static List<int> getBytes(final String hex) {
    try {
      return _getBytesInternal(hex);
    } catch (e) {
      throw ArgumentError('Could not convert hex string into a byte array. Error: $e');
    }
  }

  /// Tries to convert [hex] string to a byte array.
  ///
  /// The output will be null if the input is malformed.
  static List<int> tryGetBytes(final String hex) {
    try {
      return _getBytesInternal(hex);
    } catch (e) {
      return null;
    }
  }

  /// Converts byte array to a hex string.
  ///
  /// Used for converting UTF-8 encoded data from and to bytes.
  static String getString(final List<int> bytes) {
    final encodedString = hex.encode(bytes);
    return ByteUtils.bytesToUtf8String(encodedString.codeUnits);
  }

  /// Determines whether or not an [input] string is a hex string.
  static bool isHex(final String input) {
    if (input == null) {
      return false;
    }

    if (0 != (input.length % 2)) {
      return false;
    }

    return tryGetBytes(input) == null ? false : true;
  }

  /// Determines whether the [input] string is a valid hex string.
  static bool isHexString(String input) {
    final hexChars = <String>[
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F'
    ];
    for (var i = 0; i < input.length; i++) {
      if (!hexChars.contains(input[i])) {
        return false;
      }
    }
    return true;
  }

  /// Converts a UTF-8 [input] string to hex string.
  static String utf8ToHex(final String input) {
    final sb = StringBuffer();
    final rawString = _rawStringToUtf8(input);
    for (var i = 0; i < rawString.length; i++) {
      sb.write(rawString.codeUnitAt(i).toRadixString(16));
    }
    return sb.toString();
  }

  /// Tries to convert a [hex] string to a UTF-8 string.
  /// When it fails to decode UTF-8, it returns the non UTF-8 string instead.
  static String tryHexToUtf8(final String hex) {
    final codeUnits = _getCodeUnits(hex);
    try {
      return ByteUtils.bytesToUtf8String(codeUnits);
    } catch (e) {
      return String.fromCharCodes(codeUnits);
    }
  }

  /// Converts a hex string to a binary string.
  static String hexToBinary(String hexString) => BigInt.parse(hexString, radix: 16).toRadixString(2);

  /// Returns the reversed order of the given [input] hex string.
  ///
  /// Throws an error if [input] could not be processed.
  static String reverseHexString(String input) {
    try {
      return getString(getBytes(input).reversed.toList());
    } catch (e) {
      throw ArgumentError('Failed reversing the input. Error: $e');
    }
  }

  // ------------------------------ private / protected functions ------------------------------ //

  /// Converts a hex string into byte array. Also tries to correct malformed hex string.
  static List<int> _getBytesInternal(final String hexString) {
    final paddedHexString = 0 == hexString.length % 2 ? hexString : '0$hexString';
    final encodedBytes = ByteUtils.stringToBytesUtf8(paddedHexString);
    return hex.decode(String.fromCharCodes(encodedBytes));
  }

  /// Converts raw string into a string of single byte characters using UTF-8 encoding.
  static String _rawStringToUtf8(final String input) {
    final sb = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final cu = input.codeUnitAt(i);

      if (128 > cu) {
        sb.write(String.fromCharCode(cu));
      } else if ((127 < cu) && (2048 > cu)) {
        sb.write(String.fromCharCode((cu >> 6) | 192));
        sb.write(String.fromCharCode((cu & 63) | 128));
      } else {
        sb.write(String.fromCharCode((cu >> 12) | 224));
        sb.write(String.fromCharCode(((cu >> 6) & 63) | 128));
        sb.write(String.fromCharCode((cu & 63) | 128));
      }
    }

    return sb.toString();
  }

  /// Get a list of code unit of a hex string.
  static List<int> _getCodeUnits(final String hex) {
    final codeUnits = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      codeUnits.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }

    return codeUnits;
  }
}
