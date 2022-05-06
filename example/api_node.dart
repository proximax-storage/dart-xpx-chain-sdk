/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_sdk.dart';

void main() async {
  const baseUrl = 'http://bctestnet3.brimstone.xpxsirius.io:3000';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  try {
    final result = await client.node.getNodeInfo();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Node->GetNodeInfo: $e\n');
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
