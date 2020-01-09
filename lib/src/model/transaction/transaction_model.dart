part of xpx_chain_sdk.transaction;

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

  String toHex() {
    if (id == null) {
      return null;
    }

    var s = id.toRadixString(16).toUpperCase();
    if (s.length % 2 != 0) {
      s = '0$s';
    }
    return s;
  }

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
      : assert(data.lower != null || data.higher == null,
            'lower or higher must not be null') {
    value = data.toBigInt() != null
        ? DateTime.fromMillisecondsSinceEpoch(data.toBigInt().toInt() +
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

class MultisigCosignatoryModification {
  MultisigCosignatoryModification(this.type, this.publicAccount);

  MultisigCosignatoryModification.fromDTO(
      int networkType, _MultisigCosignatoryModificationDTO value) {
    if (value?._cosignatoryPublicKey == null) {
      return;
    }

    type = value.type == 0 ? add : remove;
    publicAccount =
        PublicAccount.fromPublicKey(value._cosignatoryPublicKey, networkType);
  }

  MultisigCosignatoryModificationType type;
  PublicAccount publicAccount;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": ${type.index},')
      ..writeln('\t"publicAccount": $publicAccount')
      ..write('}');
    return sb.toString();
  }

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
  Map<String, dynamic> toJson();
  Uint8List generateBytes();
  int size();
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
    maxFee = absValue.fee.toBigInt();
    signature = absValue.signature;
    signer = PublicAccount.fromPublicKey(absValue.signer, networkType);
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

  void _generateMeta(MetaTransactionDTO value) {
    height = value._height.toBigInt();
    index = value._index;
    id = value._id;
    transactionHash = value._hash;
    merkleComponentHash = value._merkleComponentHash;
    aggregateHash = value._aggregateHash;
    aggregateId = value._aggregateId;
  }

  Map<String, int> generateVector(fb.Builder builder) {
    final Map<String, int> data = {};
    data['versionV'] = (networkType << 24) + version;
    data['signatureV'] = builder.writeListUint8(Uint8List(signatureSize));
    data['signerV'] = builder.writeListUint8(Uint8List(signerSize));
    data['deadlineV'] = builder.writeListUint32(
        bigIntToArray(BigInt.from(deadline.toBlockchainTimestamp())));
    data['feeV'] = builder.writeListUint32(bigIntToArray(maxFee));
    return data;
  }

  void buildVector(fb.Builder builder, Map<String, int> vector) {
    Transactions(builder)
      ..addSignatureOffset(vector['signatureV'])
      ..addSignerOffset(vector['signerV'])
      ..addVersion(vector['versionV'])
      ..addType(type._hex)
      ..addFeeOffset(vector['feeV'])
      ..addDeadlineOffset(vector['deadlineV']);
  }

  AbstractTransaction getAbstractTransaction() => this;

  bool isUnconfirmed() =>
      height.toInt() == 0 && transactionHash == merkleComponentHash;

  bool isConfirmed() => height.toInt() > 0;

  bool hasMissingSignatures() =>
      height.toInt() == 0 && transactionHash != merkleComponentHash;

  bool isUnannounced() => this == null;

  @override
  String toString() => abstractTransactionToString();

  String abstractTransactionToString() {
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
  Map<String, dynamic> toJson() => abstractTransactionToJson();

  Map<String, dynamic> abstractTransactionToJson() {
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
      throw errEmptyModifications;
    } else {
      version = modifyMultisigVersion;
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
        super.fromDto(value._transaction, value.meta) {
    type = transactionTypeFromRaw(value._transaction.type);
    deadline = Deadline.fromUInt64DTO(value._transaction.deadline);
    signature = value._transaction.signature;
    networkType = extractNetworkType(value._transaction.version);
    version = extractVersion(value._transaction.version);
    maxFee = value._transaction.fee.toBigInt();
    signer =
        PublicAccount.fromPublicKey(value._transaction.signer, networkType);

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
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${abstractTransactionToString()}')
      ..writeln('\t"minApproval": $minApprovalDelta,')
      ..writeln('\t"minRemoval": $minRemovalDelta,')
      ..writeln('\t"modifications": $modifications')
      ..write('}');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    data['minApproval'] = minApprovalDelta;
    data['minRemoval'] = minRemovalDelta;
    data['modifications'] = modifications;

    return data;
  }

  @override
  int size() =>
      modifyMultisigHeaderSize +
      ((keySize + 1 /* MultisigModificationType size */) *
          modifications.length);

  @override
  AbstractTransaction getAbstractTransaction() => getAbstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = cosignatoryModificationArrayToBuffer(builder, modifications);

    final vectors = generateVector(builder);

    final txnBuilder = ModifyMultisigAccountTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addMinRemovalDelta(minRemovalDelta)
      ..addMinApprovalDelta(minApprovalDelta)
      ..addNumModifications(modifications.length)
      ..addModificationsOffset(mV);
    buildVector(builder, vectors);

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
        super() {
    if (signedTx.transactionType != transactionTypeFromRaw(16961)._hex) {
      throw errEmptyModifications;
    } else {
      version = lockVersion;
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
        super.fromDto(value._transaction, value.meta) {
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
      '\t"abstractTransaction": ${abstractTransactionToString()}\n'
      '\t"mosaic": $mosaic,\n'
      '\t"duration": $duration,\n'
      '\t"signedTxHash": ${signedTransaction.hash},\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    data['mosaic'] = mosaic;
    data['duration'] = duration;
    data['signedTransaction'] = signedTransaction;

    return data;
  }

  @override
  int size() => lockSize;

  @override
  AbstractTransaction getAbstractTransaction() => getAbstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(mosaic.assetId.toArray());

    final maV = builder.writeListUint32(bigIntToArray(mosaic.amount));

    final dV = builder.writeListUint32(bigIntToArray(duration));

    final h = hex.decode(signedTransaction.hash);

    final hV = builder.writeListUint8(h);

    final vectors = generateVector(builder);

    final txnBuilder = LockFundsTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addDurationOffset(dV)
      ..addHashOffset(hV);
    buildVector(builder, vectors);

    final codedLockFunds = txnBuilder.finish();

    return lockFundsTransactionSchema()
        .serialize(builder.finish(codedLockFunds));
  }
}
