part of xpx_chain_sdk;

RegExp _hexadecimal = RegExp(r'^[0-9a-fA-F]+$');

var _transactionTypes = <_TransactionTypeClass>{
  _TransactionTypeClass(TransactionType.aggregateCompleted, 16705, 0x4141),
  _TransactionTypeClass(TransactionType.aggregateBonded, 16961, 0x4241),
  _TransactionTypeClass(TransactionType.addressAlias, 16974, 0x424E),
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
    _aggregateBondedVersion = 2,
    _registerNamespaceVersion = 2,
    _transferVersion = 3,
    _mosaicDefinitionVersion = 3,
    _mosaicSupplyChangeVersion = 2,
    _modifyMultisigVersion = 3,
    _lockVersion = 1;

//    _modifyContractVersion = 3,
//    _metadataAddressVersion = 1,
//    _metadataMosaicVersion = 1,
//    _metadataNamespaceVersion = 1,
//    _secretLockVersion = 1,
//    _secretProofVersion = 1;

// TransactionType enums
enum TransactionType {
  aggregateCompleted,
  aggregateBonded,
  addressAlias,
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

var _timestampNemesisBlock = DateTime.fromMillisecondsSinceEpoch(1459468800000);

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

  final TransactionType _transactionType;
  final int _raw;
  final int _hex;

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
      : assert(data._lower != null || data._higher == null,
            'lower or higher must not be null') {
    value = data.toBigInt() != null
        ? DateTime.fromMillisecondsSinceEpoch(data.toBigInt().toInt() +
            _timestampNemesisBlock.toUtc().millisecondsSinceEpoch)
        : null;
  }

  DateTime value;

  @override
  String toString() {
    if (value != null) {
      return '$value ${value.timeZoneName}';
    } else {
      return 'null';
    }
  }

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

  @override
  String toString() => '{\n'
      '\t"transactionType": $transactionType\n'
      '\t"payload": $payload\n'
      '\t"hash": $hash\n'
      '}\n';

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

  final String _parentHash;
  final String _signature;
  final String _signer;

  String get hash => _parentHash;

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

class MultisigCosignatoryModification {
  MultisigCosignatoryModification(this.type, this.publicAccount);

  MultisigCosignatoryModification.fromDTO(
      int networkType, _MultisigCosignatoryModificationDTO value) {
    if (value?._cosignatoryPublicKey == null) {
      return;
    }

    type = value._type == 0 ? add : remove;
    publicAccount =
        PublicAccount.fromPublicKey(value._cosignatoryPublicKey, networkType);
  }

  MultisigCosignatoryModificationType type;
  PublicAccount publicAccount;

  @override
  String toString() => '{\n'
      '\t"type": ${type.index}\n'
      '\t"publicAccount": $publicAccount\n'
      '}\n';

  static List<MultisigCosignatoryModification> listFromDTO(
          int networkType, List<_MultisigCosignatoryModificationDTO> json) =>
      json == null
          ? null
          : json
              .map((value) =>
                  MultisigCosignatoryModification.fromDTO(networkType, value))
              .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type.index;
    data['publicAccount'] = publicAccount;
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
  String transactionHash;
  String merkleComponentHash;
  String aggregateHash;
  String aggregateId;

  TransactionInfo get getTransactionInfo => this;

  String _transactionInfoToString() => '{\n'
      '\t"height": $height,\n'
      '\t"index": $index,\n'
      '\t"id": $id,\n'
      '\t"transactionHash": $transactionHash,\n'
      '\t"merkleComponentHash": $merkleComponentHash\n'
      '\t"aggregateHash": $aggregateHash,\n'
      '\t"aggregateId": $aggregateId,\n'
      '\t}';

  @override
  String toString() => _transactionInfoToString();

  Map<String, dynamic> toJson() => _transactionInfoToJson();

  Map<String, dynamic> _transactionInfoToJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['index'] = index;
    data['id'] = id;
    data['transactionHash'] = transactionHash;
    data['merkleComponentHash'] = merkleComponentHash;
    data['aggregateHash'] = aggregateHash;
    data['aggregateId'] = aggregateId;

    return data;
  }
}

class AbstractTransaction with TransactionInfo {
  AbstractTransaction(
      [BigInt height,
      int index,
      String id,
      String hash,
      String merkleComponentHash,
      String aggregateHash,
      String aggregateId]) {
    this.height = height;
    this.index = index;
    this.id = id;
    transactionHash = hash;
    this.merkleComponentHash = merkleComponentHash;
    this.aggregateHash = aggregateHash;
    this.aggregateId = aggregateId;
  }

  int networkType;
  Deadline deadline;
  _TransactionTypeClass type;
  int version;
  BigInt maxFee;
  String signature;
  PublicAccount signer;

  PublicAccount get toAggregate => signer;
  set toAggregate(PublicAccount signer) => this.signer = signer;

  Map<String, int> _generateVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType << 8) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['feeV'] = builder.writeListUint32(fromBigInt(maxFee));
    data['deadlineV'] = builder.writeListUint32(
        fromBigInt(BigInt.from(deadline.getInstant().toInt())));
    return data;
  }

  void _buildVector(fb.Builder builder, int versionV, int signatureV,
      int signerV, int deadlineV, int feeV) {
    Transactions(builder)
      ..addSignatureOffset(signatureV)
      ..addSignerOffset(signerV)
      ..addVersion(versionV)
      ..addType(type._hex)
      ..addFeeOffset(feeV)
      ..addDeadlineOffset(deadlineV);
  }

  AbstractTransaction _getAbstractTransaction() {
    final abs = AbstractTransaction()
      ..height = height
      ..index = index
      ..id = id
      ..transactionHash = transactionHash
      ..merkleComponentHash = merkleComponentHash
      ..networkType = networkType
      ..deadline = deadline
      ..type = type
      ..version = version
      ..maxFee = maxFee
      ..signature = signature
      ..signer = signer;
    return abs;
  }

  bool isUnconfirmed() =>
      height.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() =>
      height.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _abstractTransactionToString();

  String _abstractTransactionToString() => '{\n'
      '\t"transactionInfo": ${_transactionInfoToString()}\n'
      '\t"networkType": $networkType,\n'
      '\t"type": ${_transactionTypes.lookup(type)?._raw},\n'
      '\t"version": $version,\n'
      '\t"maxFee": $maxFee,\n'
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
    data['MaxFee'] = maxFee;
    data['deadline'] = deadline;
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}

