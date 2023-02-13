/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const nodes = [
    'https://api-1.testnet2.xpxsirius.io',
    'https://api-2.testnet2.xpxsirius.io',
    'https://api-3.testnet2.xpxsirius.io'
  ];

  /// Creating a client balanceList
  final client = SiriusClient.balanceList(nodes);

  for (var i = 0; i < client.nodesLength; i++) {
    try {
      final result = await client.node.getNodeInfo();
      print(result);
    } on Exception catch (e) {
      print('Exception when calling Node->GetNodeInfo: $e\n');
    }
  }

  try {
    final result = await client.node.getNodeTime();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Node->GetNodeTime: $e\n');
  }

  try {
    final result = await client.node.getNodePeers();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Node->GetNodePeers: $e\n');
  }
}
