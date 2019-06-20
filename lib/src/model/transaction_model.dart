part of xpx_chain_sdk;

RegExp _Hexadecimal =  RegExp(r'^[0-9a-fA-F]+$');

var transactionTypes = <_TransactionTypeClass>{
  _TransactionTypeClass(TransactionType.aggregateCompleted, 16705, 0x4141),
  _TransactionTypeClass(TransactionType.aggregateBonded, 16961, 0x4241),
  _TransactionTypeClass(TransactionType.metadataAddress, 16701, 0x413d),
  _TransactionTypeClass(TransactionType.metadataMosaic, 16957, 0x423d),
  _TransactionTypeClass(TransactionType.metadataNamespace, 17213, 0x433d),
  _TransactionTypeClass(TransactionType.mosaicDefinition, 16717, 0x414d),
  _TransactionTypeClass(TransactionType.mosaicAlias, 17230, 0x434e),
  _TransactionTypeClass(TransactionType.mosaicSupplyChange, 16973, 0x424d),
  _TransactionTypeClass(TransactionType.modifyMultisig, 16725, 0x4155),
  _TransactionTypeClass(TransactionType.modifyContract, 16727, 0x4157),
  _TransactionTypeClass(TransactionType.registerNamespace, 16718, 0x414e),
  _TransactionTypeClass(TransactionType.transfer, 16724, 0x4154),
  _TransactionTypeClass(TransactionType.lock, 16712, 0x4148),
  _TransactionTypeClass(TransactionType.secretLock, 16722, 0x4152),
  _TransactionTypeClass(TransactionType.secretProof, 16978, 0x4252),
};

// TransactionVersion enums
const aggregateCompletedVersion = 2,
    aggregateBondedVersion = 2,
    metadataAddressVersion = 1,
    metadataMosaicVersion = 1,
    metadataNamespaceVersion = 1,
    mosaicDefinitionVersion = 3,
    mosaicSupplyChangeVersion = 2,
    modifyMultisigVersion = 3,
    modifyContractVersion = 3,
    registerNamespaceVersion = 2,
    transferVersion = 3,
    lockVersion = 1,
    secretLockVersion = 1,
    secretProofVersion = 1;

// TransactionType enums
enum TransactionType {
  aggregateCompleted,
  aggregateBonded,
  metadataAddress,
  metadataMosaic,
  metadataNamespace,
  mosaicDefinition,
  mosaicSupplyChange,
  modifyMultisig,
  modifyContract,
  registerNamespace,
  transfer,
  lock,
  secretLock,
  secretProof,
  mosaicAlias
}

var TimestampNemesisBlock =
     DateTime.fromMicrosecondsSinceEpoch(1459468800 * 1000);

_TransactionTypeClass transactionTypeFromRaw(int value) {
  for (var t in transactionTypes) {
    if (t.raw == value) {
      return t;
    }
  }
  return null;
}

String mapTransaction(dynamic decodedJson) {
  final rawT = decodedJson["transaction"]["type"] as int;

  final t = transactionTypeFromRaw(rawT).transactionType;

  switch (t) {
    case TransactionType.aggregateCompleted:
      return ("AggregateCompleted");
    case TransactionType.aggregateBonded:
      return ("AggregateBonded");
    case TransactionType.metadataAddress:
      return ("MetadataAddress");
    case TransactionType.metadataMosaic:
      return ("MetadataMosaic");
    case TransactionType.metadataNamespace:
      return ("MetadataNamespace");
    case TransactionType.mosaicDefinition:
      return ("MosaicDefinition");
    case TransactionType.mosaicAlias:
      return ("MosaicAlias");
    case TransactionType.mosaicSupplyChange:
      return ("MosaicSupplyChange");
    case TransactionType.modifyMultisig:
      return ("ModifyMultisig");
    case TransactionType.modifyContract:
      return ("ModifyContract");
    case TransactionType.registerNamespace:
      return ("RegisterNamespace");
    case TransactionType.transfer:
      return ("Transfer");
    case TransactionType.lock:
      return ("Lock");
    case TransactionType.secretLock:
      return ("SecretLock");
    case TransactionType.secretProof:
      return ("SecretProof");
    default:
      return ("NULL");
  }
}

class _TransactionTypeClass {
  _TransactionTypeClass([this._transactionType, this._raw, this._hex]);

