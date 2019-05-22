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

// TransactionVersion enums
const AggregateCompletedVersion = 2,
    AggregateBondedVersion = 2,
    MetadataAddressVersion = 1,
    MetadataMosaicVersion = 1,
    MetadataNamespaceVersion = 1,
    MosaicDefinitionVersion = 3,
    MosaicSupplyChangeVersion = 2,
    ModifyMultisigVersion = 3,
    ModifyContractVersion = 3,
    RegisterNamespaceVersion = 2,
    TransferVersion = 3,
    LockVersion = 1,
    SecretLockVersion = 1,
    SecretProofVersion = 1;

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

abstract class Transaction {
  AbstractTransaction getAbstractTransaction();
  Uint8List generateBytes();
}

// Transaction Info
class TransactionInfo {
  BigInt height;
  int index;
  String id;
  String hash;
  String merkleComponentHash;

  TransactionInfo getTransactionInfo() {
    final t = TransactionInfo();
    t.height = this.height;
    t.index = this.index;
    t.id = this.id;
    t.hash = this.hash;
    t.merkleComponentHash = this.merkleComponentHash;
    return t;
  }

  String _transactionInfoToString() {
    return '{\n'
        '\t"height": $height,\n'
        '\t"index": $index,\n'
        '\t"id": $id,\n'
        '\t"hash": $hash,\n'
        '\t"merkleComponentHash": $merkleComponentHash\n'
        '\t}';
  }

  @override
  String toString() {
    return _transactionInfoToString();
  }

  Map<String, dynamic> toJson() {
    return _transactionInfoToJson();
  }

  Map<String, dynamic> _transactionInfoToJson() {
    return {
      'height': height,
      'index': index,
      'id': id,
      'hash': hash,
      'merkleComponentHash': merkleComponentHash,
    };
  }
}

class AbstractTransaction with TransactionInfo {
  int networkType;
  Deadline deadline;
  _transactionTypeClass type;
  int version;
  BigInt fee;
  String signature;
  PublicAccount signer;

  AbstractTransaction([height, index, id, hash, merkleComponentHash]) {
    this.height = height;
    this.index = index;
    this.id = id;
    this.hash = hash;
    this.merkleComponentHash = merkleComponentHash;
  }

  Map<String, int> generateVector(Builder builder) {
    final Map<String, int> data = new Map<String, int>();
    data['versionV'] = (this.networkType << 8) + this.version;
    data['signatureV'] = builder.writeListUint8(new Uint8List(64));
    data['signerV'] = builder.writeListUint8(new Uint8List(32));
    data['feeV'] = builder.writeListUint32(fromBigInt(this.fee));
    data['deadlineV'] = builder.writeListUint32(
        fromBigInt(BigInt.from(this.deadline.GetInstant().toInt())));
    return data;
  }

  AbstractTransaction _getAbstractTransaction() {
    final abs = AbstractTransaction();
    abs.height = this.height;
    abs.index = this.index;
    abs.id = this.id;
    abs.hash = this.hash;
    abs.merkleComponentHash = this.merkleComponentHash;
    abs.networkType = this.networkType;
    abs.deadline = this.deadline;
    abs.type = this.type;
    abs.version = this.version;
    abs.fee = this.fee;
    abs.signature = this.signature;
    abs.signer = this.signer;
    return abs;
  }

  void ToAggregate(PublicAccount signer) {
    this.signer = signer;
  }

  bool IsUnconfirmed() {
    return TransactionInfo != null && this.height.toInt() > 0;
  }

  bool IsConfirmed() {
    return TransactionInfo != null &&
        this.height.toInt() == 0 &&
        this.hash == this.merkleComponentHash;
  }

  bool HasMissingSignatures() {
    return TransactionInfo != null &&
        this.height.toInt() == 0 &&
        this.hash != this.merkleComponentHash;
  }

  bool IsUnannounced() {
    return TransactionInfo == null;
  }

  @override
  String toString() {
    return _abstractTransactionToString();
  }

