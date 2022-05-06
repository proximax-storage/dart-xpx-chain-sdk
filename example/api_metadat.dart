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
    final result = await client.metadata.getMetadataV2Info(
        '57D649B3FDC7CEE27A621F710492BB01DD8BA812B93B03B6B80044AABC313DB4');
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Metadata->GetMetadataV2Info: $e\n');
  }

  try {
    final result = await client.metadata.getMetadatasV2Info([
      '57D649B3FDC7CEE27A621F710492BB01DD8BA812B93B03B6B80044AABC313DB4',
      '544F408D38BB884193241E32EE19D9870D332B1C38FBDFA9DF9BC7650F02FD38'
    ]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Metadata->GetMetadatasV2Info: $e\n');
  }

  // final queryParams = MetadataQueryParams()..targetId = MosaicId.fromHex('1EFEA8C391FB9C48');

  try {
    final result = await client.metadata.searchMetadata();
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Metadata->SearchMetadata: $e\n');
  }
}
