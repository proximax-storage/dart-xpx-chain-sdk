/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// A deposit before announcing aggregate bonded transactions.
/// Alias: LockFundsTransaction
///
class LockFundsTransaction extends AbstractTransaction implements Transaction {
  LockFundsTransaction._(
      Deadline deadline, this.mosaic, this.duration, this.signedTransaction, NetworkType networkType, Uint64? maxFee)
      : super(networkType, deadline, TransactionType.lock, lockVersion, maxFee);

  factory LockFundsTransaction.create(
      Deadline deadline, Mosaic mosaic, Uint64 duration, SignedTransaction signedTx, NetworkType networkType,
      [Uint64? maxFee]) {
    if (signedTx.transactionType != TransactionType.aggregateBonded) {
      throw errEmptyModifications;
    } else {
      return LockFundsTransaction._(deadline, mosaic, duration, signedTx, networkType, maxFee);
    }
  }

  LockFundsTransaction.fromDTO(LockFundsTransactionInfoDTO dto) : super.fromDto(dto.transaction!, dto.meta!) {
    mosaic = Mosaic(MosaicId(dto.transaction!.assetId!.toUint64()), dto.transaction!.amount!.toUint64());
    duration = dto.transaction!.duration!.toUint64();
    signedTransaction = SignedTransaction(TransactionType.lock, '', dto.transaction!.hash!);
  }

  Mosaic? mosaic;
  Uint64? duration;
  SignedTransaction? signedTransaction;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());
    val['mosaic'] = mosaic;
    val['duration'] = duration;
    val['signedTransaction'] = signedTransaction;

    return val;
  }

  @override
  int size() => lockSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mosaicIdOffset = builder.writeListUint32(mosaic!.assetId!.toIntArray());
    final mosaicAmountOffset = builder.writeListUint32(mosaic!.amount!.toIntArray());
    final durationOffset = builder.writeListUint32(duration!.toIntArray());

    final List<int> h = hex.decode(signedTransaction!.hash);

    final hashOffset = builder.writeListUint8(h);

    final commonVectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.LockFundsTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addMosaicIdOffset(mosaicIdOffset)
      ..addMosaicAmountOffset(mosaicAmountOffset)
      ..addDurationOffset(durationOffset)
      ..addHashOffset(hashOffset);
    _buildCommonVector(builder, commonVectors);

    final codedLockFunds = txnBuilder.finish();
    builder.finish(codedLockFunds);
    return lockFundsTransactionSchema().serialize(builder.buffer);
  }
}