/// Send mosaics and messages between two accounts.
/// Announce a [TransferTransaction] to send [Mosaic] or [Message] between two [Account].
///
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
            value._meta._merkleComponentHash,
            value._meta._aggregateHash,
            value._meta._aggregateId) {
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);
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
    final payload = this.message.payload;
    final mp =
        this.message.type.value == 0 ? builder.writeListUint8(payload) : null;
    final message = MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type.value)
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

/// Register a namespace to organize your assets.
/// Announce a [RegisterNamespaceTransaction] to register and re-rent a namespace.
///
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
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);

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
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()},')
      ..writeln('\t"namespaceType": ${namespaceType.toString().split('.')[1]},')
      ..writeln('\t"namspaceName": $namspaceName,');
    if (parentId != null) {
      sb.writeln('\t"parentId": ${parentId.toHex()},');
    }
    if (duration != null) {
      sb.writeln('\t"duration": $duration');
    }
    sb.write('}\n');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['namespaceId'] = namespaceId.toHex();
    data['namespaceType'] = namespaceType;
    data['namspaceName'] = namspaceName;
    if (parentId != null) {
      data['parentId'] = parentId.toHex();
    }
    if (parentId != null) {
      data['duration'] = duration;
    }
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

/// Register a new mosaic.
/// Announce a [MosaicDefinitionTransaction] to create a new [Mosaic].
///
class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicDefinitionTransaction(Deadline deadline, int nonce,
      String ownerPublicKey, MosaicProperties mosaicProps, int networkType)
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
      duration = mosaicProps.duration;
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
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);

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
    if (mosaicProperties.optionalProperties == null) {
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

/// Change an existent mosaic supply.
/// Announce a [MosaicSupplyChangeTransaction] to increase or decrease a mosaic’s supply.
///
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
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);
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

