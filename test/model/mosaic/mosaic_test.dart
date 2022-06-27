/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.mosaic.mosaic_test;

import 'package:test/test.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart' show Mosaic, MosaicId, Uint64;

void main() {
  group('Mosaic', () {
    test('Can create mosaic object', () {
      const xpxHexString = 'BFFB42A19116BDF6';
      final mosaicId = MosaicId.fromHex(xpxHexString);
      final amount = Uint64(9999999999);
      final Mosaic mosaic = Mosaic(mosaicId, amount);

      expect(mosaic.assetId, equals(mosaicId));
      expect(mosaic.amount, equals(amount));
      expect(mosaic.amount.toInt(), equals(9999999999));

      print(mosaic);
      expect(mosaic.toString(), equals('{\n  "id": $mosaicId,\n  "amount": $amount\n}'));
    });
  });
}
