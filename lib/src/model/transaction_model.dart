part of xpx_catapult_sdk;

var transactionTypes = <_transactionTypeClass>{
  _transactionTypeClass(TransactionType.AggregateCompleted, 16705, 0x4141),
  _transactionTypeClass(TransactionType.AggregateBonded, 16961, 0x4241),
  _transactionTypeClass(TransactionType.MetadataAddress, 16701, 0x413d),
  _transactionTypeClass(TransactionType.MetadataMosaic, 16957, 0x423d),
  _transactionTypeClass(TransactionType.MetadataNamespace, 17213, 0x433d),
  _transactionTypeClass(TransactionType.MosaicDefinition, 17230, 0x414d),
  _transactionTypeClass(TransactionType.MosaicAlias, 16717, 0x434e),
  _transactionTypeClass(TransactionType.MosaicSupplyChange, 16973, 0x424d),
  _transactionTypeClass(TransactionType.ModifyMultisig, 16725, 0x4155),
  _transactionTypeClass(TransactionType.ModifyContract, 16727, 0x4157),
  _transactionTypeClass(TransactionType.RegisterNamespace, 16718, 0x414e),
  _transactionTypeClass(TransactionType.Transfer, 16724, 0x4154),
  _transactionTypeClass(TransactionType.Lock, 16712, 0x4148),
  _transactionTypeClass(TransactionType.SecretLock, 16722, 0x4152),
  _transactionTypeClass(TransactionType.SecretProof, 16978, 0x4252),
};

// TransactionType enums
enum TransactionType {
  AggregateCompleted,
  AggregateBonded,
  MetadataAddress,
  MetadataMosaic,
  MetadataNamespace,
  MosaicDefinition,
  MosaicSupplyChange,
  ModifyMultisig,
  ModifyContract,
  RegisterNamespace,
  Transfer,
  Lock,
  SecretLock,
  SecretProof,
  MosaicAlias
}

_transactionTypeClass TransactionTypeFromRaw(int value) {
  for (var t in transactionTypes) {
    if (t.raw == value) {
      return t;
    }
  }
  return null;
}

String MapTransaction(dynamic decodedJson) {
  final rawT = decodedJson["transaction"]["type"];

  final t = TransactionTypeFromRaw(rawT).transactionType;

  switch (t) {
    case TransactionType.AggregateCompleted:
      return ("AggregateCompleted");
    case TransactionType.AggregateBonded:
      return ("AggregateBonded");
    case TransactionType.MetadataAddress:
      return ("MetadataAddress");
    case TransactionType.MetadataMosaic:
      return ("MetadataMosaic");
    case TransactionType.MetadataNamespace:
      return ("MetadataNamespace");
    case TransactionType.MosaicDefinition:
      return ("MosaicDefinition");
    case TransactionType.MosaicAlias:
      return ("MosaicAlias");
    case TransactionType.MosaicSupplyChange:
      return ("MosaicSupplyChange");
    case TransactionType.ModifyMultisig:
      return ("ModifyMultisig");
    case TransactionType.ModifyContract:
      return ("ModifyContract");
    case TransactionType.RegisterNamespace:
      return ("RegisterNamespace");
    case TransactionType.Transfer:
      return ("Transfer");
    case TransactionType.Lock:
      return ("Lock");
    case TransactionType.SecretLock:
      return ("SecretLock");
    case TransactionType.SecretProof:
      return ("SecretProof");
    default:
      return ("NULL");
  }
}

class _transactionTypeClass {
  TransactionType _transactionType;
  int _raw;
  int _hex;

  TransactionType get transactionType => this._transactionType;
  int get raw => this._raw;
  int get hex => this._hex;

  _transactionTypeClass([this._transactionType, this._raw, this._hex]);
}

// Transaction Info
abstract class TransactionInfo {
  BigInt _height;
  int _index;
  String _id;
  String _hash;
  String _merkleComponentHash;

  get height => _height;

  get index => _index;

  get id => _id;

  get hash => _hash;

  get merkleComponentHash => _merkleComponentHash;

  TransactionInfo(this._height, this._index, this._id, this._hash,
      this._merkleComponentHash);

  @override
  String toString() {
    return '{\n'
        '\t"Height": $_height,\n'
        '\t"Index": $_index,\n'
        '\t"Id": $_id,\n'
        '\t"Hash": $_hash,\n'
        '\t"MerkleComponentHash": $_merkleComponentHash\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    return {
      'height': _height,
      'index': _index,
      'id': _id,
      'hash': _hash,
      'merkleComponentHash': merkleComponentHash,
    };
  }
}