/// Aggregate Complete send transactions in batches to different [Account].
/// Aggregate Bonded propose many transactions between different [Account].
///
class AggregateTransaction extends AbstractTransaction implements Transaction {
  factory AggregateTransaction.bonded(
          Deadline deadline, List<Transaction> innerTxs, int networkType) =>
      AggregateTransaction._(deadline, innerTxs, networkType,
          _aggregateBondedVersion, transactionTypeFromRaw(16961));

  factory AggregateTransaction.complete(
          Deadline deadline, List<Transaction> innerTxs, int networkType) =>
      AggregateTransaction._(deadline, innerTxs, networkType,
          _aggregateCompletedVersion, transactionTypeFromRaw(16705));

  AggregateTransaction._(Deadline deadline, List<Transaction> innerTxs,
      int networkType, int version, _TransactionTypeClass type)
      : super() {
    if (innerTxs.isEmpty == null) {
      throw _errNullInnerTransactions;
    } else {
      this.version = version;
      this.deadline = deadline;
      this.type = type;
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
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);
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

/// Cosign an aggregate bonded transaction.
/// [CosignatureTransaction] are used to sign announced aggregate bonded transactions with missing cosignatures.
///
class CosignatureTransaction {
  CosignatureTransaction(this._transactionToCosign);

  final AggregateTransaction _transactionToCosign;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionToCosign'] = _transactionToCosign;
    return data;
  }
}

/// Create or modify a multisig contract.
/// Announce a modify multisig account transaction to:
/// a) Transform an account to multisig account.
/// b) Change the configurable properties of a multisig account.
/// c) Add or delete cosignatories from a multisig account.
///
class ModifyMultisigAccountTransaction extends AbstractTransaction
    implements Transaction {
  ModifyMultisigAccountTransaction(
      Deadline deadline,
      int minApproval,
      int minRemoval,
      List<MultisigCosignatoryModification> modifications,
      int networkType)
      : assert(modifications != null, 'modifications must not be null'),
        super() {
    if (modifications.isEmpty && minApproval == 0 && minRemoval == 0) {
      throw _errEmptyModifications;
    } else {
      version = _modifyMultisigVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16725);
      this.networkType = networkType;
      minApprovalDelta = minApproval;
      minRemovalDelta = minRemoval;
      this.modifications = modifications;
    }
  }

  ModifyMultisigAccountTransaction.fromDTO(
      _ModifyMultisigAccountTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);

    minApprovalDelta = value._transaction._minApprovalDelta;
    minRemovalDelta = value._transaction._minRemovalDelta;
    modifications = MultisigCosignatoryModification.listFromDTO(
        networkType, value._transaction._modifications);
  }

  int minApprovalDelta;

  int minRemovalDelta;

  List<MultisigCosignatoryModification> modifications;

  static List<ModifyMultisigAccountTransaction> listFromDTO(
          List<_ModifyMultisigAccountTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => ModifyMultisigAccountTransaction.fromDTO(value))
              .toList();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"minApproval": $minApprovalDelta,\n'
      '\t"cosignatures": $minRemovalDelta,\n'
      '\t"modifications": $modifications,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['minApproval'] = minApprovalDelta;
    data['minRemoval'] = minRemovalDelta;
    data['modifications'] = modifications;

    return data;
  }

  @override
  int _size() =>
      modifyMultisigHeaderSize +
      ((keySize + 1 /* MultisigModificationType size */) *
          modifications.length);

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = cosignatoryModificationArrayToBuffer(builder, modifications);

    final vectors = _generateVector(builder);

    final txnBuilder = ModifyMultisigAccountTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size());
    _buildVector(builder, vectors['versionV'], vectors['signatureV'],
        vectors['signerV'], vectors['deadlineV'], vectors['feeV']);
    txnBuilder.addMinRemovalDelta(minRemovalDelta);
    txnBuilder.addMinApprovalDelta(minApprovalDelta);
    txnBuilder.addNumModifications(modifications.length);
    txnBuilder.addModificationsOffset(mV);
    final codedTransfer = txnBuilder.finish();
    return modifyMultisigAccountTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