  String _abstractTransactionToString() {
    return '{\n'
        '\t"transactionInfo":${_transactionInfoToString()}\n'
        '\t"networkType": $networkType,\n'
        '\t"type": ${transactionTypes.lookup(type)?._raw},\n'
        '\t"version": $version,\n'
        '\t"fee": $fee,\n'
        '\t"deadline": $deadline,\n'
        '\t"signature": $signature,\n'
        '\t"signer": $signer\n'
        '}';
  }

  Map<String, dynamic> toJson() {
    return _abstractTransactionToJson();
  }

  Map<String, dynamic> _abstractTransactionToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data.addAll(_transactionInfoToJson());
    data['networkType'] = networkType;
    data['type'] = transactionTypes.lookup(type)._raw;
    data['version'] = version;
    data['fee'] = fee;
    data['deadline'] = deadline;
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}

// TransferTransaction
class TransferTransaction extends AbstractTransaction implements Transaction {
  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  TransferTransaction(Deadline deadline, Address recipient,
      List<Mosaic> mosaics, Message message, int networkType)
      : super() {
    if (recipient == null) {
      throw ErrNullRecipient;
    }
    if (mosaics == null) {
      throw ErrNullMosaics;
    }
    if (message == null) {
      throw ErrNullMessage;
    }

    this.version = TransferVersion;
    this.deadline = deadline;
    this.type = TransactionTypeFromRaw(16724);
    this.recipient = recipient;
    this.mosaics = mosaics;
    this.message = message;
    this.networkType = networkType;
  }

  TransferTransaction.fromDTO(_transferTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = TransactionTypeFromRaw(value._transaction.Type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.Deadline);
    this.signature = value._transaction.Signature;
    this.networkType = ExtractNetworkType(value._transaction.Version);
    this.version = ExtractVersion(value._transaction.Version);
    this.fee = value._transaction.Fee.toBigInt();
    this.signer = new PublicAccount.fromPublicKey(
        value._transaction.Signer, this.networkType);

    mosaics = Mosaic.listFromDTO(value._transaction._mosaics);
    recipient = new Address.fromEncoded(value._transaction._recipient);
    message = new Message.fromDTO(value._transaction._message);
  }

  static List<TransferTransaction> listFromDTO(
      List<_transferTransactionInfoDTO> json) {
    return json == null
        ? new List<TransferTransaction>()
        : json.map((value) => new TransferTransaction.fromDTO(value)).toList();
  }

  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "recipient":${recipient},\n'
        ' "mosaics":${mosaics.map((v) => v.toJson()).toList()},\n'
        ' "message":${message}\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    if (this.mosaics != null) {
      data['mosaics'] = this.mosaics.map((v) => v.toJson()).toList();
    }
    data['recipient'] = recipient?.toJson();
    data['message'] = message;
    return data;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List generateBytes() {
    return _generateBytes(this);
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
    _payload = utf8.decode(b);
  }

  Message.PlainMessage(String payload) {
    this._payload = payload;
    this._type = 0;
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

class SignedTransaction {
  int _transactionType;
  String _payload;
  String _hash;

  SignedTransaction([int transactionType, String payload, String hash]) {
    this._transactionType = transactionType;
    this._payload = payload;
    this._hash = hash;
  }

  int get transactionType => _transactionType;
  set transactionType(int transactionType) =>
      _transactionType = transactionType;
  String get payload => _payload;
  set payload(String payload) => _payload = payload;
  String get hash => _hash;
  set hash(String hash) => _hash = hash;

  SignedTransaction.fromJson(Map<String, dynamic> json) {
    _transactionType = json['transactionType'];
    _payload = json['payload'];
    _hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionType'] = this._transactionType;
    data['payload'] = this._payload;
    data['hash'] = this._hash;
    return data;
  }
}

// ignore: missing_return
Transaction _deserializeTxn(dynamic value) {
  switch (value.runtimeType) {
    case _transferTransactionInfoDTO:
      return TransferTransaction.fromDTO(value as _transferTransactionInfoDTO);
    default:
      {
        if (value is List) {
          value.map((v) => _deserializeTxn(v)).toList();
        }
      }
  }
}

var TimestampNemesisBlock =
    new DateTime.fromMicrosecondsSinceEpoch(1459468800 * 1000);

class Deadline {
  DateTime time;

  Deadline(
      {int days = 0,
      int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliseconds = 0,
      int microseconds = 0}) {
    var d = Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds);
    time = new DateTime.now().add(d);
  }

  @override
  String toString() {
    return '${time}';
  }

  Int64 GetInstant() {
    var x = Int64((this.time.microsecondsSinceEpoch * 1000) ~/ 1e6);
    var y = Int64((TimestampNemesisBlock.microsecondsSinceEpoch * 1e+6) ~/ 1e6);
    return x - y;
  }

  Deadline.fromUInt64DTO(UInt64DTO d) {
    this.time = new DateTime.fromMillisecondsSinceEpoch(d.toBigInt().toInt());
  }
}

