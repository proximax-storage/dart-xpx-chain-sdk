part of xpx_chain_sdk.transaction;

/// A deposit before announcing aggregate bonded transactions.
/// Alias: LockFundsTransaction
///
class LockFundsTransaction extends AbstractTransaction implements Transaction {
  LockFundsTransaction(Deadline deadline, Mosaic mosaic, Uint64 duration, SignedTransaction signedTx, int networkType)
      : assert(mosaic != null, 'mosaic must not be null'),
        assert(duration != null, 'duration must not be null'),
        assert(signedTx != null, 'signedTx must not be null'),
        super() {
    if (signedTx.transactionType != TransactionType.aggregateBonded.value) {
      throw errEmptyModifications;
    } else {
      version = lockVersion;
      this.deadline = deadline;
      type = TransactionType.lock;
      this.networkType = networkType;
      this.mosaic = mosaic;
      this.duration = duration;
      signedTransaction = signedTx;
    }
  }

  LockFundsTransaction.fromDTO(LockFundsTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto._transaction, dto.meta) {
    mosaic = Mosaic(MosaicId.fromUint64(dto._transaction._assetId.toUint64()), dto._transaction._amount.toUint64());
    duration = dto._transaction._duration.toUint64();
    signedTransaction = SignedTransaction(0x4148, '', dto._transaction._hash);
  }

  Mosaic mosaic;
  Uint64 duration;
  SignedTransaction signedTransaction;

  int get size => _size();

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_absToString()}\n'
      '\t"mosaic": $mosaic,\n'
      '\t"duration": $duration,\n'
      '\t"signedTxHash": ${signedTransaction.hash},\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['mosaic'] = mosaic;
    data['duration'] = duration;
    data['signedTransaction'] = signedTransaction;

    return data;
  }

  @override
  int _size() => lockSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(mosaic.assetId.toIntArray());

    final maV = builder.writeListUint32(mosaic.amount.toIntArray());

    final dV = builder.writeListUint32(duration.toIntArray());

    final h = hex.decode(signedTransaction.hash);

    final hV = builder.writeListUint8(h);

    final vectors = _generateVector(builder);

    final txnBuilder = LockFundsTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addDurationOffset(dV)
      ..addHashOffset(hV);
    _buildVector(builder, vectors);

    final codedLockFunds = txnBuilder.finish();

    return lockFundsTransactionSchema().serialize(builder.finish(codedLockFunds));
  }
}
