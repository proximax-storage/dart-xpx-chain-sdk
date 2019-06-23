part of xpx_chain_sdk;

RegExp _hexadecimal = RegExp(r'^[0-9a-fA-F]+$');

var _transactionTypes = <_TransactionTypeClass>{
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
const _aggregateCompletedVersion = 2,
    _registerNamespaceVersion = 2,
    _transferVersion = 3,
    _mosaicDefinitionVersion = 3,
    _mosaicSupplyChangeVersion = 2;
//    modifyMultisigVersion = 3,
//    modifyContractVersion = 3,
//    aggregateBondedVersion = 2,
//    metadataAddressVersion = 1,
//    metadataMosaicVersion = 1,
//    metadataNamespaceVersion = 1,
//    lockVersion = 1,
//    secretLockVersion = 1,
//    secretProofVersion = 1;

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

var _timestampNemesisBlock =
    DateTime.fromMicrosecondsSinceEpoch(1459468800 * 1000);

_TransactionTypeClass transactionTypeFromRaw(int value) {
  for (final t in _transactionTypes) {
    if (t.raw == value) {
      return t;
    }
  }
  return null;
}

String _mapTransaction(decodedJson) {
  final rawT = decodedJson['transaction']['type'];

  final t = transactionTypeFromRaw(rawT).transactionType;

  switch (t) {
    case TransactionType.aggregateCompleted:
      return 'AggregateCompleted';
    case TransactionType.aggregateBonded:
      return 'AggregateBonded';
    case TransactionType.metadataAddress:
      return 'MetadataAddress';
    case TransactionType.metadataMosaic:
      return 'MetadataMosaic';
    case TransactionType.metadataNamespace:
      return 'MetadataNamespace';
    case TransactionType.mosaicDefinition:
      return 'MosaicDefinition';
    case TransactionType.mosaicAlias:
      return 'MosaicAlias';
    case TransactionType.mosaicSupplyChange:
      return 'MosaicSupplyChange';
    case TransactionType.modifyMultisig:
      return 'ModifyMultisig';
    case TransactionType.modifyContract:
      return 'ModifyContract';
    case TransactionType.registerNamespace:
      return 'RegisterNamespace';
    case TransactionType.transfer:
      return 'Transfer';
    case TransactionType.lock:
      return 'Lock';
    case TransactionType.secretLock:
      return 'SecretLock';
    case TransactionType.secretProof:
      return 'SecretProof';
    default:
      return 'NULL';
  }
}

class _TransactionTypeClass {
  _TransactionTypeClass([this._transactionType, this._raw, this._hex]);

  TransactionType _transactionType;
  int _raw;
  int _hex;

  TransactionType get transactionType => _transactionType;
  int get raw => _raw;
  int get hex => _hex;
}

abstract class Id {
  const Id(this.id);

  final BigInt id;

  @override
  String toString() => toHex();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Id && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => 'Id'.hashCode ^ id.hashCode;

  String toHex() => bigIntegerToHex(id);

  int toIn() => id.toInt();

  BigInt toBigInt() => id;
}

class Message {
  Message._({this.type, this.payload});

  Message.fromDTO(_MessageDTO value) {
    if (value?._payload == null) {
      return;
    }

    if (_hexadecimal.hasMatch(value._payload)) {
      payload = value._payload;
    } else {
      payload = utf8.decode(hex.decode(value._payload));
    }
    type = value._type;
  }

  Message.plainMessage(this.payload) {
    type = 0;
  }

  int type;
  String payload;

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['payload'] = payload;
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
    final d = Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds);
    value = DateTime.now().add(d);
  }

  Deadline.fromUInt64DTO(UInt64DTO data)
      : assert(data.lower != null || data.higher == null,
            'lower or higher must not be null') {
    value = DateTime.fromMillisecondsSinceEpoch(data.toBigInt().toInt());
  }

  DateTime value;

  @override
  String toString() => '$value';

  Int64 getInstant() {
    final x = Int64((value.microsecondsSinceEpoch * 1000) ~/ 1e6);
    final y =
        Int64((_timestampNemesisBlock.microsecondsSinceEpoch * 1e+6) ~/ 1e6);
    return x - y;
  }
}

class SignedTransaction {
  SignedTransaction([this.transactionType, this.payload, this.hash]);

  SignedTransaction.fromJson(Map<String, dynamic> json) {
    transactionType = json['transactionType'];
    payload = json['payload'];
    hash = json['hash'];
  }

