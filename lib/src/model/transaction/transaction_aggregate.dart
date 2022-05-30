/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Aggregate Complete send transactions in batches to different [Account].
/// Aggregate Bonded propose many transactions between different [Account].
///
class AggregateTransaction extends AbstractTransaction implements Transaction {
  factory AggregateTransaction.bonded(Deadline deadline,
          List<Transaction> innerTxs, NetworkType networkType,
          [Uint64? maxFee]) =>
      AggregateTransaction._(deadline, innerTxs, networkType,
          aggregateBondedVersion, TransactionType.aggregateBonded, maxFee);

  factory AggregateTransaction.complete(Deadline deadline,
          List<Transaction> innerTxs, NetworkType networkType,
          [Uint64? maxFee]) =>
      AggregateTransaction._(
          deadline,
          innerTxs,
          networkType,
          aggregateCompletedVersion,
          TransactionType.aggregateCompleted,
          maxFee);

  AggregateTransaction._(Deadline deadline, List<Transaction> innerTxs,
      NetworkType networkType, int version, TransactionType type,
      [Uint64? maxFee])
      : super(networkType, deadline, type, version, maxFee) {
    if (innerTxs.isEmpty) {
      throw errNullInnerTransactions;
    } else {
      innerTransactions = innerTxs;
    }
  }

  AggregateTransaction.fromDTO(AggregateTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    if (dto.transaction!.transactions.isNotEmpty) {
      innerTransactions =
          dto.transaction!.transactions.map(deserializeDTO).toList();
    }
    cosignatures = AggregateTransactionCosignature.listFromDTO(
        networkType.identifier, dto.transaction!.cosignatures);
  }

  List<Transaction?> innerTransactions = [];
  List<AggregateTransactionCosignature>? cosignatures;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    if (innerTransactions.isNotEmpty) {
      writeNotNull('innerTransactions', innerTransactions);
    }
    writeNotNull('cosignatures', cosignatures);

    return val;
  }

  @override
  int size() {
    int sizeOfInnerTransactions = 0;
    for (final itx in innerTransactions) {
      sizeOfInnerTransactions +=
          itx!.size() - signatureSize - maxFeeSize - deadLineSize;
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
      final txb = toAggregateTransactionBytes(itx!);
      txsBytes.addAll(txb);
    }

    final tV = builder.writeListUint8(Uint8List.fromList(txsBytes));

    final vector = _generateCommonVector(builder);

    final txnBuilder = $buffer.AggregateTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addTransactionsSize(txsBytes.length)
      ..addTransactionsOffset(tV);
    _buildCommonVector(builder, vector);

    final codedAggregate = txnBuilder.finish();
    builder.finish(codedAggregate);
    return aggregateTransactionSchema().serialize(builder.buffer);
  }
}

/// AggregateTransactionCosignature
class AggregateTransactionCosignature {
  AggregateTransactionCosignature(this.signature, this.signer);

  AggregateTransactionCosignature.fromDTO(
      int networkTypeInt, AggregateTransactionCosignatureDTO dto) {
    if (dto.signer == null) {
      return;
    }

    signature = dto.signature;
    signer = PublicAccount.fromPublicKey(
        dto.signer, NetworkType.fromInt(networkTypeInt));
  }

  String? signature;
  PublicAccount? signer;

  @override
  String toString() => encoder.convert(this);

  static List<AggregateTransactionCosignature> listFromDTO(
          int? networkType, List<AggregateTransactionCosignatureDTO>? json) =>
      json == null
          ? <AggregateTransactionCosignature>[]
          : json
              .map((value) =>
                  AggregateTransactionCosignature.fromDTO(networkType!, value))
              .toList();

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
  CosignatureTransaction(this._transactionToCosign);

  final AggregateTransaction _transactionToCosign;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionToCosign'] = _transactionToCosign;
    return data;
  }
}
