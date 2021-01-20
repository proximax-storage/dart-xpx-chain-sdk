part of xpx_chain_sdk.transaction;

class AbstractTransactionDTO {
  int type;
  int version;
  UInt64DTO fee;
  UInt64DTO deadline;
  String signature;
  String signer;

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
    _transaction = json['transaction'] != null ? _TransferTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  _TransferTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class AggregateTransactionInfoDTO {
  AggregateTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    _transaction = json['transaction'] != null ? _AggregateTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  _AggregateTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class MetaTransactionDTO {
  MetaTransactionDTO(
      {List<int> height,
      String hash,
      String merkleComponentHash,
      int index,
      String id,
      String aggregateHash,
      String aggregateId}) {
    _height = UInt64DTO.fromJson(height);
    _hash = hash;
    _merkleComponentHash = merkleComponentHash;
    _index = index;
    _id = id;
    _aggregateHash = aggregateHash;
    _aggregateId = aggregateId;
  }

  MetaTransactionDTO.fromJson(Map<String, dynamic> json) {
    _height = UInt64DTO.fromJson(json['height']);
    _hash = json['hash'];
    _merkleComponentHash = json['merkleComponentHash'];
    _index = json['index'];
    _id = json['id'];
    _aggregateHash = json['aggregateHash'];
    _aggregateId = json['aggregateId'];
  }

  UInt64DTO _height;
  String _hash;
  String _merkleComponentHash;
  int _index;
  String _id;
  String _aggregateHash;
  String _aggregateId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = _height;
    data['hash'] = _hash;
    data['merkleComponentHash'] = _merkleComponentHash;
    data['index'] = _index;
    data['id'] = _id;
    return data;
  }
}

class _AggregateTransactionCosignatureDTO {
  _AggregateTransactionCosignatureDTO({String signature, String signer}) {
    signature = signature;
    signer = signer;
  }

  _AggregateTransactionCosignatureDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
  }

  String signature;
  String signer;

  static List<_AggregateTransactionCosignatureDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => _AggregateTransactionCosignatureDTO.fromJson(value)).toList();

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

    _transaction = json['transaction'] != null ? LockFundsTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  LockFundsTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _TransferTransactionDTO extends AbstractTransactionDTO {
  _TransferTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      String recipient,
      List<MosaicDTO> mosaics,
      MessageDTO message}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    _recipient = recipient;
    _mosaics = mosaics;
    _message = message;
  }

  _TransferTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    _recipient = json['recipient'];

    if (json['mosaics'] != null) {
      final List<MosaicDTO> mosaics = [];
      json['mosaics'].forEach((value) {
        mosaics.add(MosaicDTO.fromJson(value));
      });
      _mosaics = mosaics;
    }
    _message = json['message'] != null ? MessageDTO.fromJson(json['message']) : null;
  }

  String _recipient;
  List<MosaicDTO> _mosaics;
  MessageDTO _message;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['recipient'] = _recipient;
    if (_mosaics != null) {
      data['mosaics'] = _mosaics.map((v) => v.toJson()).toList();
    }
    data['message'] = _message;
    return data;
  }
}

class _AggregateTransactionDTO extends AbstractTransactionDTO {
  _AggregateTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      List<_AggregateTransactionCosignatureDTO> cosignatures,
      List<dynamic> transactions}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    _cosignatures = cosignatures;
    _transactions = transactions;
  }

  _AggregateTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    _cosignatures = _AggregateTransactionCosignatureDTO.listFromJson(json['cosignatures']);
    _transactions = txnDeserialize(json['transactions'], 'List<Transaction>');
  }

  List<_AggregateTransactionCosignatureDTO> _cosignatures;
  List<dynamic> _transactions;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'cosignatures': _cosignatures,
        'transactions': _transactions,
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
    _assetId = UInt64DTO.fromJson(json['mosaicId']);
    _amount = UInt64DTO.fromJson(json['amount']);
    _duration = UInt64DTO.fromJson(json['duration']);
    _hash = json['hash'];
  }

  UInt64DTO _assetId;
  UInt64DTO _amount;
  UInt64DTO _duration;
  String _hash;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'mosaicId': _assetId,
        'amount': _amount,
        'duration': _duration,
        'hash': _hash,
      };
}
