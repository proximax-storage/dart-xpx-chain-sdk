part of xpx_chain_sdk.uint64;

/// Represents a 64-bit unsigned integer.
///
/// This class uses Dart's native number type [BigInt] and has a value check for big integers.
/// [BigInt] will be translated correctly into JavaScript (supported by dart2js).
/// Value range is 0 through 18446744073709551615.
class Uint64 implements Comparable<Uint64> {
  factory Uint64([final num value = 0, final num value2 = 0]) {
    if (_minValueSigned > value || _minValueSigned > value2) {
      throw ArgumentError('Minimum value must be $_minValueUnsigned');
    }

    // check if user is trying to create using an array of (32-bit) int
    if (_minValueSigned < value2) {
      return Uint64.fromInts(value, value2);
    }

    final BigInt bigValue = BigInt.from(value);
    _checkValue(bigValue);

    return Uint64._internal(bigValue);
  }

  Uint64._internal(BigInt i) : _value = i;

  /// Creates a [Uint64] from a [bigInt].
  static Uint64 fromBigInt(final BigInt bigInt) {
    _checkValue(bigInt);
    return Uint64._internal(bigInt);
  }

  /// Creates a [Uint64] from a uint8list [bytes] (64-bit).
  static Uint64 fromBytes(final Uint8List bytes) {
    final Int64 int64 = Int64.fromBytes(bytes);
    return fromHex(int64.toHexString());
  }

  /// Creates a [Uint64] from a [hex].
  static Uint64 fromHex(final String hex) {
    final BigInt bigInt = BigInt.parse(hex, radix: 16);
    return fromBigInt(bigInt);
  }

  /// Creates a [Uint64] from a pair of 32-bit integers.
  static Uint64 fromInts(final int lower, final int higher) {
    final Int64 int64 = Int64.fromInts(higher, lower);
    return fromHex(int64.toHexString());
  }

  /// Creates a [Uint64] from a pair of [UInt64DTO].
  static Uint64 fromDto(UInt64DTO dto) {
    final higher = dto.higher.toInt();
    final lower = dto.lower.toInt();
    final Int64 int64 = Int64.fromInts(lower, higher);
    return fromHex(int64.toHexString());
  }

  /// The accepted min value of 64-bit signed integer.
  static const int _minValueSigned = 0;

  /// The accepted minimum value of 64-bit unsigned integer.
  static final BigInt _minValueUnsigned = BigInt.zero;

  /// The maximum value of 64-bit unsigned integer. Equals to 18446744073709551615.
  static final BigInt _maxValueUnsigned = BigInt.parse('FFFFFFFFFFFFFFFF', radix: 16);

  /// The value of Uint64 is stored as BigInt.
  BigInt _value;

  /// An [Int64] constant equal to 0.
  static Uint64 get zero => fromBigInt(BigInt.zero);

  /// An [Int64] constant equal to 1.
  static Uint64 get one => fromBigInt(BigInt.one);

  /// An [Int64] constant equal to 2.
  static Uint64 get two => fromBigInt(BigInt.two);

  /// Whether this big integer is even.
  bool get isEven => _value.isEven;

  /// Whether this big integer is odd.
  bool get isOdd => _value.isOdd;

  bool get isMaxValue => _value == _maxValueUnsigned;

  bool get isMinValue => _value == _minValueUnsigned;

  bool get isZero => _value == BigInt.zero && toBytes().every((value) => 0 == value);

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(final other) => other is Uint64 && _value == other._value;

  /// Return the negative value of this integer.
  ///
  /// The result of negating an integer always has the opposite sign, except
  /// for zero, which is its own negation.
  Uint64 operator -() => Uint64.fromBigInt(-_value);

  /// Addition operator.
  Uint64 operator +(other) => Uint64.fromBigInt(_value + other._value);

  /// Subtraction operator.
  Uint64 operator -(other) => Uint64.fromBigInt(_value - other._value);

  /// Multiplication operator.
  Uint64 operator *(other) => Uint64.fromBigInt(_value * other._value);

  /// Division operator.
  double operator /(other) => (_value / other._value).toDouble();

  /// Truncating division operator.
  Uint64 operator ~/(other) => Uint64.fromBigInt(_value ~/ other._value);

  /// Euclidean modulo operator.
  Uint64 operator %(other) => Uint64.fromBigInt(_value ~/ other._value);

  /// Relational less than operator.
  bool operator <(other) => _value < other._value;

  /// Relational less than or equal operator.
  bool operator <=(other) => _value <= other._value;

  /// Relational greater than operator.
  bool operator >(other) => _value > other._value;

  /// Relational greater than or equal operator.
  bool operator >=(other) => _value >= other._value;

  /// Bit-wise and operator.
  Uint64 operator &(other) {
    final Uint64 o = _promote(other);
    return Uint64.fromBigInt(_value & o._value);
  }

  /// Bit-wise or operator.
  Uint64 operator |(other) {
    final Uint64 o = _promote(other);
    return Uint64.fromBigInt(_value | o._value);
  }

  @override
  int compareTo(final Uint64 other) => _value.compareTo(other._value);

  /// Returns this [Uint64] as a [double].
  double toDouble() => _value.toDouble();

  /// Returns this [Uint64] as a [BigInt].
  BigInt toBigInt() => _value;

  /// Returns this [Uint64] as a [int].
  int toInt() => _value.toInt();

  Uint64 abs() => this;

  @override
  String toString() => _value.toString();

  /// Converts to hex string representation. Fills with leading 0 to reach 16 characters length.
  String toHex() {
    String hex = _value.toRadixString(16).toUpperCase();
    if (hex.length % 2 != 0) {
      hex = '0$hex';
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
    if (_value == null) {
      return [0, 0];
    }
    final l = _value.toUnsigned(32);
    final r = (_value >> 32).toUnsigned(32);

    return List<int>.from([l.toInt(), r.toInt()]);
  }

  static void _checkValue(final BigInt value) {
//    if (value < _minValueUnsigned || value > _maxValueUnsigned) {
//      throw ArgumentError('Value out of range');
//    }
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
}
