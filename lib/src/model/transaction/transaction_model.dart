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

abstract class Id {
  const Id(this.id);

  final Uint64 id;

  @override
  String toString() => toHex();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Id && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => 'Id'.hashCode ^ id.hashCode;

  String toHex() {
    if (id == null) {
      return null;
    }

    var s = id.toHex().toUpperCase();
    if (s.length % 2 != 0) {
      s = '0$s';
    }
    return s;
  }

  List<int> toIntArray() => id.toIntArray();

  Uint64 toUint64() => id;

  Uint8List toBytes() => id.toBytes();
}

abstract class Transaction {
  AbstractTransaction _abstractTransaction();
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

class _TransactionTypeClass {
  _TransactionTypeClass([this._transactionType, this._raw, this._hex]);

  final TransactionType _transactionType;
  final int _raw;
  final int _hex;

  TransactionType get transactionType => _transactionType;
  int get raw => _raw;
  int get hex => _hex;
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
    value = data.toUint64() != null
        ? DateTime.fromMillisecondsSinceEpoch(data.toUint64().toInt() +
            timestampNemesisBlock.toUtc().millisecondsSinceEpoch)
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
      timestampNemesisBlock.millisecondsSinceEpoch;
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
      [this.networkType,
      this.deadline,
      this.type,
      this.version,
      this.maxFee,
      this.signature,
      this.signer]);

  AbstractTransaction.fromDto(
      AbstractTransactionDTO absValue, MetaTransactionDTO metaValue) {
    networkType = extractNetworkType(absValue.version);
    deadline = Deadline.fromUInt64DTO(absValue.deadline);
    type = transactionTypeFromRaw(absValue.type);
    version = extractVersion(absValue.version);
    maxFee = absValue.fee.toUint64();
    signature = absValue.signature;
    signer = PublicAccount.fromPublicKey(absValue.signer, networkType);
    _generateMeta(metaValue);
  }

  int networkType;
  Deadline deadline;
  _TransactionTypeClass type;
  int version;
  Uint64 maxFee;
  String signature;
  PublicAccount signer;

  PublicAccount get toAggregate => signer;
  set toAggregate(PublicAccount signer) => this.signer = signer;

  void _generateMeta(MetaTransactionDTO value) {
    height = value._height.toUint64();
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
    data['deadlineV'] = builder
        .writeListUint32(Uint64(deadline.toBlockchainTimestamp()).toIntArray());
    data['feeV'] =
        builder.writeListUint32(maxFee != null ? maxFee.toIntArray() : [0, 0]);
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

  AbstractTransaction _absTransaction() => this;

  bool isUnconfirmed() =>
      height.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() =>
      height.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => _absToString();

  String _absToString() {
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
  Map<String, dynamic> toJson() => _absToJson();

  Map<String, dynamic> _absToJson() {
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
