part of xpx_chain_sdk.transaction;

// AliasTransaction
class AccountPropertiesMosaicTransaction extends AbstractTransaction
    implements Transaction {
  AccountPropertiesMosaicTransaction._(int version, Deadline deadline,
      this.propertyType, this.modifications, int networkType)
      : super() {
    this.version = accountPropertyMosaicVersion;
    this.deadline = deadline;
    type = TransactionType.accountPropertyMosaic;
    this.networkType = networkType;
  }

  AccountPropertiesMosaicTransaction.fromDTO(
      AccountPropertiesMosaicTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    propertyType = AccountPropertyType.fromInt(dto.transaction.propertyType);
    modifications = AccountPropertiesMosaicModification.listFromJson(
        dto.transaction.modifications);
  }

  AccountPropertyType propertyType;
  List<AccountPropertiesMosaicModification> modifications;

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
