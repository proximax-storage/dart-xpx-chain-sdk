/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.namespace.asset_id_test;

import 'package:test/test.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart' show AssetId, MosaicId, NamespaceId, Uint64;

void main() {
  group('AssetId', () {
    test('Can create an AssetId object', () {
      final AssetId id = MockId(Uint64(9000));

      final expected = Uint64.fromBigInt(BigInt.from(9000));
      expect(id == MockId(expected), isTrue);
      expect(id.value, equals(expected));
      expect(id.value, equals(expected));
      expect(id.toHex(), equals(expected.toHex()));
    });

    test('Different implementation of AssetIds are not equals', () {
      final uint64 = Uint64.tryParse('12785006848024490942');
      final AssetId mockId = MockId(uint64!);
      final AssetId mosaicId = MosaicId(uint64);
      final AssetId namespaceId = NamespaceId(uint64);

      expect(mockId == mosaicId, isFalse);
      expect(mockId == namespaceId, isFalse);
      expect(mosaicId == namespaceId, isFalse);
    });

    test('Instances of the same implementation are only equal if the AssetIds are the same', () {
      final uint64 = Uint64(9000);
      final AssetId mockId1 = MockId(uint64);
      final AssetId mockId2 = MockId(uint64);
      final AssetId mockId3 = MockId(Uint64(1000)); // has a different uint64 value

      expect(mockId1 == mockId2, isTrue);
      expect(mockId1 == mockId3, isFalse);
      expect(mockId2 == mockId3, isFalse);
    });
  });
}

class MockId extends AssetId {
  MockId(Uint64 id) : super(id);
}
