/*
 * Copyright 2024 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Manual call a supercontract function.
/// Announce a [ManualCallSuperContractTransaction] to call a function along with arguments.
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
            manualCallVersion, maxFee) {
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
      servicePaymentsCount +
      fileName.length + 
      functionName.length +
      actualArguments.length +
      (mosaicIdSize + amountSize) * servicePayments.length;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics vector
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

    final servicePaymentsOffset = builder.writeList(mb);

    final contractKeyOffset =
        builder.writeListUint8(HexUtils.hexToBytes(contractKey.publicKey));

    final executionCallPaymentOffset =
        builder.writeListUint32(executionCallPayment.toIntArray());

    final downloadCallPaymentOffset =
        builder.writeListUint32(downloadCallPayment.toIntArray());

    final String fileNameHex = HexUtils.utf8ToHex(fileName);
    final Uint8List fileNameUint8List = HexUtils.hexToBytes(fileNameHex);
    final int fileNameOffset = builder.writeListUint8(fileNameUint8List);
    
    final String functionNameHex = HexUtils.utf8ToHex(functionName);
    final Uint8List functionNameUint8List = HexUtils.hexToBytes(functionNameHex);
    final int functionNameOffset = builder.writeListUint8(functionNameUint8List);

    final int actualArgumentsOffset = builder.writeListUint8(actualArguments);

    final vectors = _generateCommonVector(builder);

    final fileNameSizeUint8List = Uint8List(2)..buffer.asInt16List()[0] = fileNameUint8List.length;//fileNameUint8List.length.;
    final functionNameSizeUint8List = Uint8List(2)..buffer.asInt16List()[0] = functionNameUint8List.length; 
    final actualArgumentsSizeUint8List = Uint8List(2)..buffer.asInt16List()[0] = actualArguments.length;

    final fileNameSizeOffset =
        builder.writeListUint8(fileNameSizeUint8List);

    final functionNameSizeOffset =
        builder.writeListUint8(functionNameSizeUint8List);

    final actualArgumentsSizeOffset =
        builder.writeListUint8(actualArgumentsSizeUint8List);

    final txnBuilder = $buffer.ManualCallTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addContractKeyOffset(contractKeyOffset)
      ..addFileNameSizeOffset(fileNameSizeOffset)
      ..addFunctionNameSizeOffset(functionNameSizeOffset)
      ..addActualArgumentsSizeOffset(actualArgumentsSizeOffset)
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
