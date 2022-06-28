/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.mosaic.mosaic_info_test;

import 'package:test/test.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart' show MosaicId, MosaicInfo, MosaicProperties, Uint64;

void main() {
  group('Create MosaicInfo via constructor', () {
    const publicKey = 'b4f12e7c9f6946091e2cb8b6d3a12b50d17ccbbf646386ea27ce2946a7423dcf';
    const xpxHexString = 'BFFB42A19116BDF6'; // 15358872602548358953
    final xpxId = Uint64.fromHex(xpxHexString);

    test('Can create via constructor', () {
      // Mosaic info parameters and properties
      final mosaicId = MosaicId(xpxId);
      final supply = Uint64(9999999999);
      final height = Uint64(1);
      const owner = publicKey;
      const int divisibility = 3;
      final properties = MosaicProperties.create(supplyMutable: true, transferable: true, divisibility: divisibility);
      const int revision = 1;

      // Create MosaicInfo
      final MosaicInfo mosaicInfo = MosaicInfo(mosaicId, owner, revision, properties, supply: supply, height: height);

      // Assert
      expect(mosaicInfo.mosaicId, equals(mosaicId));
      expect(mosaicInfo.supply?.toInt(), 9999999999);
      expect(mosaicInfo.height?.toInt(), 1);
      expect(mosaicInfo.owner, equals(publicKey));
      expect(mosaicInfo.revision, revision);
      expect(mosaicInfo.isSupplyMutable, isTrue);
      expect(mosaicInfo.isTransferable, isTrue);
      expect(mosaicInfo.divisibility, divisibility);
    });
  });
}
