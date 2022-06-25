/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.namespace.namespace_id_test;

import 'package:test/test.dart';

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart' show NamespaceId, Uint64;

void main() {
  const xpxHexString = 'A2045D74612E5194'; // 11674558888479183252
  final xpxId = Uint64.fromHex(xpxHexString);
  const subXpxHexString = 'E5A8EA26D80FB890'; // 16548734283327453328
  final subXpxId = Uint64.fromHex(subXpxHexString);

  group('Create NamespaceId via constructor', () {
    test('Can create using Uint64 id', () {
      final NamespaceId namespaceId = NamespaceId(xpxId);

      expect(namespaceId.value, equals(xpxId));
      expect(namespaceId.value.toHexString().toUpperCase(), equals(xpxHexString));
      expect(namespaceId.hashCode, isNotNull);
    });

    test('Can create using a full name string', () {
      final NamespaceId namespaceId = NamespaceId.fromName('xpx.subxpx');

      expect(namespaceId.value, equals(subXpxId));
      expect(namespaceId.value.toHexString().toUpperCase(), equals(subXpxHexString));
    });

    test('Should have equal Ids', () {
      final NamespaceId namespaceId1 = NamespaceId(xpxId);
      final NamespaceId namespaceId2 = NamespaceId(xpxId);
      final NamespaceId namespaceId3 = NamespaceId.fromName('xpx');

      expect(namespaceId1, equals(namespaceId2));
      expect(namespaceId1.value, equals(namespaceId2.value));
      expect(namespaceId1.value, equals(namespaceId3.value));
      expect(namespaceId2.value, equals(namespaceId3.value));
    });
  });

  group('Test vectors', () {
    const vectors = {
      [
        'A2045D74612E5194',
        [1630425492, 2718195060]
      ], // NamespaceId('xpx')
      [
        'E45BE7662D0BD9CC',
        [755751372, 3831228262]
      ], // NamespaceId('xpx.owner.test1')
      [
        '8B959A9EE07D73D6',
        [3766318038, 2341837470]
      ], // NamespaceId('xpx.owner.test2')
      [
        '8E89F8D7CD44547A',
        [3443807354, 2391406807]
      ], // NamespaceId('xpx.owner.test3')
      [
        'A0F89F39CEC75092',
        [3469168786, 2700648249]
      ], // NamespaceId('xpx.owner.test4')
      [
        '8AF58BE060ADB17D',
        [1621995901, 2331347936]
      ], // NamespaceId('xpx.owner.test5')
    };

    test('Should pass test using test vectors', () {
      for (var value in vectors) {
        final NamespaceId fromHex = NamespaceId.fromHex(value[0] as String);
        final List<int> intArray = value[1] as List<int>;
        final NamespaceId fromId = NamespaceId.fromInts(intArray[0], intArray[1]);
        expect(fromHex.value, equals(fromId.value));
      }
    });
  });

  group('Cannot create with invalid inputs', () {
    test('Invalid constructor parameter', () {
      expect(() => NamespaceId.fromName(''),
          throwsA(predicate((e) => e is ArgumentError && e.message == 'Either fullName is required')));
      expect(() => NamespaceId.fromHex(''),
          throwsA(predicate((e) => e is ArgumentError && e.message == 'The hexString must not be null or empty')));
      expect(() => NamespaceId.fromHex('12zz34'),
          throwsA(predicate((e) => e is ArgumentError && e.message == 'Invalid hex')));
    });
  });
}
