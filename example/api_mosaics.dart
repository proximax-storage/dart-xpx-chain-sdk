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

  final mosaicIdOne = MosaicId.fromHex('13BFC518E40549D7');
  final mosaicIdTwo = MosaicId.fromHex('705BAFA9B6903C08');

  // Gets a [MosaicInfo] definition for a given mosaicId.
  try {
    final result = await client.mosaic.getMosaic(mosaicIdOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Mosaic->GetMosaic: $e\n');
  }

  // Gets an List of [MosaicInfo].
  try {
    final result = await client.mosaic.getMosaics([mosaicIdOne, mosaicIdTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Mosaic->GetMosaics: $e\n');
  }

  // Returns a [MosaicName] friendly names for mosaics.
  try {
    final result = await client.mosaic.getMosaicsName([mosaicIdOne, mosaicIdTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Mosaic->GetMosaicsName: $e\n');
  }

  // Retrieve owners of a given mosaic sorted on descending order based on amount.
  try {
    final result = await client.mosaic.getMosaicRichList(mosaicIdOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Mosaic->GetMosaicRichList: $e\n');
  }

  // Get mosaic levy information for a mosaic.
  try {
    final result = await client.mosaic.getMosaicLevy(mosaicIdOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Mosaic->GetMosaicLevy: $e\n');
  }
}
