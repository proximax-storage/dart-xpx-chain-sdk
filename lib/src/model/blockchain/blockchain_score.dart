/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.blockchain;

class BlockchainScore {
  BlockchainScore.fromDTO(BlockchainScoreDTO dto) {
    score = Uint64.fromInts(dto.scoreLow!.toUint64()!.toInt(), dto.scoreHigh!.toUint64()!.toInt());
  }

  Uint64? score;

  @override
  String toString() => '$score';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score;
    return data;
  }
}
