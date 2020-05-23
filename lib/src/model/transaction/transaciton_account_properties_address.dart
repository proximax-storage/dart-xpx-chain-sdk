part of xpx_chain_sdk.transaction;

// AliasTransaction
class AccountPropertiesAddressTransaction extends AbstractTransaction
    implements Transaction {
  AccountPropertiesAddressTransaction._(int version, Deadline deadline,
      this.propertyType, this.modifications, int networkType)
      : super() {
    this.version = accountPropertyAddressVersion;
    this.deadline = deadline;
    type = TransactionType.accountPropertyAddress;
    this.networkType = networkType;
  }

  AccountPropertiesAddressTransaction.fromDTO(
      AccountPropertiesAddressTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    propertyType = AccountPropertyType.fromInt(dto.transaction.propertyType);
    modifications = AccountPropertiesAddressModification.listFromJson(
        dto.transaction.modifications);
  }

  AccountPropertyType propertyType;
  List<AccountPropertiesAddressModification> modifications;

  int get size => _size();
  AbstractTransaction get abstractTransaction => _abstractTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_absToString()}\n'
      '\t"propertyType": $propertyType,\n'
      '\t"modifications": $modifications\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['propertyType'] = propertyType;
    data['modifications'] = modifications;

    return data;
  }

  @override
  int _size() =>
      accountPropertyMosaicHeader +
      (accountPropertiesMosaicModificationSize * modifications.length);

  @override
  AbstractTransaction _abstractTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() => null;
}
