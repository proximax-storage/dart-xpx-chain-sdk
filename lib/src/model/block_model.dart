part of xpx_catapult_sdk;

class BlockInfo {
  int NetworkType;
  String Hash;
  String GenerationHash;
  BigInt TotalFee;
  int NumTransactions;
  String Signature;
  PublicAccount Signer;
  int Version;
  int Type;
  BigInt Height;
  BigInt Timestamp;
  BigInt Difficulty;
  String PreviousBlockHash;
  String BlockTransactionsHash;

  BlockInfo();

  @override
  String toString() {
    return '{\n'
        '\tNetworkType: $NetworkType,\n'
        '\tHash: $Hash,\n'
        '\tGenerationHash: $GenerationHash,\n'
        '\tTotalFee: $TotalFee,\n'
        '\tNumTransactions: $NumTransactions,\n'
        '\tSignature: $Signature,\n'
        '\tSigner: $Signer'
        '\tVersion: $Version,\n'
        '\tType: $Type,\n'
        '\tHeight: $Height,\n'
        '\tTimestamp: $Timestamp,\n'
        '\tDifficulty: $Difficulty,\n'
        '\tPreviousBlockHash: $PreviousBlockHash,\n'
        '\tBlockTransactionsHash: $BlockTransactionsHash,\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    return {
      'networkType': NetworkType,
      'hash': Hash,
      'generationHash': GenerationHash,
      'totalFee': TotalFee,
      'NumTransactions': NumTransactions,
      'signature': Signature,
      'signer': Signer,
      'version': Version,
      'type': Type,
      'height': Height,
      'timestamp': Timestamp,
      'difficulty': Difficulty,
      'previousBlockHash': PreviousBlockHash,
      'blockTransactionsHash': BlockTransactionsHash,
    };
  }

  BlockInfo.fromDTO(_blockInfoDTO v) {
    NetworkType = ExtractNetworkType(v.block.version);
    Hash = v.meta.hash;
    GenerationHash = v.meta.generationHash;
    TotalFee = v.meta.totalFee.toBigInt();
    NumTransactions = v.meta.numTransactions;
    Signature = v.block.signature;
    Signer = new PublicAccount.fromPublicKey(v.block.signer, NetworkType);
    Version = v.block.version;
    Type = v.block.type;
    Height = v.block.height.toBigInt();
    Timestamp = v.block.timestamp.toBigInt();
    Difficulty = v.block.difficulty.toBigInt();
    PreviousBlockHash = v.block.previousBlockHash;
    BlockTransactionsHash = v.block.blockTransactionsHash;
  }

  static List<BlockInfo> listFromDTO(List<_blockInfoDTO> json) {
    return json == null
        ? new List<BlockInfo>()
        : json.map((value) => new BlockInfo.fromDTO(value)).toList();
  }
}

class Height {
  BigInt _height = null;

  Height();

  @override
  String toString() {
    return 'Height[height = ${_height}]';
  }

  Height.fromDTO(_HeightDTO v) {
    _height = v.height.toBigInt();
  }

  Map<String, dynamic> toRaw() {
    var d = new UInt64DTO.fromBigInt(this._height);
    return {'height': d};
  }

  BigInt toBigInt() {
    return this._height;
  }
}

class BlockchainScore {
  BigInt _score = null;

  BlockchainScore();

  @override
  String toString() {
    return '$_score';
  }

  BlockchainScore.fromDTO(_blockchainScoreDTO value) {
    if (json == null) return;
    List<dynamic> raw() {
      return [
        value.scoreLow.toBigInt().toInt(),
        value.scoreHigh.toBigInt().toInt()
      ];
    }

    var t = UInt64DTO.fromJson(raw()).toBigInt();
    _score = t;
  }
}

class BlockchainStorageInfo {
  int numBlocks;

  int numTransactions;

  int numAccounts;

  BlockchainStorageInfo();

  @override
  String toString() {
    return '{numBlocks:$numBlocks, numTransactions:$numTransactions, numAccounts:$numAccounts}';
  }

  BlockchainStorageInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    numBlocks = json['numBlocks'];
    numTransactions = json['numTransactions'];
    numAccounts = json['numAccounts'];
  }

  Map<String, dynamic> toJson() {
    return {
      'numBlocks': numBlocks,
      'numTransactions': numTransactions,
      'numAccounts': numAccounts
    };
  }
}