  TransactionType _transactionType;
  int _raw;
  int _hex;

  TransactionType get transactionType => this._transactionType;
  int get raw => this._raw;
  int get hex => this._hex;
}

abstract class Id {
  const Id(this.id);

  final BigInt id;

  @override
  String toString() {
    print("PASOSOSOSOSOSS");
    return toHex();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Id && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => 'Id'.hashCode ^ id.hashCode;

  String toHex() {
    return bigIntegerToHex(this.id);
  }

  int toIn() {
    return this.id.toInt();
  }

  BigInt toBigInt() {
    return this.id;
  }
}

class Message {
  Message._({int type, String payload}) {
    this._type = type;
    this._payload = payload;
  }

  Message.fromDTO(_MessageDTO value) {
    if (value?._payload == null) {
      return;
    }

    if (_Hexadecimal.hasMatch(value._payload)) {
      _payload = value._payload;
    } else {
      _payload = utf8.decode(hex.decode(value._payload));
    }
    _type = value._type;
  }

  Message.PlainMessage(String payload) {
    this._payload = payload;
    this._type = 0;
  }

  int _type;
  String _payload;

  int get type => _type;
  set type(int type) => _type = type;
  String get payload => _payload;
  set payload(String payload) => _payload = payload;

  @override
  String toString() {
    return '${toJson()}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = this._type;
    data['payload'] = this._payload;
    return data;
  }
}

class Deadline {
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
    this.value =  DateTime.now().add(d);
  }

  Deadline.fromUInt64DTO(UInt64DTO data) {
    if (data.lower == null || data.higher == null) return;

    this.value =
         DateTime.fromMillisecondsSinceEpoch(data.toBigInt().toInt());
  }

  DateTime value;

  @override
  String toString() {
    return '${this.value}';
  }

  Int64 GetInstant() {
    var x = Int64((this.value.microsecondsSinceEpoch * 1000) ~/ 1e6);
    var y = Int64((TimestampNemesisBlock.microsecondsSinceEpoch * 1e+6) ~/ 1e6);
    return x - y;
  }
}

class SignedTransaction {
  SignedTransaction([int transactionType, String payload, String hash]) {
    this._transactionType = transactionType;
    this._payload = payload;
    this._hash = hash;
  }

  SignedTransaction.fromJson(Map<String, dynamic> json) {
    _transactionType = json['transactionType'] as int;
    _payload = json['payload'] as String;
    _hash = json['hash'] as String;
  }

  int _transactionType;
  String _payload;
  String _hash;

  int get transactionType => _transactionType;
  set transactionType(int transactionType) =>
      _transactionType = transactionType;
  String get payload => _payload;
  set payload(String payload) => _payload = payload;
  String get hash => _hash;
  set hash(String hash) => _hash = hash;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['transactionType'] = this._transactionType;
    data['payload'] = this._payload;
    data['hash'] = this._hash;
    return data;
  }
}

// CosignatureSignedTransaction
class CosignatureSignedTransaction {
  CosignatureSignedTransaction(this._parentHash, this._signature, this._signer);

  String _parentHash;
  String _signature;
  String _signer;

  @override
  String toString() {
    return '{\n'
        '\t"parentHash": $_parentHash\n'
        '\t"signature": $_signature\n'
        '\t"signer": $_signer\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['parentHash'] = this._parentHash;
    data['signature'] = this._signature;
    data['signer'] = this._signer;
    return data;
  }
}

// AggregateTransactionCosignature
class AggregateTransactionCosignature {
  AggregateTransactionCosignature(this._signature, this._signer);

  AggregateTransactionCosignature.fromDTO(
      int networkType, _AggregateTransactionCosignatureDTO value) {
    if (value?._signer == null) {
      return;
    }

    _signature = value._signature;
    _signer =  PublicAccount.fromPublicKey(value._signer, networkType);
  }

  String _signature;
  PublicAccount _signer;

  @override
  String toString() {
    return '{\n'
        '\t"signature": $_signature\n'
        '\t"signer": $_signer\n'
        '}\n';
  }

