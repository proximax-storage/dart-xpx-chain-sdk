/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class AbstractTransaction with TransactionInfo {
  AbstractTransaction(
    this.networkType,
    this.deadline,
    this.type,
    this.version,
    this.maxFee, [
    this.signature,
    this.signer,
  ]);

  AbstractTransaction.fromDto(AbstractTransactionDTO absValue, MetaTransactionDTO metaValue) {
    networkType = NetworkType.fromInt(extractNetworkType(absValue.version!));
    deadline = Deadline.fromUInt64DTO(absValue.deadline!);
    type = TransactionType.fromInt(absValue.type);
    version = extractVersion(absValue.version!);
    signature = absValue.signature;
    signer = PublicAccount.fromPublicKey(absValue.signer, networkType);
    maxFee = absValue.fee!.toUint64();
    _generateMeta(metaValue);
  }

  late final NetworkType networkType;
  late final Deadline deadline;
  late final TransactionType type;
  late final int version;
  Uint64? maxFee;
  String? signature;
  PublicAccount? signer;

  PublicAccount? get toAggregate => signer;

  set toAggregate(PublicAccount? signer) => this.signer = signer;

  void _generateMeta(MetaTransactionDTO dto) {
    height = dto.height!.toUint64();
    index = dto.index;
    id = dto.id;
    transactionHash = dto.hash;
    merkleComponentHash = dto.merkleComponentHash;
    aggregateHash = dto.aggregateHash;
    aggregateId = dto.aggregateId;
  }

  Map<String, int> _generateCommonVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType.identifier << 24) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['deadlineV'] = builder.writeListUint32(Uint64(deadline.toBlockchainTimestamp()).toIntArray());
    data['feeV'] = builder.writeListUint32(maxFee != null ? maxFee!.toIntArray() : [0, 0]);
    return data;
  }

  void _buildCommonVector(fb.Builder builder, Map<String, int> vector) {
    $txn_buffer.TransactionsBuffer(builder)
      ..addSignatureOffset(vector['signatureV']!)
      ..addSignerOffset(vector['signerV']!)
      ..addVersion(vector['versionV']!)
      ..addType(type.value)
      ..addFeeOffset(vector['feeV']!)
      ..addDeadlineOffset(vector['deadlineV']!);
  }

  AbstractTransaction _absTransaction() => this;

  bool isUnconfirmed() => height!.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height!.toInt() > 0;

  bool hasMissingSignatures() => height!.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _absToString();

  String _absToString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() => _absToJson();

  Map<String, dynamic> _absToJson() {
    final Map<String, dynamic> val = {
      'networkType': networkType,
      'type': type,
      'version': version,
      'deadline': deadline,
    }..addAll(_transactionInfoToJson());

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('maxFee', maxFee);
    writeNotNull('signature', signature);
    writeNotNull('signer', signer);

    return val;
  }
}
