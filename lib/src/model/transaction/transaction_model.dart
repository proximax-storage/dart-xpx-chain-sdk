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
    _addressAliasVersion = 1,
    _registerNamespaceVersion = 2,
    _transferVersion = 3,
    _mosaicAliasVersion = 1,
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
    case TransactionType.addressAlias:
      return 'AddressAlias';
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

  List<int> toArray() {
    if (id == null) {
      return [0, 0];
    }
    final l = id.toUnsigned(32);
    final r = (id >> 32).toUnsigned(32);

    return List<int>.from([l.toInt(), r.toInt()]);
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

  int toBlockchainTimestamp() =>
      value.millisecondsSinceEpoch -
      _timestampNemesisBlock.millisecondsSinceEpoch;
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

class MultisigCosignatoryModification {
  MultisigCosignatoryModification(this.type, this.publicAccount);

  MultisigCosignatoryModification._fromDTO(
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
                  MultisigCosignatoryModification._fromDTO(networkType, value))
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
  Map<String, dynamic> toJson();
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

  String _transactionInfoToString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t\t\t"height": $height,')
      ..writeln('\t\t\t"index": $index,')
      ..writeln('\t\t\t"id": $id,');
    if (transactionHash != null) {
      sb.writeln('\t\t\t"transactionHash": $transactionHash,');
    }
    if (merkleComponentHash != null) {
      sb.writeln('\t\t\t"merkleComponentHash": $merkleComponentHash,');
    }
    if (aggregateHash != null) {
      sb.writeln('\t\t\t"aggregateHash": $aggregateHash,');
    }
    if (aggregateId != null) {
      sb.writeln('\t\t\t"aggregateId": $aggregateId,');
    }
    sb.write('\t\t}');
    return sb.toString();
  }

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
  AbstractTransaction._(
      [this.networkType,
      this.deadline,
      this.type,
      this.version,
      this.maxFee,
      this.signature,
      this.signer]);

  AbstractTransaction._fromDto(
      _AbstractTransactionDTO absValue, _MetaTransactionDTO metaValue) {
    networkType = extractNetworkType(absValue._version);
    deadline = Deadline.fromUInt64DTO(absValue._deadline);
    type = transactionTypeFromRaw(absValue._type);
    version = extractVersion(absValue._version);
    maxFee = absValue._fee.toBigInt();
    signature = absValue._signature;
    signer = PublicAccount.fromPublicKey(absValue._signer, networkType);
    _generateMeta(metaValue);
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

  void _generateMeta(_MetaTransactionDTO value) {
    height = value._height.toBigInt();
    index = value._index;
    id = value._id;
    transactionHash = value._hash;
    merkleComponentHash = value._merkleComponentHash;
    aggregateHash = value._aggregateHash;
    aggregateId = value._aggregateId;
  }

  Map<String, int> _generateVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType << 24) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['deadlineV'] = builder.writeListUint32(
        bigIntToArray(BigInt.from(deadline.toBlockchainTimestamp())));
    data['feeV'] = builder.writeListUint32(bigIntToArray(maxFee));
    return data;
  }

  void _buildVector(fb.Builder builder, Map<String, int> vector) {
    Transactions(builder)
      ..addSignatureOffset(vector['signatureV'])
      ..addSignerOffset(vector['signerV'])
      ..addVersion(vector['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vector['feeV'])
      ..addDeadlineOffset(vector['deadlineV']);
  }

  AbstractTransaction _getAbstractTransaction() => this;

  bool isUnconfirmed() =>
      height.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() =>
      height.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _abstractTransactionToString();

  String _abstractTransactionToString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t\t"transactionInfo": ${_transactionInfoToString()},')
      ..writeln('\t\t"networkType": $networkType,')
      ..writeln('\t\t"type": ${_transactionTypes.lookup(type)?._raw},')
      ..writeln('\t\t"version": $version,');
    if (maxFee != null) {
      sb.writeln('\t\t"maxFee": $maxFee,');
    }
    if (deadline != null) {
      sb.writeln('\t\t"deadline": $deadline,');
    }
    if (signature != null) {
      sb.writeln('\t\t"signature": $signature,');
    }
    sb.writeln('\t\t"signer": $signer,');
    sb.write('\t},');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() => _abstractTransactionToJson();

  Map<String, dynamic> _abstractTransactionToJson() {
    final Map<String, dynamic> data = {}..addAll(_transactionInfoToJson());
    data['networkType'] = networkType;
    data['type'] = _transactionTypes.lookup(type)._raw;
    data['version'] = version;
    data['maxFee'] = maxFee;
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
      : super._() {
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

  TransferTransaction._fromDTO(_TransferTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    mosaics = Mosaic.listFromDTO(value._transaction._mosaics);
    recipient = Address.fromEncoded(value._transaction._recipient);
    message = value._transaction._message != null
        ? Message._fromDTO(value._transaction._message)
        : null;
  }

  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  static List<TransferTransaction> listFromDTO(
          List<_TransferTransactionInfoDTO> json) =>
      json == null
          ? null
          : json.map((value) => TransferTransaction._fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()}')
      ..writeln('\t"recipient": $recipient')
      ..writeln('\t"mosaics": ${mosaics.map((v) => v.toJson()).toList()},');
    if (message != null) {
      print(message);
      sb.writeln('\t"message": $message,');
    }
    sb.write('}\n');
    return sb.toString();
  }

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
      (mosaicIdSize + amountSize) * mosaics.length +
      messageSize();

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final List<int> mb = List(mosaics.length);
    int i = 0;
    for (final mosaic in mosaics) {
      final id = builder.writeListUint32(mosaic.assetId.toArray());
      final amount = builder.writeListUint32(bigIntToArray(mosaic.amount));

      final ms = MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    }

    /// Create message;
    final mp = builder.writeListUint8(this.message.payload);
    final message = MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type.value)
      ..addPayloadOffset(mp);
    final int m = message.finish();

    final recipient = base32.decode(this.recipient.address);

    final rV = builder.writeListUint8(recipient);

    final mV = builder.writeList(mb);

    final vectors = _generateVector(builder);

    final txnBuilder = TransferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addRecipientOffset(rV)
      ..addNumMosaics(mosaics.length)
      ..addMessageSize(this.message.payload.length + 1)
      ..addMessageOffset(m)
      ..addMosaicsOffset(mV);
    _buildVector(builder, vectors);

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
      : super._() {
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
      namespaceName = rootNamespaceName;
      namespaceType = NamespaceType.root;
      this.duration = duration;
    }
  }

  RegisterNamespaceTransaction.createSub(Deadline deadline,
      String subNamespaceName, String rootNamespaceName, int networkType)
      : super._() {
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
      namespaceName = subNamespaceName;
      namespaceType = NamespaceType.sub;
    }
  }

  RegisterNamespaceTransaction._fromDTO(
      _RegisterNamespaceTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    namespaceId = NamespaceId._(value._transaction._namespaceId.toBigInt());
    namespaceType = value._transaction._namespaceType == 0
        ? NamespaceType.root
        : NamespaceType.sub;
    namespaceName = value._transaction._name;
    if (namespaceType == NamespaceType.root) {
      duration = value._transaction._duration.toBigInt();
    } else {
      parentId = NamespaceId._(value._transaction._parentId.toBigInt());
    }
  }

  NamespaceId namespaceId;
  NamespaceType namespaceType;
  String namespaceName;
  BigInt duration;
  NamespaceId parentId;

  static List<RegisterNamespaceTransaction> listFromDTO(
          List<_RegisterNamespaceTransactionInfoDTO> data) =>
      data == null
          ? List
          : data
              .map((value) => RegisterNamespaceTransaction._fromDTO(value))
              .toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()}')
      ..writeln('\t"namespaceType": ${namespaceType.toString().split('.')[1]},')
      ..writeln('\t"namespaceName": $namespaceName,')
      ..writeln('\t"namespaceId": $namespaceId,');
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
    data['namespaceName'] = namespaceName;
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

    final nV = builder.writeListUint32(bigIntToArray(namespaceId.toBigInt()));
    int dV;
    if (namespaceType == NamespaceType.root) {
      dV = builder.writeListUint32(bigIntToArray(duration));
    } else {
      dV = builder.writeListUint32(bigIntToArray(parentId.toBigInt()));
    }

    final n = builder.writeString(namespaceName);

    final vector = _generateVector(builder);

    final txnBuilder = RegisterNamespaceTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addNamespaceType(namespaceType.index)
      ..addDurationParentIdOffset(dV)
      ..addNamespaceIdOffset(nV)
      ..addNamespaceNameSize(namespaceName.length)
      ..addNamespaceNameOffset(n);
    _buildVector(builder, vector);

    final codedRegisterNamespace = txnBuilder.finish();
    return registerNamespaceTransactionSchema()
        .serialize(builder.finish(codedRegisterNamespace));
  }

  @override
  int _size() => registerNamespaceHeaderSize + namespaceName.length;
}

