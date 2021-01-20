part of xpx_chain_sdk.transaction;

/// Aggregate Complete send transactions in batches to different [Account].
/// Aggregate Bonded propose many transactions between different [Account].
///
class AggregateTransaction extends AbstractTransaction implements Transaction {
  factory AggregateTransaction.bonded(Deadline deadline, List<Transaction> innerTxs, int networkType) =>
      AggregateTransaction._(deadline, innerTxs, networkType, aggregateBondedVersion, TransactionType.aggregateBonded);

  factory AggregateTransaction.complete(Deadline deadline, List<Transaction> innerTxs, int networkType) =>
      AggregateTransaction._(
          deadline, innerTxs, networkType, aggregateCompletedVersion, TransactionType.aggregateCompleted);

  AggregateTransaction._(
      Deadline deadline, List<Transaction> innerTxs, int networkType, int version, TransactionType type)
      : super() {
    if (innerTxs.isEmpty == null) {
      throw errNullInnerTransactions;
    } else {
      this.version = version;
      this.deadline = deadline;
      this.type = type;
      this.networkType = networkType;
      innerTransactions = innerTxs;
    }
  }

  AggregateTransaction.fromDTO(AggregateTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto._transaction, dto.meta) {
    innerTransactions = dto._transaction._transactions.map(deserializeDTO).toList();
    cosignatures = AggregateTransactionCosignature.listFromDTO(networkType, dto._transaction._cosignatures);
  }

  List<Transaction> innerTransactions;
  List<AggregateTransactionCosignature> cosignatures;

  int get size => _size();

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  static List<AggregateTransaction> listFromDTO(List<AggregateTransactionInfoDTO> json) =>
      json == null ? null : json.map((value) => AggregateTransaction.fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_absToString()}')
      ..writeln('\t"innerTransactions": $innerTransactions,')
      ..writeln('\t"cosignatures": $cosignatures')
      ..write('}');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['innerTransactions'] = innerTransactions;
    data['cosignatures'] = cosignatures;
    return data;
  }

  @override
  int _size() {
    int sizeOfInnerTransactions = 0;
    for (final itx in innerTransactions) {
      sizeOfInnerTransactions += itx._size() - signatureSize - maxFeeSize - deadLineSize;
    }
    return aggregateBondedHeader + sizeOfInnerTransactions;
  }

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    // InnerTransactions
    final txsBytes = <int>[];
    for (final itx in innerTransactions) {
      final txb = toAggregateTransactionBytes(itx);
      txsBytes.addAll(txb);
    }

    final tV = builder.writeListUint8(Uint8List.fromList(txsBytes));

    final vector = _generateVector(builder);

    final txnBuilder = AggregateTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addTransactionsSize(txsBytes.length)
      ..addTransactionsOffset(tV);
    _buildVector(builder, vector);

    final codedAggregate = txnBuilder.finish();

    return aggregateTransactionSchema().serialize(builder.finish(codedAggregate));
  }
}

/// AggregateTransactionCosignature
class AggregateTransactionCosignature {
  AggregateTransactionCosignature(this.signature, this.signer);

  AggregateTransactionCosignature.fromDTO(int networkType, _AggregateTransactionCosignatureDTO dto) {
    if (dto?.signer == null) {
      return;
    }

    signature = dto.signature;
    signer = PublicAccount.fromPublicKey(dto.signer, networkType);
  }

  String signature;
  PublicAccount signer;

  @override
  String toString() => '{\n'
      '\t"signature": $signature\n'
      '\t"signer": $signer\n'
      '}\n';

  static List<AggregateTransactionCosignature> listFromDTO(
          int networkType, List<_AggregateTransactionCosignatureDTO> json) =>
      json == null ? null : json.map((value) => AggregateTransactionCosignature.fromDTO(networkType, value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}

/// Cosign an aggregate bonded transaction.
/// [CosignatureTransaction] are used to sign announced aggregate bonded transactions with missing cosignatures.
///
class CosignatureTransaction {
  CosignatureTransaction(this._transactionToCosign)
      : assert(_transactionToCosign != null, 'txToCosign must not be null');

  final AggregateTransaction _transactionToCosign;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionToCosign'] = _transactionToCosign;
    return data;
  }
}
