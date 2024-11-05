/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Send mosaics and messages between two accounts.
/// Announce a [TransferTransaction] to send [Mosaic] or [Message] between two [Account].
///
class ManualCallSuperContractTransaction extends AbstractTransaction
    implements Transaction {
  ManualCallSuperContractTransaction.create(
      Deadline deadline,
      this.contractKey,
      this.servicePayments,
      this.fileName,
      this.functionName,
      this.actualArguments,
      this.executionCallPayment,
      this.downloadCallPayment,
      NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.manualCallSuperContract,
            superContractVersion, maxFee) {
    maxFee ??= this.maxFee = calculateFee(size());
  }

  PublicAccount contractKey;
  Uint64 executionCallPayment;
  Uint64 downloadCallPayment;
  String fileName;
  String functionName;
  Uint8List actualArguments;
  List<Mosaic> servicePayments;

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    /*   void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('mosaics', mosaics);
    writeNotNull('recipient', recipient);
    writeNotNull('message', message); */

    return val;
  }

  @override
  int size() =>
      transactionHeaderSize +
      keySize +
      fileNameSize +
      functionNameSize +
      actualArgumentsSize +
      amountSize +
      amountSize +
      servicePaymentsCount;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final mb = List.generate(servicePayments.length, (_) => 0);
    int i = 0;
    for (final mosaic in servicePayments!) {
      final id = builder.writeListUint32(mosaic.assetId!.toIntArray());
      final amount = builder.writeListUint32(mosaic.amount!.toIntArray());

      final ms = $buffer.MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    }

    final contractKeyOffset =
        builder.writeListUint8(HexUtils.hexToBytes(contractKey.publicKey));

    final int? fileNameSizeOffset = builder.writeListUint8();

    final int? functionNameSizeOffset = builder.writeListUint8();

    final int? actualArgumentSizeOffset = builder.writeListUint8();

    final int? executionCallPaymentOffset =
        builder.writeListUint32(executionCallPayment.toIntArray());

    final int? downloadCallPaymentOffset =
        builder.writeListUint32(downloadCallPayment.toIntArray());

    /*  final int? fileNameOffset =

    final int? functionNameOffset =  */

    final int? actualArgumentsOffset = builder.writeListUint8(actualArguments);

    final int? servicePaymentsOffset = builder.writeList(mb);

    final vectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.ManualCallTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addContractKeyOffset(contractKeyOffset)
      ..addFileNameSizeOffset(fileNameSizeOffset)
      ..addFunctionNameSizeOffset(functionNameSizeOffset)
      ..addActualArgumentsSizeOffset(actualArgumentSizeOffset)
      ..addExecutionCallPaymentOffset(executionCallPaymentOffset)
      ..addDownloadCallPaymentOffset(downloadCallPaymentOffset)
      ..addServicePaymentsCount(servicePayments.length)
      ..addFileNameOffset(fileNameOffset)
      ..addFunctionNameOffset(functionNameOffset)
      ..addActualArgumentsOffset(actualArgumentsOffset)
      ..addServicePaymentsOffset(servicePaymentsOffset);
    _buildCommonVector(builder, vectors);

    final codedManualCallTxn = txnBuilder.finish();
    builder.finish(codedManualCallTxn);
    return manualCallTransactionSchema().serialize(builder.buffer);
  }

  @override
  TransactionType entityType() => type;
}