/// A deposit before announcing aggregate bonded transactions.
/// Alias: LockFundsTransaction
///
class LockFundsTransaction extends AbstractTransaction implements Transaction {
  LockFundsTransaction(Deadline deadline, Mosaic mosaic, BigInt duration,
      SignedTransaction signedTx, int networkType)
      : assert(mosaic != null, 'mosaic must not be null'),
        assert(duration != null, 'duration must not be null'),
        assert(signedTx != null, 'signedTx must not be null'),
        super() {
    if (signedTx.transactionType != transactionTypeFromRaw(16961)._hex) {
      throw _errEmptyModifications;
    } else {
      version = _lockVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16712);
      this.networkType = networkType;
      this.mosaic = mosaic;
      this.duration = duration;
      signedTransaction = signedTx;
    }
  }

  LockFundsTransaction.fromDTO(_LockFundsTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super(
            value._meta._height.toBigInt(),
            value._meta._index,
            value._meta._id,
            value._meta._hash,
            value._meta._merkleComponentHash) {
    type = transactionTypeFromRaw(value._transaction._type);
    deadline = Deadline.fromUInt64DTO(value._transaction._deadline);
    signature = value._transaction._signature;
    networkType = extractNetworkType(value._transaction._version);
    version = extractVersion(value._transaction._version);
    maxFee = value._transaction._fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction._signer, networkType);

    mosaic = Mosaic(MosaicId.fromBigInt(value._transaction._mosaic.toBigInt()),
        value._transaction._amount.toBigInt());
    duration = value._transaction._duration.toBigInt();
    signedTransaction = SignedTransaction(0x4148, '', value._transaction._hash);
  }

  Mosaic mosaic;

  BigInt duration;

  SignedTransaction signedTransaction;

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"mosaic": $mosaic,\n'
      '\t"duration": $duration,\n'
      '\t"signedTxHash": $signedTransaction,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaic'] = mosaic;
    data['duration'] = duration;
    data['signedTransaction'] = signedTransaction;

    return data;
  }

  @override
  int _size() => lockSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(bigIntToList(mosaic.id.toBigInt()));

    final maV = builder.writeListUint32(fromBigInt(mosaic.amount));

    final dV = builder.writeListUint32(fromBigInt(duration));

    final h = hex.decode(signedTransaction.hash);

    final hV = builder.writeListUint8(h);

    final vectors = _generateVector(builder);

    final txnBuilder = LockFundsTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size());
    _buildVector(builder, vectors['versionV'], vectors['signatureV'],
        vectors['signerV'], vectors['deadlineV'], vectors['feeV']);
    txnBuilder.addMosaicIdOffset(mV);
    txnBuilder.addMosaicAmountOffset(maV);
    txnBuilder.addDurationOffset(dV);
    txnBuilder.addHashOffset(hV);
    final codedTransfer = txnBuilder.finish();

    return lockFundsTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

// AliasTransaction
class AliasTransaction extends AbstractTransaction implements Transaction {
  AliasTransaction._(
      Deadline deadline, this.actionType, this.namespaceId, int networkType)
      : super() {
    version = _lockVersion;
    this.deadline = deadline;
    type = transactionTypeFromRaw(17230);
    this.networkType = networkType;
  }

  AliasActionType actionType;
  NamespaceId namespaceId;

  String _aliasTransactionToString() {
    final String _actionType =
        actionType.index == 0 ? 'aliasLink' : 'aliasUnlink';
    return '{\n'
        '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
        '\t"aliasActionType": $_actionType,\n'
        '\t"namespaceId": ${namespaceId.toHex()}\n'
        '}\n';
  }

  @override
  String toString() => _aliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _aliasTransactionToJson();

