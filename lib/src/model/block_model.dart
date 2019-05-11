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

  BlockInfo.fromDTO(_BlockInfoDTO v) {
    NetworkType = ExtractNetworkType(v.block.version);
    Hash = v.meta.hash;
    GenerationHash = v.meta.generationHash;
    TotalFee = v.meta.totalFee.toBigInt();
    NumTransactions = v.meta.numTransactions;
    Signature = v.block.signature;
    Signer = NewAccountFromPublicKey(v.block.signer, NetworkType);
    Version = v.block.version;
    Type = v.block.type;
    Height = v.block.height.toBigInt();
    Timestamp = v.block.timestamp.toBigInt();
    Difficulty = v.block.difficulty.toBigInt();
    PreviousBlockHash = v.block.previousBlockHash;
    BlockTransactionsHash = v.block.blockTransactionsHash;
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
