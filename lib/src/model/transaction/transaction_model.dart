part of xpx_chain_sdk.transaction;

// CosignatureSignedTransaction
class CosignatureSignedTransaction {
  CosignatureSignedTransaction(this._parentHash, this.signature, this.signer);

  final String _parentHash;
  final String signature;
  final String signer;

  String get hash => _parentHash;

  @override
  String toString() => '{\n'
      '\t"parentHash": $_parentHash\n'
      '\t"signature": $signature\n'
      '\t"signer": $signer\n'
      '}\n';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentHash'] = _parentHash;
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}

abstract class Transaction {
  AbstractTransaction absTransaction();

  TransactionType entityType();

  Map<String, dynamic> toJson();

  Uint8List generateBytes();

  int _size();
}

// Transaction Info
mixin TransactionInfo {
  Uint64 height;
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

class TransactionType {
  const TransactionType._internal(this.value);

  static const TransactionType aggregateCompleted = TransactionType._internal(0x4141);

  static const TransactionType aggregateBonded = TransactionType._internal(0x4241);

  static const TransactionType addressAlias = TransactionType._internal(0x424E);

  static const TransactionType metadataAddress = TransactionType._internal(0x413d);

  static const TransactionType metadataMosaic = TransactionType._internal(0x423d);

  static const TransactionType metadataNamespace = TransactionType._internal(0x433d);

  static const TransactionType mosaicDefinition = TransactionType._internal(0x414d);

  static const TransactionType mosaicAlias = TransactionType._internal(0x434e);

  static const TransactionType mosaicSupplyChange = TransactionType._internal(0x424d);

  static const TransactionType modifyMultisig = TransactionType._internal(0x4155);

  static const TransactionType modifyContract = TransactionType._internal(0x4157);

  static const TransactionType registerNamespace = TransactionType._internal(0x414e);

  static const TransactionType transfer = TransactionType._internal(0x4154);

  static const TransactionType lock = TransactionType._internal(0x4148);

  static const TransactionType secretLock = TransactionType._internal(0x4152);

  static const TransactionType secretProof = TransactionType._internal(0x4252);

  static const TransactionType addExchangeOffer = TransactionType._internal(0x415D);

  static const TransactionType exchangeOffer = TransactionType._internal(0x425D);

  static const TransactionType removeExchangeOffer = TransactionType._internal(0x435D);

  static const TransactionType accountPropertyAddress = TransactionType._internal(0x4150);

  static const TransactionType accountPropertyMosaic = TransactionType._internal(0x4250);

  static const TransactionType accountPropertyEntityType = TransactionType._internal(0x4350);

  final int value;

  static final List<TransactionType> list = <TransactionType>[
    accountPropertyAddress,
    accountPropertyMosaic,
    accountPropertyEntityType,
    aggregateCompleted,
    aggregateBonded,
    addressAlias,
    metadataAddress,
    metadataMosaic,
    metadataNamespace,
    mosaicDefinition,
    mosaicAlias,
    mosaicSupplyChange,
    modifyMultisig,
    modifyContract,
    registerNamespace,
    transfer,
    lock,
    secretLock,
    secretProof,
    addExchangeOffer,
    exchangeOffer,
    removeExchangeOffer
  ];

  static TransactionType fromInt(int value) {
    for (var type in list) {
      if (type.value == value) {
        return type;
      }
    }

    throw errUnknownTransactionType;
  }

  Uint8List toBytes() {
    final buffer = Uint8List(2).buffer;
    final s = ByteData.view(buffer);

    s.setInt16(0, TransactionType.addExchangeOffer.value, Endian.little);
    return buffer.asUint8List();
  }

  @override
  String toString() => value.toString();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}

class Deadline {
  Deadline(
      {int days = 0, int hours = 0, int minutes = 0, int seconds = 0, int milliseconds = 0, int microseconds = 0}) {
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
      : assert(data.lower != null || data.higher == null, 'lower or higher must not be null') {
    value = data.toUint64() != null
        ? DateTime.fromMillisecondsSinceEpoch(
            data.toUint64().toInt() + timestampNemesisBlock.toUtc().millisecondsSinceEpoch)
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

  int toBlockchainTimestamp() => value.millisecondsSinceEpoch - timestampNemesisBlock.millisecondsSinceEpoch;
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

class AbstractTransaction with TransactionInfo {
  AbstractTransaction(
      [this.networkType, this.deadline, this.type, this.version, this.maxFee, this.signature, this.signer]);

  AbstractTransaction.fromDto(AbstractTransactionDTO absValue, MetaTransactionDTO metaValue) {
    networkType = extractNetworkType(absValue.version);
    deadline = Deadline.fromUInt64DTO(absValue.deadline);
    type = TransactionType.fromInt(absValue.type);
    version = extractVersion(absValue.version);
    maxFee = absValue.fee.toUint64();
    signature = absValue.signature;
    signer = PublicAccount.fromPublicKey(absValue.signer, networkType);
    _generateMeta(metaValue);
  }

  int networkType;
  Deadline deadline;
  TransactionType type;
  int version;
  Uint64 maxFee;
  String signature;
  PublicAccount signer;

  PublicAccount get toAggregate => signer;

  set toAggregate(PublicAccount signer) => this.signer = signer;

  void _generateMeta(MetaTransactionDTO dto) {
    height = dto._height.toUint64();
    index = dto._index;
    id = dto._id;
    transactionHash = dto._hash;
    merkleComponentHash = dto._merkleComponentHash;
    aggregateHash = dto._aggregateHash;
    aggregateId = dto._aggregateId;
  }

  Map<String, int> _generateVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType << 24) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['deadlineV'] = builder.writeListUint32(Uint64(deadline.toBlockchainTimestamp()).toIntArray());
    data['feeV'] = builder.writeListUint32(maxFee != null ? maxFee.toIntArray() : [0, 0]);
    return data;
  }

  void _buildVector(fb.Builder builder, Map<String, int> vector) {
    Transactions(builder)
      ..addSignatureOffset(vector['signatureV'])
      ..addSignerOffset(vector['signerV'])
      ..addVersion(vector['versionV'])
      ..addType(type.value)
      ..addFeeOffset(vector['feeV'])
      ..addDeadlineOffset(vector['deadlineV']);
  }

  AbstractTransaction _absTransaction() => this;

  bool isUnconfirmed() => height.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() => height.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _absToString();

  String _absToString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t\t"transactionInfo": ${_transactionInfoToString()},')
      ..writeln('\t\t"networkType": $networkType,')
      ..writeln('\t\t"type": $type')
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
  Map<String, dynamic> toJson() => _absToJson();

  Map<String, dynamic> _absToJson() {
    final Map<String, dynamic> data = {}..addAll(_transactionInfoToJson());
    data['networkType'] = networkType;
    data['type'] = type;
    data['version'] = version;
    data['maxFee'] = maxFee;
    data['deadline'] = deadline;
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}
