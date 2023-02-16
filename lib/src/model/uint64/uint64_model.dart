/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.uint64;

/// Represents a 64-bit unsigned integer.
///
/// This class uses Dart's native number type [BigInt] and has a value check for big integers.
/// [BigInt] will be translated correctly into JavaScript (supported by dart2js).
/// Value range is 0 through 18446744073709551615.
class Uint64 implements Comparable<Uint64> {
  factory Uint64([final num value = 0, final num value2 = 0]) {
    if (minValueSigned > value || minValueSigned > value2) {
      throw ArgumentError('Minimum value must be $minValue');
    }

    // check if user is trying to create using an array of (32-bit) int
    if (minValueSigned < value2) {
      return Uint64.fromInts(value as int, value2 as int);
    }

    final BigInt bigValue = BigInt.from(value);
    _checkValue(bigValue);

    return Uint64._internal(bigValue);
  }

  Uint64._internal(BigInt i) : value = i;

  /// Creates a [Uint64] from a [bigValue].
  static Uint64 fromBigInt(final BigInt bigValue) {
    _checkValue(bigValue);

    return Uint64._internal(bigValue);
  }

  /// Creates a [Uint64] from a [int].
  static Uint64 fromInt(final int value) => Uint64.fromBigInt(BigInt.from(value));

  /// Creates a [Uint64] from a uint8list [bytes] (64-bit).
  static Uint64 fromBytes(final Uint8List bytes) {
    final Int64 int64 = Int64.fromBytes(bytes);
    return fromHex(int64.toHexString());
  }

  /// Creates a [Uint64] from a [hex].
  static Uint64 fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (!HexUtils.isHex(hex)) {
      throw ArgumentError('Invalid hex');
    }

    BigInt bigInt = BigInt.zero;
    if (hex.startsWith('0x'))
      bigInt = BigInt.parse(hex.substring(2), radix: 16);
    else if (hex.startsWith('+0x'))
      bigInt = BigInt.parse(hex.substring(3), radix: 16);
    else if (hex.startsWith('-0x'))
      bigInt = -BigInt.parse(hex.substring(3), radix: 16);
    else
      bigInt = BigInt.parse(hex, radix: 16);

