/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class BlockDTO {
  BlockDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    height = UInt64DTO.fromJson(json['height']);
    timestamp = UInt64DTO.fromJson(json['timestamp']);
    difficulty = UInt64DTO.fromJson(json['difficulty']);
    feeMultiplier = json['feeMultiplier'];
    previousBlockHash = json['previousBlockHash'];
    blockTransactionsHash = json['blockTransactionsHash'];
    blockReceiptsHash = json['blockReceiptsHash'];
    stateHash = json['stateHash'];
    beneficiaryPublicKey = json['beneficiary'] !=
            '0000000000000000000000000000000000000000000000000000000000000000'
        ? json['beneficiary']
        : null;
    feeInterest = json['feeInterest'];
    feeInterestDenominator = json['feeInterestDenominator'];
  }

  String? signature;

  String? signer;

  num? version;

  num? type;

  UInt64DTO? height;

  UInt64DTO? timestamp;

  UInt64DTO? difficulty;

  int? feeMultiplier;

  int? feeInterest;

  int? feeInterestDenominator;

  String? previousBlockHash;

  String? blockTransactionsHash;

  String? blockReceiptsHash;

  String? stateHash;

  String? beneficiaryPublicKey;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['height'] = height;
    data['timestamp'] = timestamp;
    data['difficulty'] = difficulty;
    data['feeMultiplier'] = feeMultiplier;
    data['feeMultiplier'] = feeMultiplier;
    data['blockTransactionsHash'] = blockTransactionsHash;
    data['blockReceiptsHash'] = blockReceiptsHash;
    data['stateHash'] = stateHash;
    data['beneficiary'] = beneficiaryPublicKey;

    return data;
  }
}

class BlockInfoDTO {
  BlockInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    meta = BlockMetaDTO.fromJson(json['meta']);
    block = BlockDTO.fromJson(json['block']);
  }

  BlockMetaDTO? meta;

  BlockDTO? block;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['block'] = block;

    return data;
  }
}

class BlockMetaDTO {
  BlockMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    hash = json['hash'];
    generationHash = json['generationHash'];
    totalFee = UInt64DTO.fromJson(json['totalFee']);
    numTransactions = json['numTransactions'];
  }

  String? hash;

  String? generationHash;

  UInt64DTO? totalFee;

  num? numTransactions;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hash'] = hash;
    data['generationHash'] = generationHash;
    data['totalFee'] = totalFee;
    data['numTransactions'] = numTransactions;

    return data;
  }
}

class BlockchainScoreDTO {
  BlockchainScoreDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    scoreHigh = UInt64DTO.fromJson(json['scoreHigh']);
    scoreLow = UInt64DTO.fromJson(json['scoreLow']);
  }

  UInt64DTO? scoreHigh;

  UInt64DTO? scoreLow;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['scoreHigh'] = scoreHigh;
    data['scoreLow'] = scoreLow;

    return data;
  }
}
