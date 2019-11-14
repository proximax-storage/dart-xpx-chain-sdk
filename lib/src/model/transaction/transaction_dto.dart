part of xpx_chain_sdk;

class _AbstractTransactionDTO {
  int _type;
  int _version;
  UInt64DTO _fee;
  UInt64DTO _deadline;
  String _signature;
  String _signer;

  Map<String, dynamic> toJson() => {
        'signature': _signature,
        'signer': _signer,
        'version': _version,
        'type': _type,
        'maxFee': _fee,
        'deadline': _deadline,
      };
}

// Message
class _MessageDTO {
  _MessageDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _type = json['type'];
    _payload = json['payload'];
  }

  int _type;
  String _payload;

  Map<String, dynamic> toJson() => {'type': _type, 'tayload': _payload};
}

class _TransferTransactionInfoDTO {
  _TransferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;
    _transaction = json['transaction'] != null
        ? _TransferTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _TransferTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_meta != null) {
      data['meta'] = _meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _AggregateTransactionInfoDTO {
  _AggregateTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _AggregateTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _AggregateTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_meta != null) {
      data['meta'] = _meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _MetaTransactionDTO {
  _MetaTransactionDTO(
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

  _MetaTransactionDTO.fromJson(Map<String, dynamic> json) {
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
    _signature = signature;
    _signer = signer;
  }

  _AggregateTransactionCosignatureDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
  }

  String _signature;
  String _signer;

  static List<_AggregateTransactionCosignatureDTO> listFromJson(
          List<dynamic> json) =>
      json == null
          ? null
          : json
              .map((value) =>
                  _AggregateTransactionCosignatureDTO.fromJson(value))
              .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = _signature;
    data['signer'] = _signer;
    return data;
  }
}

class _MultisigCosignatoryModificationDTO {
  _MultisigCosignatoryModificationDTO(this._type, this._cosignatoryPublicKey);

  _MultisigCosignatoryModificationDTO.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _cosignatoryPublicKey = json['cosignatoryPublicKey'];
  }

  int _type;
  String _cosignatoryPublicKey;

  static List<_MultisigCosignatoryModificationDTO> listFromJson(
          List<dynamic> json) =>
      json == null
          ? null
          : json
              .map((value) =>
                  _MultisigCosignatoryModificationDTO.fromJson(value))
              .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = _type;
    data['cosignatoryPublicKey'] = _cosignatoryPublicKey;
    return data;
  }
}

class _ModifyMultisigAccountTransactionInfoDTO {
  _ModifyMultisigAccountTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _ModifyMultisigAccountTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _ModifyMultisigAccountTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_meta != null) {
      data['meta'] = _meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _LockFundsTransactionInfoDTO {
  _LockFundsTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _LockFundsTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _LockFundsTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_meta != null) {
      data['meta'] = _meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _TransferTransactionDTO extends _AbstractTransactionDTO {
  _TransferTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      String recipient,
      List<_MosaicDTO> mosaics,
      _MessageDTO message}) {
    _signature = signature;
    _signer = signer;
    _version = version;
    _type = type;
    _fee = UInt64DTO.fromJson(maxFee);
    _deadline = UInt64DTO.fromJson(deadline);
    _recipient = recipient;
    _mosaics = mosaics;
    _message = message;
  }

  _TransferTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _recipient = json['recipient'];

    if (json['mosaics'] != null) {
      final List<_MosaicDTO> mosaics = [];
      json['mosaics'].forEach((value) {
        mosaics.add(_MosaicDTO.fromJson(value));
      });
      _mosaics = mosaics;
    }
    _message =
        json['message'] != null ? _MessageDTO.fromJson(json['message']) : null;
  }

  String _recipient;
  List<_MosaicDTO> _mosaics;
  _MessageDTO _message;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = _signature;
    data['signer'] = _signer;
    data['version'] = _version;
    data['type'] = _type;
    data['maxFee'] = _fee;
    data['deadline'] = _deadline;
    data['recipient'] = _recipient;
    if (_mosaics != null) {
      data['mosaics'] = _mosaics.map((v) => v.toJson()).toList();
    }
    data['message'] = _message;
    return data;
  }
}

class _AggregateTransactionDTO extends _AbstractTransactionDTO {
  _AggregateTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      List<_AggregateTransactionCosignatureDTO> cosignatures,
      List<dynamic> transactions}) {
    _signature = signature;
    _signer = signer;
    _version = version;
    _type = type;
    _fee = UInt64DTO.fromJson(maxFee);
    _deadline = UInt64DTO.fromJson(deadline);
    _cosignatures = cosignatures;
    _transactions = transactions;
  }

  _AggregateTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _cosignatures =
        _AggregateTransactionCosignatureDTO.listFromJson(json['cosignatures']);
    _transactions = _txnDeserialize(json['transactions'], 'List<Transaction>');
  }

  List<_AggregateTransactionCosignatureDTO> _cosignatures;
  List<dynamic> _transactions;

  @override
  Map<String, dynamic> toJson() => {
        'signature': _signature,
        'signer': _signer,
        'version': _version,
        'type': _type,
        'maxFee': _fee,
        'deadline': _deadline,
        'cosignatures': _cosignatures,
        'transactions': _transactions,
      };
}

class _ModifyMultisigAccountTransactionDTO extends _AbstractTransactionDTO {
  _ModifyMultisigAccountTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _modifications =
        _MultisigCosignatoryModificationDTO.listFromJson(json['modifications']);
    _minApprovalDelta = json['minApprovalDelta'];
    _minRemovalDelta = json['minRemovalDelta'];
  }

  int _minApprovalDelta;
  int _minRemovalDelta;
  List<_MultisigCosignatoryModificationDTO> _modifications;

  List<dynamic> _transactions;

  @override
  Map<String, dynamic> toJson() => {
        'signature': _signature,
        'signer': _signer,
        'version': _version,
        'type': _type,
        'maxFee': _fee,
        'deadline': _deadline,
        'minApprovalDelta': _minApprovalDelta,
        'minRemovalDelta': _minRemovalDelta,
        'modifications': _modifications,
      };
}

class _LockFundsTransactionDTO extends _AbstractTransactionDTO {
  _LockFundsTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _mosaic = UInt64DTO.fromJson(json['mosaicId']);
    _amount = UInt64DTO.fromJson(json['amount']);
    _duration = UInt64DTO.fromJson(json['duration']);
    _hash = json['hash'];
  }

  UInt64DTO _mosaic;
  UInt64DTO _amount;
  UInt64DTO _duration;
  String _hash;

  List<dynamic> _transactions;

  @override
  Map<String, dynamic> toJson() => {
        'signature': _signature,
        'signer': _signer,
        'version': _version,
        'type': _type,
        'maxFee': _fee,
        'deadline': _deadline,
        'mosaic': _mosaic,
        'amount': _amount,
        'duration': _duration,
        'hash': _hash,
      };
}
