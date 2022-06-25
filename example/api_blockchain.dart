/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'http://bctestnet3.brimstone.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  // Returns the current height of the blockchain.
  try {
    final result = await client.blockChain.getBlockchainHeight();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling BlockChain->GetBlockchainHeight: $e\n');
  }

  // Gets a [BlockInfo] from the chain that has the given height.
  try {
    final result = await client.blockChain.getBlockByHeight(4993924.toHeight);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling BlockChain->GetBlockByHeight: $e\n');
  }

  // Get the current score of the chain.
  try {
    final result = await client.blockChain.getBlockchainScore();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling BlockChain->GetBlockchainScore: $e\n');
  }

  // Gets up to limit number of blocks after given block height.
  try {
    final result = await client.blockChain.getBlocksByHeightWithLimit(1, 25);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling BlockChain->GetBlocksByHeightWithLimit: $e\n');
  }

  // Returns an List of [Transaction] included in a block for a given block height.
  try {
    final result = await client.blockChain.getBlockTransactions(4993924.toHeight);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling BlockChain->getBlockTransactions: $e\n');
  }
}