  Map<String, dynamic> _aliasTransactionToJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    if (actionType != null) {
      data['aliasActionType'] = actionType.index;
    }
    data['namespaceId'] = namespaceId.toHex();
    return data;
  }

  @override
  int _size() => aliasTransactionHeader;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() => null;

  Uint8List _generateAstractBytes(fb.Builder builder, int aliasV) {
    final nV = builder.writeListUint32(bigIntToList(namespaceId.toBigInt()));

    final vectors = _generateVector(builder);

    final txnBuilder = AliasTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size());
    _buildVector(builder, vectors['versionV'], vectors['signatureV'],
        vectors['signerV'], vectors['deadlineV'], vectors['feeV']);
    txnBuilder.addActionType(actionType.index);
    txnBuilder.addNamespaceIdOffset(nV);
    txnBuilder.addAliasIdOffset(aliasV);

    final codedAlias = txnBuilder.finish();
    return aliasTransactionSchema().serialize(builder.finish(codedAlias));
  }
}

class MosaicAliasTransaction extends AliasTransaction {
  MosaicAliasTransaction(Deadline deadline, this.mosaicId,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(deadline, actionType, namespaceId, networkType);

  MosaicId mosaicId;

  String _mosaicAliasTransactionToString() => '{\n'
      '${super.toString()}'
      '\t"mosaicId": ${mosaicId.toHex()}\n'
      '}\n';

  @override
  String toString() => _mosaicAliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _mosaicAliasTransactionToJson();

  Map<String, dynamic> _mosaicAliasTransactionToJson() {
    final data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (actionType != null) {
      data['mosaicId'] = mosaicId.toHex();
    }
    return data;
  }

  @override
  int _size() => super._size() + mosaicSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final buffer = Uint8List(mosaicSize).buffer;
    final bufferData = ByteData.view(buffer)
      ..setUint64(0, mosaicId.toIn(), Endian.little);

    final mV = builder.writeListUint8(bufferData.buffer.asUint8List());

    return _generateAstractBytes(builder, mV);
  }
}

class AddressAliasTransaction extends AliasTransaction {
  AddressAliasTransaction(Deadline deadline, this.address,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(deadline, actionType, namespaceId, networkType);

  Address address;

  String _addressAliasTransactionToString() => '{\n'
      '${super.toString()}'
      '\t"address": $address\n'
      '}\n';

  @override
  String toString() => _addressAliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _addressAliasTransactionToJson();

  Map<String, dynamic> _addressAliasTransactionToJson() {
    final data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (actionType != null) {
      data['address'] = address;
    }
    return data;
  }

  @override
  int _size() => super._size() + mosaicSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final a = base32.decode(address.address);

    final aV = builder.writeListUint8(a);

    return _generateAstractBytes(builder, aV);
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
    ..insertAll(4 + 64, a.account.publicKey.raw)
    ..insertAll(100, b.skip(100).take(b.length));

  final pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex);

  return SignedTransaction(
      tx.getAbstractTransaction().type.raw, pHex.toUpperCase(), hash);
}

CosignatureSignedTransaction _signCosignatureTransaction(
    CosignatureTransaction tx, Account a) {
  if (tx._transactionToCosign.getTransactionInfo == null ||
      tx._transactionToCosign.getTransactionInfo.transactionHash == '') {
    throw _errCosignatureTxHash;
  }

  final signer = a.account;

  final hashByte =
      hex.decode(tx._transactionToCosign.getTransactionInfo.transactionHash);

  final signatureByte = signer.sign(hashByte);

  return CosignatureSignedTransaction(
      tx._transactionToCosign.getTransactionInfo.transactionHash,
      hex.encode(signatureByte),
      signer.publicKey.toString());
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
    case _ModifyMultisigAccountTransactionInfoDTO:
      return ModifyMultisigAccountTransaction.fromDTO(value);
    case _LockFundsTransactionInfoDTO:
      return LockFundsTransaction.fromDTO(value);
    default:
      if (value is List) {
        value.map(_deserializeDTO).toList();
      }
      return null;
  }
}

int cosignatoryModificationArrayToBuffer(
    fb.Builder builder, List<MultisigCosignatoryModification> modifications) {
  final msb = <int>[];
  for (final m in modifications) {
    final b = hexDecodeStringOdd(m.publicAccount.publicKey);
    final pV = builder.writeListUint8(b);
    final txnBuilder = CosignatoryModificationBufferBuilder(builder)
      ..begin()
      ..addType(m.type.index)
      ..addCosignatoryPublicKeyOffset(pV);
    msb.add(txnBuilder.finish());
  }
  return builder.writeList(msb);
}
