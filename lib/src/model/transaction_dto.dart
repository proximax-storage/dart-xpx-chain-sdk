part of xpx_chain_sdk;

class _AbstractTransactionDTO {
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

// Message
class _MessageDTO {
  _MessageDTO({int type, String payload}) {
    _type = type;
    _payload = payload;
  }

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
      String id}) {
    _height = UInt64DTO.fromJson(height);
    _hash = hash;
    _merkleComponentHash = merkleComponentHash;
    _index = index;
    _id = id;
  }

  _MetaTransactionDTO.fromJson(Map<String, dynamic> json) {
    _height = UInt64DTO.fromJson(json['height']);
    _hash = json['hash'];
    _merkleComponentHash = json['merkleComponentHash'];
    _index = json['index'];
    _id = json['id'];
  }

  UInt64DTO _height;
  String _hash;
  String _merkleComponentHash;
  int _index;
  String _id;

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
      final List<_MosaicDTO> mosaics = [];
      json['mosaics'].forEach((value) {
        mosaics.add(_MosaicDTO.fromJson(value));
      });
      _mosaics = mosaics;
    }
    _message = _MessageDTO.fromJson(json['message']);
  }

  String _recipient;
  List<_MosaicDTO> _mosaics;
  _MessageDTO _message;

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
    _cosignatures =
        _AggregateTransactionCosignatureDTO.listFromJson(json['cosignatures']);
    _transactions = _txnDeserialize(json['transactions'], 'List<Transaction>');
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