  static List<AggregateTransactionCosignature> listFromDTO(
      int networkType, List<_AggregateTransactionCosignatureDTO> json) {
    return json == null
        ?  List<AggregateTransactionCosignature>()
        : json
            .map((value) =>
                 AggregateTransactionCosignature.fromDTO(networkType, value))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['height'] = this.height;
    data['index'] = this.index;
    data['id'] = this.id;
    data['hash'] = this.hash;
    data['merkleComponentHash'] = this.merkleComponentHash;

    return data;
  }
}

class AbstractTransaction with TransactionInfo {
  AbstractTransaction(
      [BigInt height,
      int index,
      String id,
      String hash,
      String merkleComponentHash]) {
    this.height = height;
    this.index = index;
    this.id = id;
    this.hash = hash;
    this.merkleComponentHash = merkleComponentHash;
  }

  int networkType;
  Deadline deadline;
  _TransactionTypeClass type;
  int version;
  BigInt fee;
  String signature;
  PublicAccount signer;

  Map<String, int> _generateVector(fb.Builder builder) {
    final Map<String, int> data =  Map<String, int>();
    data['versionV'] = (this.networkType << 8) + this.version;
    data['signatureV'] = builder.writeListUint8( Uint8List(64));
    data['signerV'] = builder.writeListUint8( Uint8List(32));
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

  @override
  Map<String, dynamic> toJson() {
    return _abstractTransactionToJson();
  }

  Map<String, dynamic> _abstractTransactionToJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  TransferTransaction(Deadline deadline, Address recipient,
      List<Mosaic> mosaics, Message message, int networkType)
      : super() {
    if (recipient == null) {
      throw errNullRecipient;
    }
    if (mosaics == null) {
      throw errNullMosaics;
    }
    if (message == null) {
      throw errNullMessage;
    }

    this.version = transferVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16724);
    this.recipient = recipient;
    this.mosaics = mosaics;
    this.message = message;
    this.networkType = networkType;
  }

  TransferTransaction.fromDTO(_TransferTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.deadline);

    this.signature = value._transaction.signature;
    this.networkType = ExtractNetworkType(value._transaction.version);
    this.version = ExtractVersion(value._transaction.version);
    this.fee = value._transaction.fee.toBigInt();
    this.signer =  PublicAccount.fromPublicKey(
        value._transaction.signer, this.networkType);

    mosaics = Mosaic.listFromDTO(value._transaction._mosaics);
    recipient =  Address.fromEncoded(value._transaction._recipient);
    message =  Message.fromDTO(value._transaction._message);
  }

  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  static List<TransferTransaction> listFromDTO(
      List<_TransferTransactionInfoDTO> json) {
    return json == null
        ?  List<TransferTransaction>()
        : json.map((value) =>  TransferTransaction.fromDTO(value)).toList();
  }

  @override
  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "recipient":$recipient,\n'
        ' "mosaics":${mosaics.map((v) => v.toJson()).toList()},\n'
        ' "message":$message\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
    return transferHeaderSize +
        (mosaicSize + amountSize) * this.mosaics.length +
        this.messageSize();
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder =  fb.Builder(initialSize: 0);

    // Create message;
    var payload = utf8.encode(this.message.payload);
    final mp = this.message._type == 0 ? builder.writeListUint8(payload) : null;
    final message =  MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type)
      ..addPayloadOffset(mp);
    final int m = message.finish();

