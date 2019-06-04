part of xpx_catapult_sdk;

var transactionTypes = <_transactionTypeClass>{
  _transactionTypeClass(TransactionType.AggregateCompleted, 16705, 0x4141),
  _transactionTypeClass(TransactionType.AggregateBonded, 16961, 0x4241),
  _transactionTypeClass(TransactionType.MetadataAddress, 16701, 0x413d),
  _transactionTypeClass(TransactionType.MetadataMosaic, 16957, 0x423d),
  _transactionTypeClass(TransactionType.MetadataNamespace, 17213, 0x433d),
  _transactionTypeClass(TransactionType.MosaicDefinition, 16717, 0x414d),
  _transactionTypeClass(TransactionType.MosaicAlias, 17230, 0x434e),
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

var TimestampNemesisBlock =
    new DateTime.fromMicrosecondsSinceEpoch(1459468800 * 1000);

_transactionTypeClass transactionTypeFromRaw(int value) {
  for (var t in transactionTypes) {
    if (t.raw == value) {
      return t;
    }
  }
  return null;
}

String mapTransaction(dynamic decodedJson) {
  final rawT = decodedJson["transaction"]["type"];

  final t = transactionTypeFromRaw(rawT).transactionType;

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

// CosignatureSignedTransaction
class CosignatureSignedTransaction {
  String _parentHash;
  String _signature;
  String _signer;

  CosignatureSignedTransaction(this._parentHash, this._signature, this._signer);

  @override
  String toString() {
    return '{\n'
        '\t"parentHash": $_parentHash\n'
        '\t"signature": $_signature\n'
        '\t"signer": $_signer\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentHash'] = this._parentHash;
    data['signature'] = this._signature;
    data['signer'] = this._signer;
    return data;
  }
}

// AggregateTransactionCosignature
class AggregateTransactionCosignature {
  String _signature;
  PublicAccount _signer;

  AggregateTransactionCosignature(this._signature, this._signer);

  @override
  String toString() {
    return '{\n'
        '\t"signature": $_signature\n'
        '\t"signer": $_signer\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this._signature;
    data['signer'] = this._signer;
    return data;
  }
}

abstract class Transaction {
  AbstractTransaction getAbstractTransaction();
  Uint8List _generateBytes();
  int _size();
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

  Map<String, int> _generateVector(fb.Builder builder) {
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
    return this.height.toInt() == 0 && this.hash == this.merkleComponentHash;
  }

  bool IsConfirmed() {
    return this.height.toInt() > 0;
  }

  bool HasMissingSignatures() {
    return this.height.toInt() == 0 && this.hash != this.merkleComponentHash;
  }

  bool IsUnannounced() {
    return this == null;
  }

  @override
  String toString() {
    return _abstractTransactionToString();
  }

  String _abstractTransactionToString() {
    final t = sprintf("%02x", [transactionTypes.lookup(type)?.hex]);
    return '{\n'
        '\t"transactionInfo":${_transactionInfoToString()}\n'
        '\t"networkType": $networkType,\n'
        '\t"type": $t,\n'
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
    this.type = transactionTypeFromRaw(16724);
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

    this.type = transactionTypeFromRaw(value._transaction.Type);
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

  int messageSize() {
    return this.message.payload.length + 1;
  }

  @override
  int _size() {
    return TransferHeaderSize +
        (MosaicSize + AmountSize) * this.mosaics.length +
        this.messageSize();
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder = new fb.Builder(initialSize: 0);

    // Create message;
    var payload = utf8.encode(this.message.payload);
    final mp = this.message._type == 0 ? builder.writeListUint8(payload) : null;
    final message = new MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type)
      ..addPayloadOffset(mp);
    final int m = message.finish();

// Create mosaics
    List<int> mb = new List(this.mosaics.length);
    int i = 0;
    this.mosaics.forEach((Mosaic mosaic) {
      final id = builder.writeListUint32(fromBigInt(mosaic.id));
      final amount = builder.writeListUint32(fromBigInt(mosaic.amount));

      final ms = new MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    });

    var recipient = base32.decode(this.recipient.address);

    final vectors = this._generateVector(builder);

    final rV = builder.writeListUint8(recipient);
    final mV = builder.writeList(mb);

    var txnBuilder = TransferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(this._size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(this.type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addRecipientOffset(rV)
      ..addNumMosaics(this.mosaics.length)
      ..addMessageSize(payload.length + 1)
      ..addMessageOffset(m)
      ..addMosaicsOffset(mV);

    final codedTransfer = txnBuilder.finish();

    return transferTransactionSchema().serialize(builder.finish(codedTransfer));
  }
}

class RegisterNamespaceTransaction extends AbstractTransaction
    implements Transaction {
  BigInt namespaceId;
  NamespaceType namespaceType;
  String namspaceName;
  BigInt duration;
  BigInt parentId;

  RegisterNamespaceTransaction.createRoot(
      Deadline deadline, String namespaceName, BigInt duration, int networkType)
      : super() {
    if (namespaceName == null) {
      throw ErrInvalidNamespaceName;
    }

    if (duration == null) {
      throw ErrNullDuration;
    }

    this.version = RegisterNamespaceVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16718);
    this.namespaceId = NewNamespaceIdFromName(namespaceName);
    this.networkType = networkType;
    this.namspaceName = namespaceName;
    this.namespaceType = NamespaceType.Root;
    this.duration = duration;
  }

  RegisterNamespaceTransaction.createSub(Deadline deadline,
      String subnamespaceName, String rootNamespaceName, int networkType)
      : super() {
    if (subnamespaceName == null || subnamespaceName == "") {
      throw ErrInvalidNamespaceName;
    }

    if (rootNamespaceName == null || rootNamespaceName == "") {
      throw ErrInvalidNamespaceName;
    }

    this.version = RegisterNamespaceVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16718);
    this.parentId = NewNamespaceIdFromName(rootNamespaceName);
    this.namespaceId = _generateId(subnamespaceName, this.parentId);
    this.networkType = networkType;
    this.namspaceName = subnamespaceName;
    this.namespaceType = NamespaceType.Sub;
  }

  RegisterNamespaceTransaction.fromDTO(
      _registerNamespaceTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.Type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.Deadline);
    this.signature = value._transaction.Signature;
    this.networkType = ExtractNetworkType(value._transaction.Version);
    this.version = ExtractVersion(value._transaction.Version);
    this.fee = value._transaction.Fee.toBigInt();
    this.signer = new PublicAccount.fromPublicKey(
        value._transaction.Signer, this.networkType);

    namespaceId = value._transaction._namespaceId.toBigInt();
    namespaceType = value._transaction._namespaceType == 0
        ? NamespaceType.Root
        : NamespaceType.Sub;
    namspaceName = value._transaction._name;
    if (namespaceType == NamespaceType.Root) {
      duration = value._transaction._duration.toBigInt();
    } else {
      parentId = value._transaction._parentId.toBigInt();
    }
  }

  static List<RegisterNamespaceTransaction> listFromDTO(
      List<_transferTransactionInfoDTO> json) {
    return json == null
        ? new List<RegisterNamespaceTransaction>()
        : json.map((value) => new TransferTransaction.fromDTO(value)).toList();
  }

  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "namespaceId":${namespaceId},\n'
        ' "namespaceType":${namespaceType},\n'
        ' "namspaceName":${namspaceName},\n'
        ' "parentId":${parentId},\n'
        ' "duration":${duration},\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['namespaceId'] = this.namespaceId;
    data['namespaceType'] = this.namespaceType;
    data['namspaceName'] = this.namspaceName;
    data['parentId'] = parentId;
    data['duration'] = duration;
    return data;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder = new fb.Builder(initialSize: 0);

    final nV = builder.writeListUint32(FromBigInt(this.namespaceId));
    int dV;
    if (this.namespaceType == NamespaceType.Root) {
      dV = builder.writeListUint32(fromBigInt(this.duration));
    } else {
      dV = builder.writeListUint32(FromBigInt(this.parentId));
    }

    final n = builder.writeString(this.namspaceName);

    final vectors = this._generateVector(builder);

    var txnBuilder = RegisterNamespaceTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(138 + this.namspaceName.length)
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(this.type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addNamespaceType(this.namespaceType.index)
      ..addDurationParentIdOffset(dV)
      ..addNamespaceIdOffset(nV)
      ..addNamespaceNameSize(this.namspaceName.length)
      ..addNamespaceNameOffset(n);
    final codedNamespace = txnBuilder.finish();
    return registerNamespaceTransactionSchema()
        .serialize(builder.finish(codedNamespace));
  }

  @override
  int _size() {
    // TODO: implement _size
    return null;
  }
}