  int transactionType;
  String payload;
  String hash;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionType'] = transactionType;
    data['payload'] = payload;
    data['hash'] = hash;
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
  String toString() => '{\n'
      '\t"parentHash": $_parentHash\n'
      '\t"signature": $_signature\n'
      '\t"signer": $_signer\n'
      '}\n';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentHash'] = _parentHash;
    data['signature'] = _signature;
    data['signer'] = _signer;
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
    _signer = PublicAccount.fromPublicKey(value._signer, networkType);
  }

  String _signature;
  PublicAccount _signer;

  @override
  String toString() => '{\n'
      '\t"signature": $_signature\n'
      '\t"signer": $_signer\n'
      '}\n';

  static List<AggregateTransactionCosignature> listFromDTO(
          int networkType, List<_AggregateTransactionCosignatureDTO> json) =>
      json == null
          ? null
          : json
              .map((value) =>
                  AggregateTransactionCosignature.fromDTO(networkType, value))
              .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = _signature;
    data['signer'] = _signer;
    return data;
  }
}

abstract class Transaction {
  AbstractTransaction getAbstractTransaction();
  Uint8List _generateBytes();
  int _size();
}

// Transaction Info
mixin TransactionInfo {
  BigInt height;
  int index;
  String id;
  String hash;
  String merkleComponentHash;

  TransactionInfo get getTransactionInfo => this;

  String _transactionInfoToString() => '{\n'
      '\t"height": $height,\n'
      '\t"index": $index,\n'
      '\t"id": $id,\n'
      '\t"hash": $hash,\n'
      '\t"merkleComponentHash": $merkleComponentHash\n'
      '\t}';

  @override
  String toString() => _transactionInfoToString();

  Map<String, dynamic> toJson() => _transactionInfoToJson();

  Map<String, dynamic> _transactionInfoToJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['index'] = index;
    data['id'] = id;
    data['hash'] = hash;
    data['merkleComponentHash'] = merkleComponentHash;

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

  PublicAccount get toAggregate => signer;
  set toAggregate(PublicAccount signer) => this.signer = signer;

  Map<String, int> _generateVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType << 8) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['feeV'] = builder.writeListUint32(fromBigInt(fee));
    data['deadlineV'] = builder.writeListUint32(
        fromBigInt(BigInt.from(deadline.getInstant().toInt())));
    return data;
  }

  AbstractTransaction _getAbstractTransaction() {
    final abs = AbstractTransaction()
      ..height = height
      ..index = index
      ..id = id
      ..hash = hash
      ..merkleComponentHash = merkleComponentHash
      ..networkType = networkType
      ..deadline = deadline
      ..type = type
      ..version = version
      ..fee = fee
      ..signature = signature
      ..signer = signer;
    return abs;
  }

  bool isUnconfirmed() => height.toInt() == 0 && hash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() =>
      height.toInt() == 0 && hash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _abstractTransactionToString();

  String _abstractTransactionToString() => '{\n'
      '\t"transactionInfo": ${_transactionInfoToString()}\n'
      '\t"networkType": $networkType,\n'
      '\t"type": ${_transactionTypes.lookup(type)?._raw},\n'
      '\t"version": $version,\n'
      '\t"fee": $fee,\n'
      '\t"deadline": $deadline,\n'
      '\t"signature": $signature,\n'
      '\t"signer": $signer\n'
      '}';

  @override
  Map<String, dynamic> toJson() => _abstractTransactionToJson();

  Map<String, dynamic> _abstractTransactionToJson() {
    final Map<String, dynamic> data = {}..addAll(_transactionInfoToJson());
    data['networkType'] = networkType;
    data['type'] = _transactionTypes.lookup(type)._raw;
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
      throw _errNullRecipient;
    } else if (mosaics == null) {
      throw _errNullMosaics;
    } else if (message == null) {
      throw _errNullMessage;
    } else {
      version = _transferVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16724);
      this.recipient = recipient;
      this.mosaics = mosaics;
      this.message = message;
      this.networkType = networkType;
    }
  }

  TransferTransaction.fromDTO(_TransferTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);

    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    fee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);
    mosaics = Mosaic.listFromDTO(value._transaction._mosaics);
    recipient = Address.fromEncoded(value._transaction._recipient);
    message = Message.fromDTO(value._transaction._message);
  }

  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  static List<TransferTransaction> listFromDTO(
          List<_TransferTransactionInfoDTO> json) =>
      json == null
          ? null
          : json.map((value) => TransferTransaction.fromDTO(value)).toList();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"recipient": $recipient,\n'
      '\t"mosaics": ${mosaics.map((v) => v.toJson()).toList()},\n'
      '\t"message'
      ': $message\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    if (mosaics != null) {
      data['mosaics'] = mosaics.map((v) => v.toJson()).toList();
    }
    data['recipient'] = recipient?.toJson();
    data['message'] = message;
    return data;
  }

  int messageSize() => message.payload.length + 1;

  @override
  int _size() =>
      transferHeaderSize +
      (mosaicSize + amountSize) * mosaics.length +
      messageSize();

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    // Create message;
    final payload = utf8.encode(this.message.payload);
    final mp = this.message.type == 0 ? builder.writeListUint8(payload) : null;
    final message = MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type)
      ..addPayloadOffset(mp);
    final int m = message.finish();

