/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.blockchain;

class BlockInfo {
  BlockInfo.fromDTO(BlockInfoDTO v) {
    networkType =
        NetworkType.fromInt(extractNetworkType(v.block!.version!.toInt()));
    blockHash = v.meta!.hash;
    generationHash = v.meta!.generationHash;
    totalFee = v.meta!.totalFee!.toUint64();
    numTransactions = v.meta!.numTransactions as int?;
    signature = v.block!.signature;
    signer = PublicAccount.fromPublicKey(v.block!.signer, networkType!);
    version = v.block!.version as int?;
    type = v.block!.type as int?;
    height = v.block!.height!.toUint64();
    timestamp = DateTime.fromMillisecondsSinceEpoch(
        v.block!.timestamp!.toUint64()!.toInt() +
            timestampNemesisBlock.toUtc().millisecondsSinceEpoch);
    difficulty = v.block!.difficulty!.toUint64();
    feeMultiplier = v.block!.feeMultiplier;
    previousBlockHash = v.block!.previousBlockHash;
    blockTransactionsHash = v.block!.blockTransactionsHash;
    blockReceiptsHash = v.block!.blockReceiptsHash;
    stateHash = v.block!.stateHash;
    beneficiary = v.block!.beneficiaryPublicKey != null
        ? PublicAccount.fromPublicKey(
            v.block!.beneficiaryPublicKey, networkType!)
        : null;
    feeInterest = v.block!.feeInterest;
    feeInterestDenominator = v.block!.feeInterestDenominator;
  }

  NetworkType? networkType;
  String? blockHash;
  String? generationHash;
  Uint64? totalFee;
  int? numTransactions;
  String? signature;
  PublicAccount? signer;
  int? version;
  int? type;
  Uint64? height;
  DateTime? timestamp;
  Uint64? difficulty;
  int? feeMultiplier;
  String? previousBlockHash;
  String? blockTransactionsHash;
  String? blockReceiptsHash;
  String? stateHash;
  PublicAccount? beneficiary;
  int? feeInterest;
  int? feeInterestDenominator;

  @override
  String toString() => encoder.convert(this);

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
    data['timestamp'] = timestamp?.toIso8601String();
    data['difficulty'] = difficulty;
    data['feeMultiplier'] = feeMultiplier;
    data['previousBlockHash'] = previousBlockHash;
    data['blockTransactionsHash'] = blockTransactionsHash;
    data['blockReceiptsHash'] = blockReceiptsHash;
    data['stateHash'] = stateHash;
    data['beneficiary'] = beneficiary;
    data['feeInterest'] = feeInterest;
    data['beneficiary'] = feeInterestDenominator;
    return data;
  }

  static List<BlockInfo>? listFromDTO(List<BlockInfoDTO>? json) =>
      json!.isEmpty ? [] : json.map(BlockInfo.fromDTO).toList();
}
