/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.mosaic.mosaic_id_test;

import 'dart:typed_data' show Uint8List;

import 'package:test/test.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart' show MosaicId, MosaicNonce, NetworkType, PublicAccount, Uint64;

void main() {
  const testPublicKey = 'b4f12e7c9f6946091e2cb8b6d3a12b50d17ccbbf646386ea27ce2946a7423dcf';
  const testHex = '85BBEA6CC462B244'; // 15358872602548358953
  const testInts = [3294802500, 2243684972];
  final testId = Uint64.fromHex(testHex);

  group('Create MosaicId via constructor', () {
    test('Can create using Uint64 id', () {
      final mosaicId = MosaicId(testId);

      expect(mosaicId.value, equals(testId));
      expect(mosaicId.value.toHex().toUpperCase(), equals(testHex));
      expect(mosaicId.hashCode, isNotNull);
    });

    test('Should have equal Ids', () {
      final mosaicId1 = MosaicId(testId);
      final mosaicId2 = MosaicId(testId);

      expect(mosaicId1, equals(mosaicId2));
      expect(mosaicId1.value, equals(mosaicId2.value));
    });
  });

  group('Create MosaicId via static methods', () {
    test('fromId()', () {
      final mosaicId = MosaicId(testId);

      expect(mosaicId.value, equals(testId));
      expect(mosaicId.value.toHex().toUpperCase(), equals(testHex));
    });

    test('fromBigInt()', () {
      final mosaicId = MosaicId.fromBigInt(testId.toBigInt());

      expect(mosaicId.value, equals(testId));
      expect(mosaicId.value.toHex().toUpperCase(), equals(testHex));
    });

    test('fromHex()', () {
      final mosaicId = MosaicId.fromHex(testHex);

      expect(mosaicId.value, equals(testId));
      expect(mosaicId.value.toHex().toUpperCase(), equals(testHex));
    });

    test('fromNonce()', () {
      final bytes = Uint8List.fromList([0x0, 0x0, 0x0, 0x0]);
      final nonce = MosaicNonce(bytes);
      final owner = PublicAccount.fromPublicKey(testPublicKey, NetworkType.PRIVATE_TEST);
      final mosaicId = MosaicId.fromNonceAndOwner(nonce, owner);

      final expected = Uint64.fromHex('8dc67fbe1cad29e3');

      expect(mosaicId.value, equals(expected));
      expect(mosaicId.value.toHex(), equals(expected.toHex()));
    });

    test('fromInts()', () {
      final mosaicId = MosaicId.fromInts(testInts[0], testInts[1]);

      expect(mosaicId.value, equals(testId));
      expect(mosaicId.value.toHex().toUpperCase(), equals(testHex));
      expect(mosaicId.value.toIntArray()[0], equals(testInts[0]));
      expect(mosaicId.value.toIntArray()[1], equals(testInts[1]));
    });
  });

  group('Cannot create with invalid inputs', () {
    test('Invalid constructor parameter', () {
      expect(
          () => MosaicId.fromHex(''),
          throwsA(predicate(
              (e) => e is ArgumentError && e.message.toString().contains('The hexString must not be null or empty'))));
      expect(() => MosaicId.fromHex('12zz34'),
          throwsA(predicate((e) => e is ArgumentError && e.message.toString().contains('Invalid hex'))));
    });
  });
}