abstract class Transaction {
  AbstractTransaction GetAbstractTransaction();
}

class AbstractTransaction extends TransactionInfo {
  int _networkType;
  BigInt _deadline;
  _transactionTypeClass _type;
  int _version;
  BigInt _fee;
  String _signature;
  PublicAccount _signer;

  AbstractTransaction(height, index, id, hash, merkleComponentHash,
      [aggregateHash, aggregateId])
      : super(height, index, id, hash, merkleComponentHash);

  toStringMetaInfo() => super.toString();

  ToAggregate(PublicAccount signer) {
    signer = signer;
  }

  bool IsUnconfirmed() {
    return TransactionInfo != null && this.height.toInt() > 0;
  }

  bool IsConfirmed() {
    return TransactionInfo != null &&
        this.height.toInt() == 0 &&
        this._hash == this.merkleComponentHash;
  }

  bool HasMissingSignatures() {
    return TransactionInfo != null &&
        this.height.toInt() == 0 &&
        this._hash != this.merkleComponentHash;
  }

  bool IsUnannounced() {
    return TransactionInfo == null;
  }

  @override
  String toString() {
    return '{\n'
        '\t"NetworkType": $_networkType,\n'
        '\t"TransactionInfo": ${toStringMetaInfo()},\n'
        '\t"Type": ${transactionTypes.lookup(_type)._raw},\n'
        '\t"Version": $_version,\n'
        '\t"Fee": $_fee,\n'
        '\t"Deadline": $_deadline,\n'
        '\t"Signature": $_signature,\n'
        '\t"Signer": $_signer\n'
        '}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'networkType': _networkType,
      'transactionInfo': toStringMetaInfo(),
      'type': transactionTypes.lookup(_type)._raw,
      'version': _version,
      'fee': _fee,
      'deadline': _deadline,
      'signature': _signature,
      'signer': _signer,
    };
  }
}

class TransferTransaction extends AbstractTransaction implements Transaction {
  AbstractTransaction _abs;
  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  @override
  AbstractTransaction GetAbstractTransaction() {
    return _abs;
  }

  // ignore: missing_return
  TransferTransaction.fromDTO(_transferTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;
    _abs = AbstractTransaction(
        this.height, this.index, this.id, this.hash, this.merkleComponentHash);

    _abs._type = TransactionTypeFromRaw(value._transaction.Type);
    _abs._deadline = value._transaction.Deadline.toBigInt();
    _abs._signature = value._transaction.Signature;
    _abs._networkType = ExtractNetworkType(value._transaction.Version);
    _abs._version = ExtractVersion(value._transaction.Version);
    _abs._fee = value._transaction.Fee.toBigInt();
    _abs._signer =
        NewAccountFromPublicKey(value._transaction.Signer, _abs._networkType);
    List<Mosaic> m = new List(value._transaction._mosaics.length);
    for (var i = 0; i < value._transaction._mosaics.length; i++) {
      m[i] = new Mosaic.fromDTO(value._transaction._mosaics[i]);
    }
    mosaics = m;
    recipient = NewAddressFromEncoded(value._transaction._recipient);
    message = Message.fromDTO(value._transaction._message);
  }

  @override
  String toString() {
    return '"abstractTransaction":${_abs},\n'
        ' "mosaics":${this.mosaics.map((v) => v.toJson()).toList()},\n'
        ' "message":${message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abs.toJson();
    if (this.mosaics != null) {
      data['mosaics'] = this.mosaics.map((v) => v.toJson()).toList();
    }
    data['recipient'] = recipient?.toJson();
    data['message'] = message;
    return data;
  }
}

// Message
class Message {
  int _type;
  String _payload;

  Message({int type, String payload}) {
    this._type = type;
    this._payload = payload;
  }

  int get type => _type;
  set type(int type) => _type = type;
  String get payload => _payload;
  set payload(String payload) => _payload = payload;

  Message.fromDTO(_messageDTO value) {
    if (value?._payload == null) {
      return;
    }

    var b = HEX.decode(value._payload);

    _type = value._type;
    _payload = b.toString();
  }

  @override
  String toString() {
    return '${toJson()}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this._type;
    data['Payload'] = this._payload;
    return data;
  }
}