// Create mosaics
    List<int> mb =  List(this.mosaics.length);
    int i = 0;
    this.mosaics.forEach((Mosaic mosaic) {
      final id = builder.writeListUint32(fromBigInt(mosaic.id.id));
      final amount = builder.writeListUint32(fromBigInt(mosaic.amount));

      final ms =  MosaicBufferBuilder(builder)
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
  RegisterNamespaceTransaction.createRoot(
      Deadline deadline, String namespaceName, BigInt duration, int networkType)
      : super() {
    if (namespaceName == null) {
      throw errInvalidNamespaceName;
    }

    if (duration == null) {
      throw errNullDuration;
    }

    this.version = registerNamespaceVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16718);
    this.namespaceId = NewNamespaceIdFromName(namespaceName);
    this.networkType = networkType;
    this.namspaceName = namespaceName;
    this.namespaceType = NamespaceType.root;
    this.duration = duration;
  }

  RegisterNamespaceTransaction.createSub(Deadline deadline,
      String subNamespaceName, String rootNamespaceName, int networkType)
      : super() {
    if (subNamespaceName == null || subNamespaceName == "") {
      throw errInvalidNamespaceName;
    }

    if (rootNamespaceName == null || rootNamespaceName == "") {
      throw errInvalidNamespaceName;
    }

    this.version = registerNamespaceVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16718);
    this.parentId = NewNamespaceIdFromName(rootNamespaceName);
    this.namespaceId =  NamespaceId._(
        _generateId(subNamespaceName, this.parentId.toBigInt()));
    this.networkType = networkType;
    this.namspaceName = subNamespaceName;
    this.namespaceType = NamespaceType.sub;
  }

  RegisterNamespaceTransaction.fromDTO(
      _RegisterNamespaceTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    this.signature = value._transaction.signature;
    this.networkType = ExtractNetworkType(value._transaction.version);
    this.version = ExtractVersion(value._transaction.version);
    this.fee = value._transaction.fee.toBigInt();
    this.signer =  PublicAccount.fromPublicKey(
        value._transaction.signer, this.networkType);

    namespaceId =  NamespaceId._(value._transaction._namespaceId.toBigInt());
    namespaceType = value._transaction._namespaceType == 0
        ? NamespaceType.root
        : NamespaceType.sub;
    namspaceName = value._transaction._name;
    if (namespaceType == NamespaceType.root) {
      duration = value._transaction._duration.toBigInt();
    } else {
      parentId =  NamespaceId._(value._transaction._parentId.toBigInt());
    }
  }

  NamespaceId namespaceId;
  NamespaceType namespaceType;
  String namspaceName;
  BigInt duration;
  NamespaceId parentId;

  static List<RegisterNamespaceTransaction> listFromDTO(
      List<_RegisterNamespaceTransactionInfoDTO> data) {
    return data == null
        ?  List<RegisterNamespaceTransaction>()
        : data
            .map((value) =>  RegisterNamespaceTransaction.fromDTO(value))
            .toList();
  }

  @override
  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "namespaceId":$namespaceId,\n'
        ' "namespaceType":${namespaceType.toString().split(".")[1]},\n'
        ' "namspaceName":$namspaceName,\n'
        ' "parentId":$parentId,\n'
        ' "duration":$duration,\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['namespaceId'] = this.namespaceId.toHex();
    data['namespaceType'] = this.namespaceType;
    data['namspaceName'] = this.namspaceName;
    data['parentId'] = this.parentId.toHex();
    data['duration'] = this.duration;
    return data;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder =  fb.Builder(initialSize: 0);

    final nV = builder.writeListUint32(FromBigInt(this.namespaceId.toBigInt()));
    int dV;
    if (this.namespaceType == NamespaceType.root) {
      dV = builder.writeListUint32(fromBigInt(this.duration));
    } else {
      dV = builder.writeListUint32(FromBigInt(this.parentId.toBigInt()));
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
    return registerNamespaceHeaderSize + this.namspaceName.length;
  }
}