    return fromBigInt(bigInt);
  }

  /// Creates a [Uint64] from a pair of 32-bit integers.
  static Uint64 fromInts(final int lower, final int higher) {
    final Int64 int64 = Int64.fromInts(higher, lower);
    return fromHex(int64.toHexString());
  }

  /// Creates a [Uint64] from a pair of [UInt64DTO].
  static Uint64 fromDto(UInt64DTO dto) {
    final higher = dto.higher!.toInt();
    final lower = dto.lower!.toInt();
    final Int64 int64 = Int64.fromInts(lower, higher);
    return fromHex(int64.toHexString());
  }

  /// Parses [source] as a, possibly signed, integer literal and returns its
  /// value.
  static Uint64? tryParse(String source) {
    final bigInt = BigInt.tryParse(source);
    if (bigInt != null) {
      return fromBigInt(bigInt);
    } else {
      return null;
    }
  }

  /// Generate UInt64 from a utf8 string.
  /// Deterministic uint64 value for the given utf8 string.
  static Uint64 fromUtf8(final String source) {
    if (source.isEmpty) {
      throw ArgumentError('Input must not be empty');
    }
    final sha3_256 = SHA3(256, SHA3_PADDING, 256);

    final buf = sha3_256.update(ByteUtils.stringToBytesUtf8(source));

    return Uint64.fromBytes(Uint8List.fromList(buf.digest()));
  }

  /// The accepted min value of 64-bit signed integer.
  static const int minValueSigned = 0;

  /// The maximum value of 64-bit signed integer. Equals to 9223372036854775807.
  static const int maxValueSigned = 2147483648 * 2147483648 - 1 + 2147483648 * 2147483648;

  /// The accepted minimum value of 64-bit unsigned integer.
  static final BigInt minValue = BigInt.zero;

  /// The maximum value of 64-bit unsigned integer. Equals to 18446744073709551615.
  static final BigInt maxValue = BigInt.parse('FFFFFFFFFFFFFFFF', radix: 16);

  /// The value of Uint64 is stored as BigInt.
  BigInt value;

  /// An [Int64] constant equal to 0.
  static Uint64 get zero => fromBigInt(BigInt.zero);

  /// An [Int64] constant equal to 1.
  static Uint64 get one => fromBigInt(BigInt.one);

  /// An [Int64] constant equal to 2.
  static Uint64 get two => fromBigInt(BigInt.two);

  /// Whether this big integer is even.
  bool get isEven => value.isEven;

  /// Whether this big integer is odd.
  bool get isOdd => value.isOdd;

  bool get isMaxValue => value == maxValue;

  bool get isMinValue => value == minValue;

  bool get isZero => value == BigInt.zero && toBytes().every((value) => 0 == value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(final other) => other is Uint64 && value == other.value;

  /// Return the negative value of this integer.
  ///
  /// The result of negating an integer always has the opposite sign, except
  /// for zero, which is its own negation.
  ///
  Uint64 operator -() => Uint64.fromBigInt(-value);

  /// Addition operator.
  Uint64 operator +(other) => Uint64.fromBigInt(value + other.value);

  /// Subtraction operator.
  Uint64 operator -(other) => Uint64.fromBigInt(value - other.value);

  /// Multiplication operator.
  Uint64 operator *(other) => Uint64.fromBigInt(value * other.value);

  /// Division operator.
  double operator /(other) => (value / other.value).toDouble();

  /// Truncating division operator.
  Uint64 operator ~/(other) => Uint64.fromBigInt(value ~/ other.value);

  /// Euclidean modulo operator.
  Uint64 operator %(other) => Uint64.fromBigInt(value ~/ other.value);

  /// Relational less than operator.
  bool operator <(other) => value < other.value;

  /// Relational less than or equal operator.
  bool operator <=(other) => value <= other.value;

  /// Relational greater than operator.
  bool operator >(other) => value > other.value;

  /// Relational greater than or equal operator.
  bool operator >=(other) => value >= other.value;

  /// Right bit-shift operator.
  Uint64 operator <<(int shiftAmount) {
    if (shiftAmount < 0) {
      throw ArgumentError.value(shiftAmount);
    }
    if (shiftAmount >= 64) {
      return Uint64.zero;
    }

    final bigInt = toBigInt() << shiftAmount;

    return Uint64.fromBigInt(bigInt);
  }

  /// Bit-wise and operator.
  Uint64 operator &(other) {
    final Uint64 o = _promote(other);
    return Uint64.fromBigInt(value & o.value);
  }

  /// Bit-wise exclusive-or operator.
  Uint64 operator ^(Object other) {
    final Uint64 o = _promote(other);
    return Uint64.fromBigInt(value ^ o.value);
  }

  /// Bit-wise or operator.
  Uint64 operator |(other) {
    final Uint64 o = _promote(other);
    return Uint64.fromBigInt(value | o.value);
  }

  /// Tries to compact a this value into a simple numeric.
  int get compact {
    final intArray = toIntArray();
    final int low = intArray[0];
    final int high = intArray[1];

    // don't compact if the value is >= 2^53
    if (0x00200000 <= high) {
      return toInt();
    }

    // multiply because javascript bit operations operate on 32bit values
    return (high * 0x100000000) + low;
  }

  @override
  int compareTo(final Uint64 other) => value.compareTo(other.value);

  /// Returns this [Uint64] as a [double].
  double toDouble() => value.toDouble();

  /// Returns this [Uint64] as a [BigInt].
  BigInt toBigInt() => value;

  /// Returns this [Uint64] as a [int].
  int toInt() => value.toInt();

  Uint64 abs() => this;

  @override
  String toString() => value.toString();

  /// Converts to hex string representation. Fills with leading 0 to reach 16 characters length.
  String toHex() {
    String hex = value.toRadixString(16).toUpperCase();
    if (hex.length != 16) {
      return '${List.filled(16 - hex.length, '0').join()}$hex';
    }
    return hex;
  }

  /// Converts to 64-bit byte array.
  Uint8List toBytes() {
    final String hex = toHex();
    final Int64 int64 = Int64.parseHex(hex);

    return Uint8List.fromList(int64.toBytes());
  }

  /// Converts to a pair of 32-bit integers ([lower, higher]).
  List<int> toIntArray() {
    if (value == BigInt.zero) {
      return [0, 0];
    }
    final l = value.toUnsigned(32);
    final r = (value >> 32).toUnsigned(32);

    return List<int>.from([l.toInt(), r.toInt()]);
  }

  static void _checkValue(final BigInt value) {
    if (value < minValue || value > maxValue) {
      throw ArgumentError('Value out of range');
    }
  }

  // Returns the [Int64] representation of the specified value. Throws
  // [ArgumentError] for non-integer arguments.
  static Uint64 _promote(value) {
    if (value is Uint64) {
      return value;
    } else if (value is int) {
      return Uint64.fromBigInt(BigInt.from(value));
    }
    throw ArgumentError.value(value);
  }

  dynamic toJson() => value.toInt();
}
