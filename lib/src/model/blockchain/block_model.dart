part of xpx_chain_sdk.blockchain;

class BlockInfo {
  BlockInfo.fromDTO(BlockInfoDTO v) {
    networkType = extractNetworkType(v._block.version);
    blockHash = v.meta._hash;
    generationHash = v.meta._generationHash;
    totalFee = v.meta._totalFee.toUint64();
    numTransactions = v.meta._numTransactions;
    signature = v._block.signature;
    signer = PublicAccount.fromPublicKey(v._block.signer, networkType);
    version = v._block.version;
    type = v._block.type;
    height = v._block._height.toUint64();
    timestamp = DateTime.fromMillisecondsSinceEpoch(
        v._block._timestamp.toUint64().toInt() + timestampNemesisBlock.toUtc().millisecondsSinceEpoch);
    difficulty = v._block._difficulty.toUint64();
    feeMultiplier = v._block.feeMultiplier;
    previousBlockHash = v._block._previousBlockHash;
    blockTransactionsHash = v._block._blockTransactionsHash;
    blockReceiptsHash = v._block._blockReceiptsHash;
    stateHash = v._block._stateHash;
    beneficiary = v._block._beneficiaryPublicKey != null
        ? PublicAccount.fromPublicKey(v._block._beneficiaryPublicKey, networkType)
        : null;
    feeInterest = v._block.feeInterest;
    feeInterestDenominator = v._block.feeInterestDenominator;
  }

  int networkType;
  String blockHash;
  String generationHash;
  Uint64 totalFee;
  int numTransactions;
  String signature;
  PublicAccount signer;
  int version;
  int type;
  Uint64 height;
  DateTime timestamp;
  Uint64 difficulty;
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

  static List<BlockInfo> listFromDTO(List<BlockInfoDTO> json) =>
      json == null ? null : json.map((value) => BlockInfo.fromDTO(value)).toList();
}

class Height {
  Height.fromDTO(HeightDTO v) {
    height = v._height.toUint64();
  }

  Uint64 height;

  @override
  String toString() => '$height';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    return data;
  }
}

class BlockchainScore {
  BlockchainScore.fromDTO(BlockchainScoreDTO dto) : assert(dto != null, 'dto must not be null') {
    score = Uint64.fromInts(dto._scoreLow.toUint64().toInt(), dto._scoreHigh.toUint64().toInt());
  }

  Uint64 score;

  @override
  String toString() => '$score';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score;
    return data;
  }
}

class BlockchainStorageInfo {
  BlockchainStorageInfo.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
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