/// Register a new mosaic.
/// Announce a [MosaicDefinitionTransaction] to create a new [Mosaic].
///
class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicDefinitionTransaction(Deadline deadline, int nonce,
      String ownerPublicKey, MosaicProperties mosaicProps, int networkType)
      : super._() {
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
    }
  }

  MosaicDefinitionTransaction._fromDTO(
      _MosaicDefinitionTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    mosaicProperties =
        MosaicProperties._fromDTO(value._transaction._properties);
    mosaicNonce = value._transaction._mosaicNonce.toUnsigned(32);
    mosaicId = MosaicId.fromId(value._transaction._mosaicId.toBigInt());
  }

  MosaicProperties mosaicProperties;
  int mosaicNonce;
  MosaicId mosaicId;

  static List<MosaicDefinitionTransaction> listFromDTO(
          List<_MosaicDefinitionTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => MosaicDefinitionTransaction._fromDTO(value))
              .toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()}')
      ..writeln('\t"mosaicProperties": $mosaicProperties')
      ..writeln('\t"mosaicNonce": ${mosaicNonce.toSigned(64)},')
      ..writeln('\t"assetId": $mosaicId,')
      ..write('\t}\n');
    return sb.toString();
  }

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
  int _size() => mosaicDefinitionTransactionHeaderSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  int _buildMosaicPropertyBuffer(
      fb.Builder builder, List<MosaicProperty> properties) {
    if (properties == null) return 0;
    final List<int> pBuffer = List(properties.length);

    int i = 0;
    for (final p in properties) {
      final valueV = builder.writeListUint32(bigIntToArray(p.value));

      final mosaicBuilder = MosaicPropertyBuilder(builder)
        ..begin()
        ..addMosaicPropertyId(p.id.index)
        ..addValueOffset(valueV);
      pBuffer[i] = mosaicBuilder.finish();
      i++;
    }
    return builder.writeList(pBuffer);
  }

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    int f = 0;
    if (mosaicProperties.supplyMutable) {
      f += _supplyMutable;
    }
    if (mosaicProperties.transferable) {
      f += _transferable;
    }

    final mV = builder.writeListUint32(mosaicId.toArray());

    final pV = _buildMosaicPropertyBuffer(
        builder, mosaicProperties.optionalProperties);

    final vector = _generateVector(builder);

    final txnBuilder = MosaicDefinitionTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicNonce(mosaicNonce)
      ..addMosaicIdOffset(mV)
      ..addFlags(f)
      ..addDivisibility(mosaicProperties.divisibility)
      ..addNumOptionalProperties(mosaicProperties.optionalProperties.length)
      ..addOptionalPropertiesOffset(pV);

    _buildVector(builder, vector);

    final codedMosaicDefinition = txnBuilder.finish();

    return mosaicDefinitionTransactionSchema()
        .serialize(builder.finish(codedMosaicDefinition));
  }
}