// Create mosaics
    final List<int> mb = List(mosaics.length);
    int i = 0;
    for (final mosaic in mosaics) {
      final id = builder.writeListUint32(fromBigInt(mosaic.id.id));
      final amount = builder.writeListUint32(fromBigInt(mosaic.amount));

      final ms = MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    }

    final recipient = base32.decode(this.recipient.address);

    final vectors = _generateVector(builder);

    final rV = builder.writeListUint8(recipient);
    final mV = builder.writeList(mb);

    final txnBuilder = TransferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addRecipientOffset(rV)
      ..addNumMosaics(mosaics.length)
      ..addMessageSize(payload.length + 1)
      ..addMessageOffset(m)
      ..addMosaicsOffset(mV);

    final codedTransfer = txnBuilder.finish();

    return transferTransactionSchema().serialize(builder.finish(codedTransfer));
  }
}

class RegisterNamespaceTransaction extends AbstractTransaction
    implements Transaction {
  RegisterNamespaceTransaction.createRoot(Deadline deadline,
      String rootNamespaceName, BigInt duration, int networkType)
      : super() {
    if (rootNamespaceName == null) {
      throw _errInvalidNamespaceName;
    } else if (duration == null) {
      throw _errNullDuration;
    } else {
      version = _registerNamespaceVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16718);
      namespaceId = NamespaceId.fromName(rootNamespaceName);
      this.networkType = networkType;
      namspaceName = rootNamespaceName;
      namespaceType = NamespaceType.root;
      this.duration = duration;
    }
  }

  RegisterNamespaceTransaction.createSub(Deadline deadline,
      String subNamespaceName, String rootNamespaceName, int networkType)
      : super() {
    if (subNamespaceName == null || subNamespaceName == '') {
      throw _errInvalidNamespaceName;
    } else if (rootNamespaceName == null || rootNamespaceName == '') {
      throw _errInvalidNamespaceName;
    } else {
      version = _registerNamespaceVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16718);
      parentId = NamespaceId.fromName(rootNamespaceName);
      namespaceId =
          NamespaceId._(_generateId(subNamespaceName, parentId.toBigInt()));
      this.networkType = networkType;
      namspaceName = subNamespaceName;
      namespaceType = NamespaceType.sub;
    }
  }

  RegisterNamespaceTransaction.fromDTO(
      _RegisterNamespaceTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    fee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);

    namespaceId = NamespaceId._(value._transaction._namespaceId.toBigInt());
    namespaceType = value._transaction._namespaceType == 0
        ? NamespaceType.root
        : NamespaceType.sub;
    namspaceName = value._transaction._name;
    if (namespaceType == NamespaceType.root) {
      duration = value._transaction._duration.toBigInt();
    } else {
      parentId = NamespaceId._(value._transaction._parentId.toBigInt());
    }
  }

  NamespaceId namespaceId;
  NamespaceType namespaceType;
  String namspaceName;
  BigInt duration;
  NamespaceId parentId;

  static List<RegisterNamespaceTransaction> listFromDTO(
          List<_RegisterNamespaceTransactionInfoDTO> data) =>
      data == null
          ? List
          : data
              .map((value) => RegisterNamespaceTransaction.fromDTO(value))
              .toList();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"namespaceId": $namespaceId,\n'
      '\t"namespaceType": ${namespaceType.toString().split('.')[1]},\n'
      '\t"namspaceName": $namspaceName,\n'
      '\t"parentId": $parentId,\n'
      '\t"duration": $duration,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['namespaceId'] = namespaceId.toHex();
    data['namespaceType'] = namespaceType;
    data['namspaceName'] = namspaceName;
    data['parentId'] = parentId.toHex();
    data['duration'] = duration;
    return data;
  }

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final nV = builder.writeListUint32(bigIntToList(namespaceId.toBigInt()));
    int dV;
    if (namespaceType == NamespaceType.root) {
      dV = builder.writeListUint32(fromBigInt(duration));
    } else {
      dV = builder.writeListUint32(bigIntToList(parentId.toBigInt()));
    }

    final n = builder.writeString(namspaceName);

    final vectors = _generateVector(builder);

    final txnBuilder = RegisterNamespaceTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addNamespaceType(namespaceType.index)
      ..addDurationParentIdOffset(dV)
      ..addNamespaceIdOffset(nV)
      ..addNamespaceNameSize(namspaceName.length)
      ..addNamespaceNameOffset(n);
    final codedNamespace = txnBuilder.finish();
    return registerNamespaceTransactionSchema()
        .serialize(builder.finish(codedNamespace));
  }

  @override
  int _size() => registerNamespaceHeaderSize + namspaceName.length;
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
      throw _errInvalidOwnerPublicKey;
    } else if (mosaicProps == null) {
      throw _errNullMosaicProperties;
    } else {
      version = _mosaicDefinitionVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16717);
      this.networkType = networkType;
      mosaicNonce = nonce;
      mosaicProperties = mosaicProps;
      // Signer of transaction must be the same with ownerPublicKey
      mosaicId = MosaicId.fromNonceAndOwner(nonce, ownerPublicKey);
      this.duration = duration;
    }
  }

  MosaicDefinitionTransaction.fromDTO(_MosaicDefinitionTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    fee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);
    mosaicProperties = MosaicProperties.fromDTO(value._transaction._properties);
    mosaicNonce = value._transaction._mosaicNonce;
    mosaicId = MosaicId.fromId(value._transaction._mosaicId.toBigInt());
  }

  MosaicProperties mosaicProperties;
  BigInt duration;
  int mosaicNonce;
  MosaicId mosaicId;

  static List<MosaicDefinitionTransaction> listFromDTO(
          List<_MosaicDefinitionTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => MosaicDefinitionTransaction.fromDTO(value))
              .toList();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"mosaicProperties": $mosaicProperties,\n'
      '\t"mosaicNonce": $mosaicNonce,\n'
      '\t"mosaicId": $mosaicId,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicProperties'] = mosaicProperties;
    data['mosaicNonce'] = mosaicNonce;
    data['mosaicId'] = mosaicId;
    return data;
  }

  @override
  int _size() => mosaicDefinitionTransactionSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    int f = 0;
    if (mosaicProperties.supplyMutable) {
      f += 1;
    }
    if (mosaicProperties.transferable) {
      f += 2;
    }
    if (mosaicProperties.levyMutable) {
      f += 4;
    }

    final mV = builder.writeListUint32(bigIntToList(mosaicId.id));

    final dV = builder.writeListUint32(fromBigInt(duration));

    final vectors = _generateVector(builder);

    final txnBuilder = MosaicDefinitionTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addMosaicNonce(mosaicNonce)
      ..addMosaicIdOffset(mV)
      ..addNumOptionalProperties(1)
      ..addFlags(f)
      ..addDivisibility(mosaicProperties.divisibility)
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
      throw _errNullMosaicId;
    } else if (supplyType == null) {
      throw _errNullSupplyType;
    } else {
      version = _mosaicSupplyChangeVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16973);
      this.networkType = networkType;
      this.mosaicId = mosaicId;
      mosaicSupplyType = supplyType;
      this.delta = delta;
    }
  }

  MosaicSupplyChangeTransaction.fromDTO(
      _MosaicSupplyChangeTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    fee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);
    mosaicSupplyType = value._transaction._direction == 0 ? decrease : increase;
    mosaicId = MosaicId.fromId(value._transaction._mosaicId.toBigInt());
    delta = value._transaction._delta.toBigInt();
  }

  MosaicSupplyType mosaicSupplyType;
  BigInt delta;
  MosaicId mosaicId;

  static List<MosaicSupplyChangeTransaction> listFromDTO(
          List<_MosaicSupplyChangeTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => MosaicSupplyChangeTransaction.fromDTO(value))
              .toList();

  @override
  String toString() {
    final String _supplyType =
        mosaicSupplyType.index == 0 ? 'decrease' : 'increase';
    return '{\n'
        '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
        '\t"mosaicId": $mosaicId,\n'
        '\t"mosaicSupplyType": $_supplyType,\n'
        '\t"delta": $delta,\n'
        '}\n';
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaicId'] = mosaicId;
    data['mosaicSupplyType'] = mosaicSupplyType.index;
    data['delta'] = delta;
    return data;
  }

  @override
  int _size() => mosaicSupplyChangeTransactionSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(bigIntToList(mosaicId.id));

    final dV = builder.writeListUint32(fromBigInt(delta));

    final vectors = _generateVector(builder);

    final txnBuilder = MosaicSupplyChangeTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addMosaicIdOffset(mV)
      ..addDirection(mosaicSupplyType.index)
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
    if (innerTxs.isEmpty == null) {
      throw _errNullInnerTransactions;
    } else {
      version = _aggregateCompletedVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16705);
      this.networkType = networkType;
      innerTransactions = innerTxs;
    }
  }

  AggregateTransaction.fromDTO(_AggregateTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    fee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);
    innerTransactions =
        value._transaction._transactions.map(_deserializeDTO).toList();

    cosignatures = AggregateTransactionCosignature.listFromDTO(
        networkType, value._transaction._cosignatures);
  }

  List<Transaction> innerTransactions;
  List<AggregateTransactionCosignature> cosignatures;

  static List<AggregateTransaction> listFromDTO(
          List<_AggregateTransactionInfoDTO> json) =>
      json == null
          ? null
          : json.map((value) => AggregateTransaction.fromDTO(value)).toList();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"innerTransactions": $innerTransactions,\n'
      '\t"cosignatures": $cosignatures,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['innerTransactions'] = innerTransactions;
    data['cosignatures'] = cosignatures;
    return data;
  }

  @override
  int _size() {
    int sizeOfInnerTransactions = 0;
    for (final itx in innerTransactions) {
      sizeOfInnerTransactions +=
          itx._size() - signatureSize - maxFeeSize - deadLineSize;
    }
    return aggregateBondedHeader + sizeOfInnerTransactions;
  }

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    // InnerTransactions
    final txsBytes = <int>[];
    for (final itx in innerTransactions) {
      final txb = toAggregateTransactionBytes(itx);
      txsBytes.addAll(txb);
    }

    final tV = builder.writeListUint8(Uint8List.fromList(txsBytes));

    final vectors = _generateVector(builder);

    final txnBuilder = AggregateTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addSignatureOffset(vectors['signatureV'])
      ..addSignerOffset(vectors['signerV'])
      ..addVersion(vectors['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vectors['feeV'])
      ..addDeadlineOffset(vectors['deadlineV'])
      ..addTransactionsSize(txsBytes.length)
      ..addTransactionsOffset(tV);

    final codedTransfer = txnBuilder.finish();

    return aggregateTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

SignedTransaction _signTransactionWith(Transaction tx, Account a) {
  final s = a.account;
  final b = tx._generateBytes();
  final sb = Uint8List.fromList(b.skip(100).take(b.length).toList());

  final signature = s.sign(sb);
  final p = <int>[]
    ..insertAll(0, b.skip(0).take(4))
    ..insertAll(4, signature)
    ..insertAll(4 + 64, a.account.publicKey.Raw)
    ..insertAll(100, b.skip(100).take(b.length));

  final pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex);

  return SignedTransaction(
      tx.getAbstractTransaction().type.raw, pHex.toUpperCase(), hash);
}

String _createTransactionHash(String pHex) {
  final p = hex.decode(pHex);

  final sb = <int>[]
    ..insertAll(0, p.skip(4).take(32))
    ..insertAll(32, p.skip(68).take(p.length));

  final r = crypto.HashesSha3_256(Uint8List.fromList(sb));

  return hex.encode(r).toUpperCase();
}

Uint8List toAggregateTransactionBytes(Transaction tx) {
  if (tx.getAbstractTransaction().signer == null) {
    throw _errTransactionSigner;
  }

  final sb = hex.decode(tx.getAbstractTransaction().signer.publicKey);

  final b = tx._generateBytes();

  final List<int> rB = <int>[0, 0, 0, 0];
  rB.insertAll(4, sb.take(32));
  rB.insertAll(rB.length, b.skip(100).take(4));
  rB.insertAll(rB.length, b.skip(100 + 2 + 2 + 16).take(b.length - 120));

  final s = crypto.encodeBigInt(BigInt.from(b.length - 64 - 16));

  final sr = s.reversed;

  rB.replaceRange(0, s.length, sr);

  return Uint8List.fromList(rB);
}

Transaction _deserializeDTO(value) {
  switch (value.runtimeType) {
    case _TransferTransactionInfoDTO:
      return TransferTransaction.fromDTO(value);
    case _RegisterNamespaceTransactionInfoDTO:
      return RegisterNamespaceTransaction.fromDTO(value);
    case _MosaicDefinitionTransactionInfoDTO:
      return MosaicDefinitionTransaction.fromDTO(value);
    case _MosaicSupplyChangeTransactionInfoDTO:
      return MosaicSupplyChangeTransaction.fromDTO(value);
    case _AggregateTransactionInfoDTO:
      return AggregateTransaction.fromDTO(value);
    default:
      if (value is List) {
        value.map(_deserializeDTO).toList();
      }
      return null;
  }
}
