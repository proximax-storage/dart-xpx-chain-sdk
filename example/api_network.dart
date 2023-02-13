/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'https://api-2.testnet2.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  // Returns the current network type.
  try {
    final result = await client.network.getNetworkType();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Network->getNetworkType: $e\n');
  }
}
