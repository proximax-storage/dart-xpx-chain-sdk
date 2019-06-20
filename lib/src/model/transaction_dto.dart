part of xpx_chain_sdk;

class _AbstractTransactionDTO {
  int type;
  int version;
  UInt64DTO fee;
  UInt64DTO deadline;
  String signature;
  String signer;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;
    return data;
  }
}

// Message
class _MessageDTO {
  _MessageDTO({int type, String payload}) {
    this._type = type;
    this._payload = payload;
  }

  _MessageDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    _type = json['type'] as int;
    _payload = json['payload'] as String;
  }

  int _type;
  String _payload;

  int get type => _type;
  set type(int type) => _type = type;
  String get payload => _payload;
  set payload(String payload) => _payload = payload;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = this._type;
    data['tayload'] = this._payload;
    return data;
  }
}

class _TransferTransactionInfoDTO {
  _TransferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ?  _MetaTransactionDTO.fromJson(json['meta'] as Map<String, dynamic>)
        : null;
    _transaction = json['transaction'] != null
        ?  _TransferTransactionDTO.fromJson(
            json['transaction'] as Map<String, dynamic>)
        : null;
  }

  _MetaTransactionDTO _meta;
  _TransferTransactionDTO _transaction;

  _MetaTransactionDTO get meta => _meta;
  set meta(_MetaTransactionDTO meta) => _meta = meta;
  _TransferTransactionDTO get transaction => _transaction;
  set transaction(_TransferTransactionDTO transaction) =>
      _transaction = transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    if (this._transaction != null) {
      data['transaction'] = this._transaction.toJson();
    }
    return data;
  }
}

class _AggregateTransactionInfoDTO {
  _AggregateTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ?  _MetaTransactionDTO.fromJson(json['meta'] as Map<String, dynamic>)
        : null;

    _transaction = json['transaction'] != null
        ?  _AggregateTransactionDTO.fromJson(
            json['transaction'] as Map<String, dynamic>)
        : null;
  }

  _MetaTransactionDTO _meta;
  _AggregateTransactionDTO _transaction;

  _MetaTransactionDTO get meta => _meta;
  set meta(_MetaTransactionDTO meta) => _meta = meta;
  _AggregateTransactionDTO get transaction => _transaction;
  set transaction(_AggregateTransactionDTO transaction) =>
      _transaction = transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    if (this._transaction != null) {
      data['transaction'] = this._transaction.toJson();
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
    this._height = UInt64DTO.fromJson(height);
    this._hash = hash;
    this._merkleComponentHash = merkleComponentHash;
    this._index = index;
    this._id = id;
  }

  _MetaTransactionDTO.fromJson(Map<String, dynamic> json) {
    _height = UInt64DTO.fromJson(json['height']);
    _hash = json['hash'] as String;
    _merkleComponentHash = json['merkleComponentHash'] as String;
    _index = json['index'] as int;
    _id = json['id'] as String;
  }

  UInt64DTO _height;
  String _hash;
  String _merkleComponentHash;
  int _index;
  String _id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['height'] = this._height;
    data['hash'] = this._hash;
    data['merkleComponentHash'] = this._merkleComponentHash;
    data['index'] = this._index;
    data['id'] = this._id;
    return data;
  }
}

class _AggregateTransactionCosignatureDTO {
  _AggregateTransactionCosignatureDTO({String signature, String signer}) {
    this._signature = signature;
    this._signer = signer;
  }

  _AggregateTransactionCosignatureDTO.fromJson(Map<String, dynamic> json) {
    this._signature = json['signature'] as String;
    this._signer = json['signer'] as String;
  }

  String _signature;
  String _signer;

  static List<_AggregateTransactionCosignatureDTO> listFromJson(
      List<dynamic> json) {
    return json == null
        ?  List<_AggregateTransactionCosignatureDTO>()
        : json
            .map((dynamic value) =>
                 _AggregateTransactionCosignatureDTO.fromJson(
                    value as Map<String, dynamic>))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this._signature;
    data['signer'] = this._signer;
    return data;
  }
}

class _MultisigCosignatoryModificationDTO {
  _MultisigCosignatoryModificationDTO(
      {_AggregateTransactionCosignatureDTO type, String cosignatoryPublicKey}) {
    this._type = type;
    this._cosignatoryPublicKey = cosignatoryPublicKey;
  }

  _MultisigCosignatoryModificationDTO.fromJson(Map<String, dynamic> json) {
    this._type = json['type'] as _AggregateTransactionCosignatureDTO;
    this._cosignatoryPublicKey = json['cosignatoryPublicKey'] as String;
  }

  _AggregateTransactionCosignatureDTO _type;
  String _cosignatoryPublicKey;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = this._type;
    data['cosignatoryPublicKey'] = this._cosignatoryPublicKey;
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
    this.fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    this._recipient = recipient;
    this._mosaics = mosaics;
    this._message = message;
  }

  _TransferTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.signature = json['signature'] as String;
    this.signer = json['signer'] as String;
    this.version = json['version'] as int;
    this.type = json['type'] as int;
    this.fee = UInt64DTO.fromJson(json['maxFee']);
    this.deadline = UInt64DTO.fromJson(json['deadline']);
    _recipient = json['recipient'] as String;

    if (json['mosaics'] != null) {
      _mosaics =  List<_MosaicDTO>();
      json['mosaics'].forEach((dynamic value) {
        _mosaics.add( _MosaicDTO.fromJson(value as Map<String, dynamic>));
      });
    }
    this._message =
        _MessageDTO.fromJson(json['message'] as Map<String, dynamic>);
  }

  String _recipient;
  List<_MosaicDTO> _mosaics;
  _MessageDTO _message;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;
    data['recipient'] = this._recipient;
    if (this._mosaics != null) {
      data['mosaics'] = this._mosaics.map((v) => v.toJson()).toList();
    }
    data['message'] = this._message;
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
    this.fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    this._cosignatures = cosignatures;
    this._transactions = transactions;
  }

  _AggregateTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.signature = json['signature'] as String;
    this.signer = json['signer'] as String;
    this.version = json['version'] as int;
    this.type = json['type'] as int;
    this.fee = UInt64DTO.fromJson(json['maxFee']);
    this.deadline = UInt64DTO.fromJson(json['deadline']);
    this._cosignatures = _AggregateTransactionCosignatureDTO.listFromJson(
        json['cosignatures'] as List<dynamic>);
    this._transactions =
        _txnDeserialize(json['transactions'], 'List<Transaction>') as List;
  }

  List<_AggregateTransactionCosignatureDTO> _cosignatures;
  List<dynamic> _transactions;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;
    data['cosignatures'] = this._cosignatures;
    data['transactions'] = this._transactions;
    return data;
  }
}