Uint8List _generateBytes(TransferTransaction tx) {
  final builder = new fb.Builder(initialSize: 0);

  // Create message;
  var payload = utf8.encode(tx.message.payload);
  final mp = tx.message._type == 0 ? builder.writeListUint8(payload) : null;
  final message = new MessageBufferBuilder(builder)
    ..begin()
    ..addType(tx.message.type)
    ..addPayloadOffset(mp);
  final int m = message.finish();

// Create mosaics
  List<int> mb = new List(tx.mosaics.length);
  int i = 0;
  tx.mosaics.forEach((Mosaic mosaic) {
    final id = builder.writeListUint32(fromBigInt(mosaic.id));
    final amount = builder.writeListUint32(fromBigInt(mosaic.amount));

    final ms = new MosaicBufferBuilder(builder)
      ..begin()
      ..addIdOffset(id)
      ..addAmountOffset(amount);
    mb[i] = ms.finish();
    i++;
  });

  var recipient = base32.decode(tx.recipient.address);

  final vector = tx.generateVector(builder);

  final rV = builder.writeListUint8(recipient);
  final mV = builder.writeList(mb);

  var txnBuilder = TransferTransactionBufferBuilder(builder)
    ..begin()
    ..addSize(148 + 1 + (16 * tx.mosaics.length) + payload.length)
    ..addSignatureOffset(vector['signatureV'])
    ..addSignerOffset(vector['signerV'])
    ..addVersion(vector['versionV'])
    ..addType(tx.type._hex)
    ..addFeeOffset(vector['feeV'])
    ..addDeadlineOffset(vector['deadlineV'])
    ..addRecipientOffset(rV)
    ..addNumMosaics(tx.mosaics.length)
    ..addMessageSize(payload.length + 1)
    ..addMessageOffset(m)
    ..addMosaicsOffset(mV);

  final codedTransfer = txnBuilder.finish();

  return transferTransactionSchema().serialize(builder.finish(codedTransfer));
}

SignedTransaction _signTransactionWith(Transaction tx, Account a) {
  final s = a.account;
  var b = tx.generateBytes();

  final sb = ListToBytes(b.getRange(100, b.length).toList());

  final signature = s.sign(sb);
  var p = [];
  p.insertAll(0, b.getRange(0, 4));
  p.insertAll(4, signature);
  p.insertAll(4 + 64, a.account.publicKey.Raw);
  p.insertAll(100, b.getRange(100, b.length));

  List<int> f = List(p.length);
  for (int i = 0; i < p.length; i++) f[i] = p[i];

  final ph = HEX.encode(f);

  final hash = createTransactionHash(ph);

  return new SignedTransaction(tx.getAbstractTransaction().type.raw, ph.toUpperCase(), hash);
}

String createTransactionHash(String p){
  final b = HEX.decode(p);

  List<int> sb = [];

  sb.insertAll(0, b.getRange(4, 32+4));
  sb.insertAll(32, b.getRange(68, b.length));

  final r = crypto.HashesSha3_256(ListToBytes(sb));

  return HEX.encode(r).toUpperCase();
}