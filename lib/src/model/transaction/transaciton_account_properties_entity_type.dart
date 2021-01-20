part of xpx_chain_sdk.transaction;

// AliasTransaction
class AccountPropertiesEntityTypeTransaction extends AbstractTransaction implements Transaction {
  AccountPropertiesEntityTypeTransaction(Deadline deadline, this.propertyType, this.modifications, int networkType)
      : super() {
    version = accountPropertyEntityTypeVersion;
    this.deadline = deadline;
    type = TransactionType.accountPropertyEntityType;
    this.networkType = networkType;
  }

  AccountPropertiesEntityTypeTransaction.fromDTO(AccountPropertiesEntityTypeTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    propertyType = AccountPropertyType.fromInt(dto.transaction.propertyType);
    modifications = AccountPropertiesEntityTypeModification.listFromJson(dto.transaction.modifications);
  }

  AccountPropertyType propertyType;
  List<AccountPropertiesEntityTypeModification> modifications;

  int get size => _size();

  AbstractTransaction get abstractTransaction => absTransaction();

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
  int _size() => accountPropertyEntityTypeHeader + (accountPropertiesEntityModificationSize * modifications.length);

  @override
  TransactionType entityType() => type;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final List<int> msb = List(modifications.length);
    int i = 0;
    for (final modification in modifications) {
      final entity = modification.transactionType;
      final aV = builder.writeListUint8(entity.toBytes());

      final ms = PropertyModificationBufferBuilder(builder)
        ..begin()
        ..addModificationType(modification.modificationType.index)
        ..addValueOffset(aV);
      msb[i] = ms.finish();
      i++;
    }

    final mV = builder.writeList(msb);

    final vectors = _generateVector(builder);

    final txnBuilder = AccountPropertiesTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addPropertyType(propertyType.value)
      ..addModificationCount(modifications.length)
      ..addModificationsOffset(mV);
    _buildVector(builder, vectors);

    final codedAccountProperty = txnBuilder.finish();

    return accountPropertyTransactionSchema().serialize(builder.finish(codedAccountProperty));
  }
}
