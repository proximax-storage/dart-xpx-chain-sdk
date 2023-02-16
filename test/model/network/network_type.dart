/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.network.network_type_test;

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

/// These tests cover basic functionality of the class,
/// such as creating a NetworkType from its integer value or name,
/// checking its validity, and serializing it to JSON.
void main() {
  group('NetworkType', () {
    test('can be created from int', () {
      expect(NetworkType.fromInt(0x60), equals(NetworkType.MIJIN));
      expect(NetworkType.fromInt(0x90), equals(NetworkType.MIJIN_TEST));
      expect(NetworkType.fromInt(0xb8), equals(NetworkType.PUBLIC));
      expect(NetworkType.fromInt(0xa8), equals(NetworkType.PUBLIC_TEST));
      expect(NetworkType.fromInt(0xc8), equals(NetworkType.PRIVATE));
      expect(NetworkType.fromInt(0xb0), equals(NetworkType.PRIVATE_TEST));
      expect(() => NetworkType.fromInt(123), throwsArgumentError);
    });

    test('can be created from name', () {
      expect(NetworkType.fromName('mijin'), equals(NetworkType.MIJIN));
      expect(NetworkType.fromName('mijinTest'), equals(NetworkType.MIJIN_TEST));
      expect(NetworkType.fromName('public'), equals(NetworkType.PUBLIC));
      expect(NetworkType.fromName('publicTest'), equals(NetworkType.PUBLIC_TEST));
      expect(NetworkType.fromName('private'), equals(NetworkType.PRIVATE));
      expect(NetworkType.fromName('privateTest'), equals(NetworkType.PRIVATE_TEST));
      expect(NetworkType.fromName('invalid'), equals(NetworkType.UNKNOWN_NETWORK_TYPE));
    });

    test('can be checked for validity', () {
      expect(NetworkType.isValid(NetworkType.MIJIN), isTrue);
      expect(NetworkType.isValid(NetworkType.MIJIN_TEST), isTrue);
      expect(NetworkType.isValid(NetworkType.PUBLIC), isTrue);
      expect(NetworkType.isValid(NetworkType.PUBLIC_TEST), isTrue);
      expect(NetworkType.isValid(NetworkType.PRIVATE), isTrue);
      expect(NetworkType.isValid(NetworkType.PRIVATE_TEST), isTrue);
      expect(NetworkType.isValidValue(0x60), isTrue);
      expect(NetworkType.isValidValue(123), isFalse);
      expect(NetworkType.isValidValue(123, throwError: true), throwsArgumentError);
    });

    test('can be serialized to JSON', () {
      expect(
          NetworkType.MIJIN.toJson(),
          equals({
            'networkIdentifier': 96,
            'name': 'Mijin',
          }));
    });
  });
}
