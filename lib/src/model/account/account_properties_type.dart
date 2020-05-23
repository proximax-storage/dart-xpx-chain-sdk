part of xpx_chain_sdk.account;

/// The property type of an account.
///
/// Supported types are:
/// * 0x01	Account property type is an address.
/// * 0x02	Account property type is a mosaic id.
/// * 0x04	Account property type is a transaction type.
class AccountPropertyType {
  // constant constructor: makes this class available on runtime.
  // emulates an enum class with a value.
  const AccountPropertyType._(this.value);

  static const String unknownAccountPropertyType =
      'unknown account restriction type';

  ///  Allow address property type.
  static const AccountPropertyType allowAddress = AccountPropertyType._(0x01);

  /// Allow mosaic identifier property type.
  static const AccountPropertyType allowMosaic = AccountPropertyType._(0x02);

  /// Allow transaction type property type.
  static const AccountPropertyType allowTransaction =
      AccountPropertyType._(0x04);

  /// Block address property type.
  static const AccountPropertyType blockAddress =
      AccountPropertyType._(0x80 + 0x01);

  /// Block mosaic identifier property type.
  static const AccountPropertyType blockMosaic =
      AccountPropertyType._(0x80 + 0x02);

  /// Blocking transaction type property type.
  static const AccountPropertyType blockTransaction =
      AccountPropertyType._(0x80 + 0x04);

  /// Supported property types.
  static final List<AccountPropertyType> values = <AccountPropertyType>[
    allowAddress,
    allowMosaic,
    allowTransaction,
    blockAddress,
    blockMosaic,
    blockTransaction
  ];

  /// The int value of this type.
  final int value;

  /// Returns a [AccountPropertyType] for the given int value.
  ///
  /// Throws an error when the type is unknown.
  static AccountPropertyType fromInt(final int value) {
    for (var type in values) {
      if (type.value == value) {
        return type;
      }
    }

    throw new ArgumentError(unknownAccountPropertyType);
  }

  @override
  String toString() => '{value: $value}';
}
