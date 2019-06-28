part of xpx_chain_sdk;

class BlockInfo {
  BlockInfo.fromDTO(_BlockInfoDTO v) {
    networkType = extractNetworkType(v._block._version);
    hash = v._meta._hash;
    generationHash = v._meta._generationHash;
    totalFee = v._meta._totalFee.toBigInt();
    numTransactions = v._meta._numTransactions;
    signature = v._block._signature;
    signer = PublicAccount.fromPublicKey(v._block._signer, networkType);
    version = v._block._version;
    type = v._block._type;
    height = v._block._height.toBigInt();
    timestamp = v._block._timestamp.toBigInt();
    difficulty = v._block._difficulty.toBigInt();
    previousBlockHash = v._block._previousBlockHash;
    blockTransactionsHash = v._block._blockTransactionsHash;
  }

  int networkType;
  String hash;
  String generationHash;
  BigInt totalFee;
  int numTransactions;
  String signature;
  PublicAccount signer;
  int version;
  int type;
  BigInt height;
  BigInt timestamp;
  BigInt difficulty;
  String previousBlockHash;
  String blockTransactionsHash;

  @override
  String toString() => '{\n'
      '\tnetworkType: $networkType,\n'
      '\thash: $hash,\n'
      '\tgenerationHash: $generationHash,\n'
      '\ttotalFee: $totalFee,\n'
      '\tnumTransactions: $numTransactions,\n'
      '\tsignature: $signature,\n'
      '\tsigner: $signer\n'
      '\tversion: $version,\n'
      '\ttype: $type,\n'
      '\theight: $height,\n'
      '\ttimestamp: $timestamp,\n'
      '\tdifficulty: $difficulty,\n'
      '\tpreviousBlockHash: $previousBlockHash,\n'
      '\tblockTransactionsHash: $blockTransactionsHash,\n'
      '}\n';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['networkType'] = networkType;
    data['hash'] = hash;
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
    data['previousBlockHash'] = previousBlockHash;
    data['blockTransactionsHash'] = blockTransactionsHash;

    return data;
  }

  static List<BlockInfo> listFromDTO(List<_BlockInfoDTO> json) => json == null
      ? null
      : json.map((value) => BlockInfo.fromDTO(value)).toList();
}

class Height {
  Height.fromDTO(_HeightDTO v) {
    height = v._height.toBigInt();
  }

  BigInt height;

  @override
  String toString() => '{height: $height}';

  Map<String, dynamic> toDto() {
    final dto = UInt64DTO.fromBigInt(height);
    final data = <String, dynamic>{};
    data['height'] = dto;
    return data;
  }
}

class BlockchainScore {
  BlockchainScore.fromDTO(_BlockchainScoreDTO value)
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