class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicProperties mosaicProperties;
  BigInt duration;
  int mosaicNonce;
  BigInt mosaicId;

  MosaicDefinitionTransaction(
      Deadline deadline,
      int nonce,
      String ownerPublicKey,
      MosaicProperties mosaicProps,
      BigInt duration,
      int networkType)
      : super() {
    if (ownerPublicKey.length != 64) {
      throw ErrInvalidOwnerPublicKey;
    }

    if (mosaicProps == null) {
      throw ErrNullMosaicProperties;
    }

    this.version = MosaicDefinitionVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16717);
    this.networkType = networkType;
    this.mosaicNonce = nonce;
    this.mosaicProperties = mosaicProps;
    // Signer of transaction must be the same with ownerPublicKey
    this.mosaicId = NewMosaicIdFromNonceAndOwner(nonce, ownerPublicKey);
    this.duration = duration;
  }

  MosaicDefinitionTransaction.fromDTO(_mosaicDefinitionTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.Type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.Deadline);
    this.signature = value._transaction.Signature;
    this.networkType = ExtractNetworkType(value._transaction.Version);
    this.version = ExtractVersion(value._transaction.Version);
    this.fee = value._transaction.Fee.toBigInt();
    this.signer = new PublicAccount.fromPublicKey(
        value._transaction.Signer, this.networkType);
    this.mosaicProperties =
        new MosaicProperties.fromDTO(value._transaction._properties);
    this.mosaicNonce = value._transaction._mosaicNonce;
    this.mosaicId = value._transaction._mosaicId.toBigInt();
  }

  static List<MosaicDefinitionTransaction> listFromDTO(
      List<_transferTransactionInfoDTO> json) {
    return json == null
        ? new List<RegisterNamespaceTransaction>()
        : json.map((value) => new TransferTransaction.fromDTO(value)).toList();
  }

  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "mosaicProperties":${mosaicProperties},\n'
        ' "mosaicNonce":${mosaicNonce},\n'
        ' "mosaicId":${mosaicId},\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicProperties'] = this.mosaicProperties;
    data['mosaicNonce'] = this.mosaicNonce;
    data['mosaicId'] = this.mosaicId;
    return data;
  }

  @override
  int _size() {
    return MosaicDefinitionTransactionSize;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder = new fb.Builder(initialSize: 0);

    int f = 0;
    if (this.mosaicProperties.supplyMutable) {
      f += 1;
    }
    if (this.mosaicProperties.transferable) {
      f += 2;
    }
    if (this.mosaicProperties.levyMutable) {
      f += 4;
    }

    final mV = builder.writeListUint32(FromBigInt(this.mosaicId));

    final dV = builder.writeListUint32(fromBigInt(this.duration));

    final vectors = this._generateVector(builder);

    var txnBuilder = MosaicDefinitionTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(this._size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(this.type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addMosaicNonce(this.mosaicNonce)
      ..addMosaicIdOffset(mV)
      ..addNumOptionalProperties(1)
      ..addFlags(f)
      ..addDivisibility(this.mosaicProperties.divisibility)
      ..addIndicateDuration(2)
      ..addDurationOffset(dV);
    final codedNamespace = txnBuilder.finish();

    return mosaicDefinitionTransactionSchema()
        .serialize(builder.finish(codedNamespace));
  }
}

class MosaicSupplyChangeTransaction extends AbstractTransaction
    implements Transaction {
  MosaicSupplyType mosaicSupplyType;
  BigInt delta;
  BigInt mosaicId;

  MosaicSupplyChangeTransaction(Deadline deadline, MosaicSupplyType supplyType,
      BigInt mosaicId, BigInt delta, int networkType)
      : super() {
    if (mosaicId == null) {
      throw ErrNullMosaicId;
    }

    if (supplyType == null) {
      throw ErrNullSupplyType;
    }

    this.version = MosaicSupplyChangeVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16973);
    this.networkType = networkType;
    this.mosaicId = mosaicId;
    this.mosaicSupplyType = supplyType;
    this.delta = delta;
  }

  MosaicSupplyChangeTransaction.fromDTO(
      _mosaicSupplyChangeTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.Type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.Deadline);
    this.signature = value._transaction.Signature;
    this.networkType = ExtractNetworkType(value._transaction.Version);
    this.version = ExtractVersion(value._transaction.Version);
    this.fee = value._transaction.Fee.toBigInt();
    this.signer = new PublicAccount.fromPublicKey(
        value._transaction.Signer, this.networkType);
    this.mosaicSupplyType =
        value._transaction._direction == 0 ? Decrease : Increase;
    this.mosaicId = value._transaction._mosaicId.toBigInt();
    this.delta = value._transaction._delta.toBigInt();
  }

  static List<MosaicSupplyChangeTransaction> listFromDTO(
      List<_transferTransactionInfoDTO> json) {
    return json == null
        ? new List<MosaicSupplyChangeTransaction>()
        : json.map((value) => new TransferTransaction.fromDTO(value)).toList();
  }

  String toString() {
    String _supplyType = mosaicSupplyType.index == 0 ? "Decrease" : "Increase";
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "mosaicId":${mosaicId},\n'
        ' "mosaicSupplyType":${_supplyType},\n'
        ' "delta":${delta},\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicId'] = this.mosaicId;
    data['mosaicSupplyType'] = this.mosaicSupplyType.index;
    data['delta'] = this.delta;
    return data;
  }

  @override
  int _size() {
    return MosaicSupplyChangeTransactionSize;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder = new fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(FromBigInt(this.mosaicId));

    final dV = builder.writeListUint32(fromBigInt(this.delta));

    final vectors = this._generateVector(builder);

    var txnBuilder = MosaicSupplyChangeTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(this._size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(this.type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addMosaicIdOffset(mV)
      ..addDirection(this.mosaicSupplyType.index)
      ..addDeltaOffset(dV);
    final codedMosaicSupply = txnBuilder.finish();

    return mosaicSupplyChangeTransactionSchema()
        .serialize(builder.finish(codedMosaicSupply));
  }
}

class AggregateTransaction extends AbstractTransaction implements Transaction {
  List<Transaction> innerTransactions;
  List<AggregateTransactionCosignature> cosignatures;

  AggregateTransaction(
      Deadline deadline, List<Transaction> innerTxs, int networkType)
      : super() {
    if (innerTxs == null) {
      throw ErrNullInnerTransactions;
    }

    this.version = MosaicSupplyChangeVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16705);
    this.networkType = networkType;
    this.innerTransactions = innerTxs;
  }

//  AggregateTransaction.fromDTO(
//      _mosaicSupplyChangeTransactionInfoDTO value)
//      : super(
//      value._meta._height.toBigInt(),
//      value._meta._index,
//      value._meta._id,
//      value._meta._hash,
//      value._meta._merkleComponentHash) {
//    if (value == null) return;
//
//    this.type = transactionTypeFromRaw(value._transaction.Type);
//    this.deadline = Deadline.fromUInt64DTO(value._transaction.Deadline);
//    this.signature = value._transaction.Signature;
//    this.networkType = ExtractNetworkType(value._transaction.Version);
//    this.version = ExtractVersion(value._transaction.Version);
//    this.fee = value._transaction.Fee.toBigInt();
//    this.signer = new PublicAccount.fromPublicKey(
//        value._transaction.Signer, this.networkType);
//    this.mosaicSupplyType =
//    value._transaction._direction == 0 ? Decrease : Increase;
//    this.mosaicId = value._transaction._mosaicId.toBigInt();
//    this.delta = value._transaction._delta.toBigInt();
//  }

  static List<AggregateTransaction> listFromDTO(
      List<_transferTransactionInfoDTO> json) {
    return json == null
        ? new List<MosaicSupplyChangeTransaction>()
        : json.map((value) => new TransferTransaction.fromDTO(value)).toList();
  }

  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "innerTransactions":${innerTransactions},\n'
        ' "cosignatures":${cosignatures},\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['innerTransactions'] = this.innerTransactions;
    data['cosignatures'] = this.cosignatures;
    return data;
  }

  @override
  int _size() {
    int sizeOfInnerTransactions = 0;
    this.innerTransactions.forEach((itx) {
      sizeOfInnerTransactions += itx._size() - SignatureSize - MaxFeeSize - DeadLineSize;
    });
    return AggregateBondedHeader + sizeOfInnerTransactions;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder = new fb.Builder(initialSize: 0);

    // InnerTransactions
    List<int> txsb = [];
    this.innerTransactions.forEach((Transaction itx) {
      final txb = toAggregateTransactionBytes(itx);
      txsb.addAll(txb);
    });

    final tV = builder.writeListUint8(Uint8List.fromList(txsb));

    final vectors = this._generateVector(builder);

    var txnBuilder = AggregateTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(this._size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(this.type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addTransactionsSize(txsb.length)
      ..addTransactionsOffset(tV);

    final codedTransfer = txnBuilder.finish();

    return aggregateTransactionSchema().serialize(builder.finish(codedTransfer));
  }
}

SignedTransaction _signTransactionWith(Transaction tx, Account a) {
  final s = a.account;
  var b = tx._generateBytes();
  final sb = Uint8List.fromList(b.getRange(100, b.length).toList());

  final signature = s.sign(sb);
  List<int> p = [];
  p.insertAll(0, b.getRange(0, 4));
  p.insertAll(4, signature);
  p.insertAll(4 + 64, a.account.publicKey.Raw);
  p.insertAll(100, b.getRange(100, b.length));

  final ph = HEX.encode(p);

  final hash = _createTransactionHash(ph);

  return new SignedTransaction(
      tx.getAbstractTransaction().type.raw, ph.toUpperCase(), hash);
}

String _createTransactionHash(String p) {
  final b = HEX.decode(p);

  List<int> sb = [];

  sb.insertAll(0, b.getRange(4, 32 + 4));
  sb.insertAll(32, b.getRange(68, b.length));

  final r = crypto.HashesSha3_256(Uint8List.fromList(sb));

  return HEX.encode(r).toUpperCase();
}

Uint8List toAggregateTransactionBytes(Transaction tx) {
  if (tx.getAbstractTransaction().signer == null) {
    throw ErrTransactionSigner;
  }

  final sb = HEX.decode(tx.getAbstractTransaction().signer.publicKey);

  final b = tx._generateBytes();

  List<int> rB = [];
  rB.insertAll(0, [0, 0, 0, 0]);
  rB.insertAll(4, sb.getRange(0, 32));
  rB.insertAll(32 + 4, b.getRange(100, 104));
  rB.insertAll(32 + 4 + 4,
      b.getRange(100 + 2 + 2 + 16, 100 + 2 + 2 + 16 + b.length - 120));

  final s = crypto.encodeBigInt(BigInt.from(b.length - 64 - 16));

  var sr = s.reversed;

  rB.replaceRange(0, s.length, sr);

  return Uint8List.fromList(rB);
}

Transaction deserializeDTO(dynamic value) {
  switch (value.runtimeType) {
    case _transferTransactionInfoDTO:
      return TransferTransaction.fromDTO(value);
    case _registerNamespaceTransactionInfoDTO:
      return RegisterNamespaceTransaction.fromDTO(value);
    case _mosaicDefinitionTransactionInfoDTO:
      return MosaicDefinitionTransaction.fromDTO(value);
    case _mosaicSupplyChangeTransactionInfoDTO:
      return MosaicSupplyChangeTransaction.fromDTO(value);
    default:
      if (value is List) {
        value.map((v) => deserializeDTO(v)).toList();
      }
      return null;
  }
}