/// Change an existent mosaic supply.
/// Announce a [MosaicSupplyChangeTransaction] to increase or decrease a mosaic’s supply.
///
class MosaicSupplyChangeTransaction extends AbstractTransaction
    implements Transaction {
  MosaicSupplyChangeTransaction(Deadline deadline, MosaicSupplyType supplyType,
      MosaicId mosaicId, BigInt delta, int networkType)
      : super._() {
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

  MosaicSupplyChangeTransaction._fromDTO(
      _MosaicSupplyChangeTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
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
              .map((value) => MosaicSupplyChangeTransaction._fromDTO(value))
              .toList();

  @override
  String toString() {
    final String _supplyType =
        mosaicSupplyType.index == 0 ? 'decrease' : 'increase';
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()}')
      ..writeln('\t"assetId": $mosaicId')
      ..writeln('\t"mosaicSupplyType": $_supplyType,')
      ..writeln('\t"delta": $delta')
      ..write('\t}');
    return sb.toString();
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

    final mV = builder.writeListUint32(mosaicId.toArray());

    final dV = builder.writeListUint32(bigIntToArray(delta));

    final vector = _generateVector(builder);

    final txnBuilder = MosaicSupplyChangeTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicIdOffset(mV)
      ..addDirection(mosaicSupplyType.index)
      ..addDeltaOffset(dV);
    _buildVector(builder, vector);

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
      : super._() {
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

  AggregateTransaction._fromDTO(_AggregateTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
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
          : json.map((value) => AggregateTransaction._fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_abstractTransactionToString()}')
      ..writeln('\t"innerTransactions": $innerTransactions,')
      ..writeln('\t"cosignatures": $cosignatures')
      ..write('}');
    return sb.toString();
  }

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

    final vector = _generateVector(builder);

    final txnBuilder = AggregateTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addTransactionsSize(txsBytes.length)
      ..addTransactionsOffset(tV);
    _buildVector(builder, vector);

    final codedAggregate = txnBuilder.finish();

    return aggregateTransactionSchema()
        .serialize(builder.finish(codedAggregate));
  }
}

// AggregateTransactionCosignature
class AggregateTransactionCosignature {
  AggregateTransactionCosignature(this._signature, this._signer);

  AggregateTransactionCosignature._fromDTO(
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
                  AggregateTransactionCosignature._fromDTO(networkType, value))
              .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = _signature;
    data['signer'] = _signer;
    return data;
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
        super._() {
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

  ModifyMultisigAccountTransaction._fromDTO(
      _ModifyMultisigAccountTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
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
              .map((value) => ModifyMultisigAccountTransaction._fromDTO(value))
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
      ..addSize(_size())
      ..addMinRemovalDelta(minRemovalDelta)
      ..addMinApprovalDelta(minApprovalDelta)
      ..addNumModifications(modifications.length)
      ..addModificationsOffset(mV);
    _buildVector(builder, vectors);

    final codedModifyMultisigAccount = txnBuilder.finish();
    return modifyMultisigAccountTransactionSchema()
        .serialize(builder.finish(codedModifyMultisigAccount));
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
        super._() {
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

  LockFundsTransaction._fromDTO(_LockFundsTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    mosaic = Mosaic(MosaicId.fromBigInt(value._transaction._assetId.toBigInt()),
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
      '\t"signedTxHash": ${signedTransaction.hash},\n'
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

    final mV = builder.writeListUint32(mosaic.assetId.toArray());

    final maV = builder.writeListUint32(fromBigInt(mosaic.amount));

    final dV = builder.writeListUint32(fromBigInt(duration));

    final h = hex.decode(signedTransaction.hash);

    final hV = builder.writeListUint8(h);

    final vectors = _generateVector(builder);

    final txnBuilder = LockFundsTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addDurationOffset(dV)
      ..addHashOffset(hV);
    _buildVector(builder, vectors);

    final codedLockFunds = txnBuilder.finish();

    return lockFundsTransactionSchema()
        .serialize(builder.finish(codedLockFunds));
  }
}

// AliasTransaction
class AliasTransaction extends AbstractTransaction implements Transaction {
  AliasTransaction._(int version, Deadline deadline, this.actionType,
      this.namespaceId, int networkType)
      : super._() {
    this.version = version;
    this.deadline = deadline;
    type = transactionTypeFromRaw(17230);
    this.networkType = networkType;
  }

  AliasTransaction._fromAddressAliasDTO(_AddressAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    actionType = value._transaction._aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = value._transaction._namespaceId != null
        ? NamespaceId.fromId(value._transaction._namespaceId.toBigInt())
        : null;
  }

  AliasTransaction._fromMosaicAliasDTO(_MosaicAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromDto(value._transaction, value._meta) {
    actionType = value._transaction._aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = value._transaction._namespaceId != null
        ? NamespaceId.fromId(value._transaction._namespaceId.toBigInt())
        : null;
  }

  AliasActionType actionType;
  NamespaceId namespaceId;

  String _aliasTransactionToString() {
    final String _actionType = actionType.index == 0 ? 'link' : 'unlink';
    return '{\n'
        '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
        '\t"aliasActionType": $_actionType,\n'
        '\t"namespaceId": ${namespaceId.toHex()},\n';
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

  Uint8List _generateAbstractBytes(fb.Builder builder, int aliasV) {
    final nV = builder.writeListUint32(namespaceId.toArray());

    final vectors = _generateVector(builder);

    final txnBuilder = AliasTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addActionType(actionType.index)
      ..addNamespaceIdOffset(nV)
      ..addAliasIdOffset(aliasV);
    _buildVector(builder, vectors);

    final codedAlias = txnBuilder.finish();

    return aliasTransactionSchema().serialize(builder.finish(codedAlias));
  }
}

class AddressAliasTransaction extends AliasTransaction {
  AddressAliasTransaction._(Deadline deadline, this.address,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(_addressAliasVersion, deadline, actionType, namespaceId,
            networkType);

  AddressAliasTransaction._fromDTO(_AddressAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromAddressAliasDTO(value) {
    address = Address.fromEncoded(value._transaction._address);
  }

  Address address;

  String _addressAliasTransactionToString() => '${super.toString()}'
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
  int _size() => super._size() + mosaicIdSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final a = base32.decode(address.address);

    final aV = builder.writeListUint8(a);

    return _generateAbstractBytes(builder, aV);
  }
}

class MosaicAliasTransaction extends AliasTransaction {
  MosaicAliasTransaction(Deadline deadline, this.mosaicId,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(_mosaicAliasVersion, deadline, actionType, namespaceId,
            networkType);

  MosaicAliasTransaction._fromDTO(
    _MosaicAliasTransactionInfoDTO value,
  )   : assert(value != null, 'value must not be null'),
        super._fromMosaicAliasDTO(value) {
    mosaicId = MosaicId.fromBigInt(value._transaction._mosaicId.toBigInt());
  }

  MosaicId mosaicId;

  String _mosaicAliasTransactionToString() => '${super.toString()}'
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
  int _size() => super._size() + mosaicIdSize;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final buffer = Uint8List(mosaicIdSize).buffer;
    final bufferData = ByteData.view(buffer)
      ..setUint64(0, mosaicId.toIn(), Endian.little);

    final mV = builder.writeListUint8(bufferData.buffer.asUint8List());

    return _generateAbstractBytes(builder, mV);
  }
}

SignedTransaction _signTransactionWith(
    Transaction tx, Account a, String generationHash) {
  final s = a.account;
  final b = tx._generateBytes();
  var sb = Uint8List.fromList(b.skip(100).take(b.length).toList());

  sb = Uint8List.fromList(hex.decode(generationHash) + sb);

  final signature = s.sign(sb);

  final p = <int>[]
    ..insertAll(0, b.skip(0).take(4))
    ..insertAll(4, signature)
    ..insertAll(4 + 64, a.account.publicKey.raw)
    ..insertAll(100, b.skip(100).take(b.length));

  final pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex, generationHash);

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

String _createTransactionHash(String pHex, String generationHash) {
  final p = hex.decode(pHex);

  final generationHashBytes = hexDecodeStringOdd(generationHash);

  final sb = <int>[]
    ..insertAll(0, p.skip(4).take(32))
    ..insertAll(32, p.skip(68).take(32))
    ..insertAll(64, generationHashBytes)
    ..addAll(p.skip(100));

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

  rB.insertAll(rB.length, b.skip(100).take(versionSize + typeSize));

  rB.insertAll(signerSize + sizeSize + versionSize + typeSize,
      b.skip(transactionHeaderSize));
  final s = Buffer.littleEndian(4)..writeInt32(b.length - 64 - 16);

  rB.replaceRange(0, s.out.length, s.out);

  return Uint8List.fromList(rB);
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

Transaction _deserializeDTO(value) {
  switch (value.runtimeType) {
    case _TransferTransactionInfoDTO:
      return TransferTransaction._fromDTO(value);
    case _RegisterNamespaceTransactionInfoDTO:
      return RegisterNamespaceTransaction._fromDTO(value);
    case _MosaicDefinitionTransactionInfoDTO:
      return MosaicDefinitionTransaction._fromDTO(value);
    case _MosaicSupplyChangeTransactionInfoDTO:
      return MosaicSupplyChangeTransaction._fromDTO(value);
    case _MosaicAliasTransactionInfoDTO:
      return MosaicAliasTransaction._fromDTO(value);
    case _AggregateTransactionInfoDTO:
      return AggregateTransaction._fromDTO(value);
    case _AddressAliasTransactionInfoDTO:
      return AddressAliasTransaction._fromDTO(value);
    case _ModifyMultisigAccountTransactionInfoDTO:
      return ModifyMultisigAccountTransaction._fromDTO(value);
    case _LockFundsTransactionInfoDTO:
      return LockFundsTransaction._fromDTO(value);
    default:
      if (value is List) {
        value.map(_deserializeDTO).toList();
      }
      return null;
  }
}
