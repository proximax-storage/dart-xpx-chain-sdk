part of nem2_sdk_dart;

class Block {
  String Hash;
  String GenerationHash;
  BigInt TotalFee;
  BigInt NumTransactions;
  String Signature;
  PublicAccount Signer;
  UInt64DTO Version;
  UInt64DTO Type;
  BigInt Height;
  BigInt Timestamp;
  BigInt Difficulty;
  String PreviousBlockHash;
  String BlockTransactionsHash;

  Block();

  @override
  String toString() {
    return 'BlockInfo['
        'signature=$Signature,'
        ' signer=$Signer,'
        ' version=$Version,'
        ' type=$Type,'
        ' height=$Height,'
        ' timestamp=$Timestamp,'
        ' difficulty=$Difficulty,'
        ' feeMultiplier=$TotalFee,'
        ' previousBlockHash=$PreviousBlockHash,'
        ' blockTransactionsHash=$BlockTransactionsHash,'
        ' Hash=$Hash,'
        ' PublicAccount=$PublicAccount,'
        ' ]';
  }

  Map<String, dynamic> toJson() {
    return {
      'signature': Signature,
      'signer': Signer,
      'version': Version,
      'type': Type,
      'height': Height,
      'timestamp': Timestamp,
      'difficulty': Difficulty,
      'feeMultiplier': TotalFee,
      'previousBlockHash': PreviousBlockHash,
      'blockTransactionsHash': BlockTransactionsHash,
      'hash': Hash,
      'publicAccount': PublicAccount
    };
  }
}

class Height {
  BigInt _height = null;

  Height();

  @override
  String toString() {
    return 'Height[height = ${_height}]';
  }

  Height.fromDTO(HeightDTO v) {
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
