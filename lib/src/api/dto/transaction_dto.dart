/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class AbstractTransactionDTO {
  int? type;
  int? version;
  UInt64DTO? fee;
  UInt64DTO? deadline;
  String? signature;
  String? signer;

  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
      };
}

class TransferTransactionInfoDTO {
  TransferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? TransferTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  TransferTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class AggregateTransactionInfoDTO {
  AggregateTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? AggregateTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  AggregateTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class MetaTransactionDTO {
  MetaTransactionDTO(
      {List<int>? height,
      String? hash,
      String? merkleComponentHash,
      int? index,
      String? id,
      String? aggregateHash,
      String? aggregateId}) {
    height = height;
    hash = hash;
    merkleComponentHash = merkleComponentHash;
    index = index;
    id = id;
    aggregateHash = aggregateHash;
    aggregateId = aggregateId;
  }

  MetaTransactionDTO.fromJson(Map<String, dynamic> json) {
    height = UInt64DTO.fromJson(json['height']);
    hash = json['hash'];
    merkleComponentHash = json['merkleComponentHash'];
    index = json['index'];
    id = json['id'];
    aggregateHash = json['aggregateHash'];
    aggregateId = json['aggregateId'];
  }

  UInt64DTO? height;
  String? hash;
  String? merkleComponentHash;
  int? index;
  String? id;
  String? aggregateHash;
  String? aggregateId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['hash'] = hash;
    data['merkleComponentHash'] = merkleComponentHash;
    data['index'] = index;
    data['id'] = id;
    return data;
  }
}

class AggregateTransactionCosignatureDTO {
  AggregateTransactionCosignatureDTO({String? signature, String? signer}) {
    signature = signature;
    signer = signer;
  }

  AggregateTransactionCosignatureDTO.fromJson(Map json) {
    signature = json['signature'];
    signer = json['signer'];
  }

  String? signature;
  String? signer;

  static List<AggregateTransactionCosignatureDTO> listFromJson(List<Map> json) => json.isEmpty
      ? <AggregateTransactionCosignatureDTO>[]
      : json.map(AggregateTransactionCosignatureDTO.fromJson).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}

class LockFundsTransactionInfoDTO {
  LockFundsTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null ? LockFundsTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  LockFundsTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class TransferTransactionDTO extends AbstractTransactionDTO {
  TransferTransactionDTO(
      {String? signature,
      String? signer,
      int? version,
      int? type,
      List<int>? maxFee,
      List<int>? deadline,
      String? recipient,
      List<MosaicDTO>? mosaics,
      MessageDTO? message}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    recipient = recipient;
    mosaics = mosaics;
    message = message;
  }

  TransferTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    recipient = json['recipient'];

    if (json['mosaics'] != null) {
      final List<MosaicDTO> mosaics = [];
      json['mosaics'].forEach((value) {
        mosaics.add(MosaicDTO.fromJson(value));
      });
      this.mosaics = mosaics;
    }
    message = json['message'] != null ? MessageDTO.fromJson(json['message']) : null;
  }

  String? recipient;
  List<MosaicDTO>? mosaics;
  MessageDTO? message;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['recipient'] = recipient;
    if (mosaics != null) {
      data['mosaics'] = mosaics!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AggregateTransactionDTO extends AbstractTransactionDTO {
  AggregateTransactionDTO(
      {String? signature,
      String? signer,
      int? version,
      int? type,
      List<int>? maxFee,
      List<int>? deadline,
      List<AggregateTransactionCosignatureDTO>? cosignatures,
      List<dynamic>? transactions}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    cosignatures = cosignatures;
    transactions = transactions;
  }

  AggregateTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    cosignatures = AggregateTransactionCosignatureDTO.listFromJson(json['cosignatures'].cast<Map>());
    if (json['transactions'] != null) {
      transactions = txnDeserialize(json['transactions'], 'List<Transaction>');
    }
  }

  List<AggregateTransactionCosignatureDTO>? cosignatures;
  List<dynamic> transactions = [];

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'cosignatures': cosignatures,
        'transactions': transactions,
      };
}

class LockFundsTransactionDTO extends AbstractTransactionDTO {
  LockFundsTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    assetId = UInt64DTO.fromJson(json['mosaicId']);
    amount = UInt64DTO.fromJson(json['amount']);
    duration = UInt64DTO.fromJson(json['duration']);
    hash = json['hash'];
  }

  UInt64DTO? assetId;
  UInt64DTO? amount;
  UInt64DTO? duration;
  String? hash;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'mosaicId': assetId,
        'amount': amount,
        'duration': duration,
        'hash': hash,
      };
}

class MetaDataEntryTransactionDTO extends AbstractTransactionDTO {
  MetaDataEntryTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    targetKey = json['targetKey'] as String;
    scopedMetadataKey = UInt64DTO.fromJson(json['scopedMetadataKey']);
    valueSizeDelta = json['valueSizeDelta'] as int;
    valueSize = json['valueSize'] as int;
    value = json['value'] as String;
    targetMosaicId = UInt64DTO.fromJson(json['targetMosaicId']);
  }

  String? targetKey;
  UInt64DTO? scopedMetadataKey;
  int? valueSizeDelta;
  int? valueSize;
  String? value;
  UInt64DTO? targetMosaicId;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'targetKey': targetKey,
        'scopedMetadataKey': scopedMetadataKey,
        'valueSizeDelta': valueSizeDelta,
        'valueSize': valueSize,
        'value': value,
      };
}

class MetaDataEntryTransactioInfoDTO {
  MetaDataEntryTransactioInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null ? MetaDataEntryTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  MetaDataEntryTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}