class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicDefinitionTransaction(
      Deadline deadline,
      int nonce,
      String ownerPublicKey,
      MosaicProperties mosaicProps,
      BigInt duration,
      int networkType)
      : super() {
    if (ownerPublicKey.length != 64) {
      throw errInvalidOwnerPublicKey;
    }

    if (mosaicProps == null) {
      throw errNullMosaicProperties;
    }

    this.version = mosaicDefinitionVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16717);
    this.networkType = networkType;
    this.mosaicNonce = nonce;
    this.mosaicProperties = mosaicProps;
    // Signer of transaction must be the same with ownerPublicKey
    this.mosaicId = NewMosaicIdFromNonceAndOwner(nonce, ownerPublicKey);
    this.duration = duration;
  }

  MosaicDefinitionTransaction.fromDTO(_MosaicDefinitionTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    this.signature = value._transaction.signature;
    this.networkType = ExtractNetworkType(value._transaction.version);
    this.version = ExtractVersion(value._transaction.version);
    this.fee = value._transaction.fee.toBigInt();
    this.signer =  PublicAccount.fromPublicKey(
        value._transaction.signer, this.networkType);
    this.mosaicProperties =
         MosaicProperties.fromDTO(value._transaction._properties);
    this.mosaicNonce = value._transaction._mosaicNonce;
    this.mosaicId = MosaicId.fromId(value._transaction._mosaicId.toBigInt());
  }

  MosaicProperties mosaicProperties;
  BigInt duration;
  int mosaicNonce;
  MosaicId mosaicId;

  static List<MosaicDefinitionTransaction> listFromDTO(
      List<_MosaicDefinitionTransactionInfoDTO> json) {
    return json == null
        ?  List<MosaicDefinitionTransaction>()
        : json
            .map((value) =>  MosaicDefinitionTransaction.fromDTO(value))
            .toList();
  }

  @override
  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "mosaicProperties":$mosaicProperties,\n'
        ' "mosaicNonce":$mosaicNonce,\n'
        ' "mosaicId":$mosaicId,\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicProperties'] = this.mosaicProperties;
    data['mosaicNonce'] = this.mosaicNonce;
    data['mosaicId'] = this.mosaicId;
    return data;
  }

  @override
  int _size() {
    return mosaicDefinitionTransactionSize;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder =  fb.Builder(initialSize: 0);

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

    final mV = builder.writeListUint32(FromBigInt(this.mosaicId.id));

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
  MosaicSupplyChangeTransaction(Deadline deadline, MosaicSupplyType supplyType,
      MosaicId mosaicId, BigInt delta, int networkType)
      : super() {
    if (mosaicId == null) {
      throw errNullMosaicId;
    }

    if (supplyType == null) {
      throw errNullSupplyType;
    }

    this.version = mosaicSupplyChangeVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16973);
    this.networkType = networkType;
    this.mosaicId = mosaicId;
    this.mosaicSupplyType = supplyType;
    this.delta = delta;
  }

  MosaicSupplyChangeTransaction.fromDTO(
      _MosaicSupplyChangeTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    this.signature = value._transaction.signature;
    this.networkType = ExtractNetworkType(value._transaction.version);
    this.version = ExtractVersion(value._transaction.version);
    this.fee = value._transaction.fee.toBigInt();
    this.signer =  PublicAccount.fromPublicKey(
        value._transaction.signer, this.networkType);
    this.mosaicSupplyType =
        value._transaction._direction == 0 ? decrease : increase;
    this.mosaicId = MosaicId.fromId(value._transaction._mosaicId.toBigInt());
    this.delta = value._transaction._delta.toBigInt();
  }

  MosaicSupplyType mosaicSupplyType;
  BigInt delta;
  MosaicId mosaicId;

  static List<MosaicSupplyChangeTransaction> listFromDTO(
      List<_MosaicSupplyChangeTransactionInfoDTO> json) {
    return json == null
        ?  List<MosaicSupplyChangeTransaction>()
        : json
            .map((value) =>  MosaicSupplyChangeTransaction.fromDTO(value))
            .toList();
  }

  @override
  String toString() {
    String _supplyType = mosaicSupplyType.index == 0 ? "decrease" : "increase";
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "mosaicId":$mosaicId,\n'
        ' "mosaicSupplyType":$_supplyType,\n'
        ' "delta":$delta,\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicId'] = this.mosaicId;
    data['mosaicSupplyType'] = this.mosaicSupplyType.index;
    data['delta'] = this.delta;
    return data;
  }

  @override
  int _size() {
    return mosaicSupplyChangeTransactionSize;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder =  fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(FromBigInt(this.mosaicId.id));

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
  AggregateTransaction(
      Deadline deadline, List<Transaction> innerTxs, int networkType)
      : super() {
    if (innerTxs == null) {
      throw errNullInnerTransactions;
    }

    this.version = mosaicSupplyChangeVersion;
    this.deadline = deadline;
    this.type = transactionTypeFromRaw(16705);
    this.networkType = networkType;
    this.innerTransactions = innerTxs;
  }

  AggregateTransaction.fromDTO(_AggregateTransactionInfoDTO value)
      : super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    if (value == null) return;

    this.type = transactionTypeFromRaw(value._transaction.type);
    this.deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    this.signature = value._transaction.signature;
    this.networkType = ExtractNetworkType(value._transaction.version);
    this.version = ExtractVersion(value._transaction.version);
    this.fee = value._transaction.fee.toBigInt();
    this.signer =  PublicAccount.fromPublicKey(
        value._transaction.signer, this.networkType);
    this.innerTransactions = value._transaction._transactions
        .map((dynamic t) => deserializeDTO(t))
        .toList();

    this.cosignatures = AggregateTransactionCosignature.listFromDTO(
        this.networkType, value._transaction._cosignatures);
  }

  List<Transaction> innerTransactions;
  List<AggregateTransactionCosignature> cosignatures;

  static List<AggregateTransaction> listFromDTO(
      List<_AggregateTransactionInfoDTO> json) {
    return json == null
        ?  List<AggregateTransaction>()
        : json.map((value) =>  AggregateTransaction.fromDTO(value)).toList();
  }

  @override
  String toString() {
    return '{\n'
        ' "abstractTransaction":${_abstractTransactionToString()}\n'
        ' "innerTransactions":$innerTransactions,\n'
        ' "cosignatures":$cosignatures,\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['innerTransactions'] = this.innerTransactions;
    data['cosignatures'] = this.cosignatures;
    return data;
  }

  @override
  int _size() {
    int sizeOfInnerTransactions = 0;
    this.innerTransactions.forEach((itx) {
      sizeOfInnerTransactions +=
          itx._size() - signatureSize - maxFeeSize - deadLineSize;
    });
    return aggregateBondedHeader + sizeOfInnerTransactions;
  }

  @override
  AbstractTransaction getAbstractTransaction() {
    return _getAbstractTransaction();
  }

  @override
  Uint8List _generateBytes() {
    final builder =  fb.Builder(initialSize: 0);

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

    return aggregateTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

SignedTransaction _signTransactionWith(Transaction tx, Account a) {
  final s = a.account;
  var b = tx._generateBytes();
  final sb = Uint8List.fromList(b.skip(100).take(b.length).toList());

  final signature = s.sign(sb);
  List<int> p = [];
  p.insertAll(0, b.skip(0).take(4));
  p.insertAll(4, signature);
  p.insertAll(4 + 64, a.account.publicKey.Raw);
  p.insertAll(100, b.skip(100).take(b.length));

  final pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex);

  return  SignedTransaction(
      tx.getAbstractTransaction().type.raw, pHex.toUpperCase(), hash);
}

