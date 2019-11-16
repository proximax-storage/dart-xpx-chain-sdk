part of xpx_chain_sdk;

class BlockInfo {
  BlockInfo._fromDTO(_BlockInfoDTO v) {
    networkType = extractNetworkType(v._block._version);
    blockHash = v._meta._hash;
    generationHash = v._meta._generationHash;
    totalFee = v._meta._totalFee.toBigInt();
    numTransactions = v._meta._numTransactions;
    signature = v._block._signature;
    signer = PublicAccount.fromPublicKey(v._block._signer, networkType);
    version = v._block._version;
    type = v._block._type;
    height = v._block._height.toBigInt();
    timestamp = DateTime.fromMillisecondsSinceEpoch(
        v._block._timestamp.toBigInt().toInt() +
            _timestampNemesisBlock.toUtc().millisecondsSinceEpoch);
    difficulty = v._block._difficulty.toBigInt();
    feeMultiplier = v._block._feeMultiplier;
    previousBlockHash = v._block._previousBlockHash;
    blockTransactionsHash = v._block._blockTransactionsHash;
    blockReceiptsHash = v._block._blockReceiptsHash;
    stateHash = v._block._stateHash;
    beneficiary = v._block._beneficiaryPublicKey != null
        ? PublicAccount.fromPublicKey(
            v._block._beneficiaryPublicKey, networkType)
        : null;
    feeInterest = v._block._feeInterest;
    feeInterestDenominator = v._block._feeInterestDenominator;
  }

  int networkType;
  String blockHash;
  String generationHash;
  BigInt totalFee;
  int numTransactions;
  String signature;
  PublicAccount signer;
  int version;
  int type;
  BigInt height;
  DateTime timestamp;
  BigInt difficulty;
  int feeMultiplier;
  String previousBlockHash;
  String blockTransactionsHash;
  String blockReceiptsHash;
  String stateHash;
  PublicAccount beneficiary;
  int feeInterest;
  int feeInterestDenominator;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\tnetworkType: $networkType,')
      ..writeln('\tblockHash: $blockHash,')
      ..writeln('\tgenerationHash: $generationHash,')
      ..writeln('\ttotalFee: $totalFee,')
      ..writeln('\tnumTransactions: $numTransactions,')
      ..writeln('\tsignature: $signature,')
      ..writeln('\tsigner: $signer,')
      ..writeln('\tversion: $version,')
      ..writeln('\ttype: $type,')
      ..writeln('\theight: $height,')
      ..writeln('\ttimestamp: $timestamp,')
      ..writeln('\tdifficulty: $difficulty,')
      ..writeln('\tfeeMultiplier: $feeMultiplier,')
      ..writeln('\tpreviousBlockHash: $previousBlockHash,')
      ..writeln('\tblockTransactionsHash: $blockTransactionsHash,')
      ..writeln('\tblockReceiptsHash: $blockReceiptsHash,')
      ..writeln('\tstateHash: $stateHash,')
      ..writeln('\tbeneficiary: $beneficiary')
      ..writeln('\tfeeInterest: $feeInterest')
      ..writeln('\tfeeInterestDenominator: $feeInterestDenominator')
      ..write('}');
    return sb.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['networkType'] = networkType;
    data['hash'] = blockHash;
    data['generationHash'] = generationHash;
    data['totalFee'] = totalFee;
    data['numTransactions'] = numTransactions;
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['height'] = height;
    data['timestamp'] = timestamp;
    data['difficulty'] = difficulty;
    data['feeMultiplier'] = feeMultiplier;
    data['previousBlockHash'] = previousBlockHash;
    data['blockTransactionsHash'] = blockTransactionsHash;
    data['blockReceiptsHash'] = blockReceiptsHash;
    data['stateHash'] = stateHash;
    data['beneficiary'] = beneficiary.publicKey;
    data['feeInterest'] = feeInterest;
    data['beneficiary'] = feeInterestDenominator;
    return data;
  }

  static List<BlockInfo> listFromDTO(List<_BlockInfoDTO> json) => json == null
      ? null
      : json.map((value) => BlockInfo._fromDTO(value)).toList();
}

class Height {
  Height._fromDTO(_HeightDTO v) {
    height = v._height.toBigInt();
  }

  BigInt height;

  @override
  String toString() => '$height';

  Map<String, dynamic> toJson() {
    final dto = UInt64DTO.fromBigInt(height);
    final data = <String, dynamic>{};
    data['height'] = dto.toBigInt();
    return data;
  }
}

class BlockchainScore {
  BlockchainScore._fromDTO(_BlockchainScoreDTO value)
      : assert(json != null, 'json must not be null') {
    List<dynamic> raw() => <dynamic>[
          value._scoreLow.toBigInt().toInt(),
          value._scoreHigh.toBigInt().toInt()
        ];

    final t = UInt64DTO.fromJson(raw()).toBigInt();
    score = t;
  }

  BigInt score;

  @override
  String toString() => '$score';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score;
    return data;
  }
}

class BlockchainStorageInfo {
  BlockchainStorageInfo.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    numBlocks = json['numBlocks'];
    numTransactions = json['numTransactions'];
    numAccounts = json['numAccounts'];
  }

  int numBlocks;

  int numTransactions;

  int numAccounts;

  @override
  String toString() => '{numBlocks:$numBlocks,'
      ' numTransactions:$numTransactions,'
      ' numAccounts:$numAccounts}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numBlocks'] = numBlocks;
    data['numTransactions'] = numTransactions;
    data['numAccounts'] = numAccounts;

    return data;
  }
}