String _createTransactionHash(String pHex) {
  final p = hex.decode(pHex);

  List<int> sb = <int>[];

  sb.insertAll(0, p.skip(4).take(32));
  sb.insertAll(32, p.skip(68).take(p.length));

  final r = crypto.HashesSha3_256(Uint8List.fromList(sb));

  return hex.encode(r).toUpperCase();
}

Uint8List toAggregateTransactionBytes(Transaction tx) {
  if (tx.getAbstractTransaction().signer == null) {
    throw errTransactionSigner;
  }

  final sb = hex.decode(tx.getAbstractTransaction().signer.publicKey);

  final b = tx._generateBytes();

  List<int> rB = <int>[0, 0, 0, 0];
  rB.insertAll(4, sb.take(32));
  rB.insertAll(rB.length, b.skip(100).take(4));
  rB.insertAll(rB.length, b.skip(100 + 2 + 2 + 16).take(b.length - 120));

  final s = crypto.encodeBigInt(BigInt.from(b.length - 64 - 16));

  var sr = s.reversed;

  rB.replaceRange(0, s.length, sr);

  return Uint8List.fromList(rB);
}

Transaction deserializeDTO(dynamic value) {
  switch (value.runtimeType) {
    case _TransferTransactionInfoDTO:
      return TransferTransaction.fromDTO(value as _TransferTransactionInfoDTO);
    case _RegisterNamespaceTransactionInfoDTO:
      return RegisterNamespaceTransaction.fromDTO(
          value as _RegisterNamespaceTransactionInfoDTO);
    case _MosaicDefinitionTransactionInfoDTO:
      return MosaicDefinitionTransaction.fromDTO(
          value as _MosaicDefinitionTransactionInfoDTO);
    case _MosaicSupplyChangeTransactionInfoDTO:
      return MosaicSupplyChangeTransaction.fromDTO(
          value as _MosaicSupplyChangeTransactionInfoDTO);
    case _AggregateTransactionInfoDTO:
      return AggregateTransaction.fromDTO(
          value as _AggregateTransactionInfoDTO);
    default:
      if (value is List) {
        value.map((dynamic v) => deserializeDTO(v)).toList();
      }
      return null;
  }
}
