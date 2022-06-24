/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.test.model.transaction.transaction_test;

import 'package:test/test.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart'
    show Account, AccountMetadataTransaction, ByteUtils, Deadline, MosaicId, MosaicMetadataTransaction, NamespaceId, NamespaceMetadataTransaction, NetworkType, Uint64;

import '../../conf/conf.dart';

void main() {
  group('Transaction', () {
    late Account testingAccount;
    const generationHash = '56D112C98F7A7E34D1AEDC4BD01BC06CA2276DD546A93E36690B785E82439CA9';

    setUp(() async {
      testingAccount = await TestingAccount;
    });

    group('MetadataTransaction', () {
      group('size', () {
        test('should return 181 for MosaicMetadataTransaction byte size with newValue=testing oldValue=test', () async {
          final mosaicId = MosaicId.fromInts(2262289484, 3405110546);
          final modifyMetadataTransaction = MosaicMetadataTransaction.create(Deadline(hours: 1), mosaicId,
              testingAccount.publicAccount, 'name', 'testing', 'test', NetworkType.MIJIN_TEST, Uint64.zero);
          final signedTransaction = await testingAccount.signTransaction(modifyMetadataTransaction, generationHash);

          expect(modifyMetadataTransaction.size(), 181);
          expect(signedTransaction.payload.length, 181 * 2);
          expect(signedTransaction.payload.substring(244, signedTransaction.payload.length,).toLowerCase(),
              (testingAccount.publicKey + '859CBD19B98E068F' + ByteUtils.bytesToHex(mosaicId.toBytes()) + '0300070000000000696E67').toLowerCase());
        });

        test('should return 181 for namespace MetadataTransaction byte size with newValue=test, oldValue=testing', () async {
          final namespaceId = NamespaceId.fromInts(2262289484, 3405110546);
          final modifyMetadataTransaction = NamespaceMetadataTransaction.create(Deadline(hours: 1), namespaceId,
              testingAccount.publicAccount, 'name', 'test', 'testing', NetworkType.MIJIN_TEST, Uint64.zero);
          final signedTransaction = await testingAccount.signTransaction(modifyMetadataTransaction, generationHash);

          expect(modifyMetadataTransaction.size(), 181);
          expect(signedTransaction.payload.length, 181 * 2);
          expect(signedTransaction.payload.substring(244, signedTransaction.payload.length,).toLowerCase(),
              (testingAccount.publicKey + '859CBD19B98E068F' + ByteUtils.bytesToHex(namespaceId.toBytes()) + 'FDFF070000000000696E67').toLowerCase());
        });

        test('should return 173 for accountMetadataTransaction byte size with newValue=testing, oldValue=""', () async {
          final modifyMetadataTransaction = AccountMetadataTransaction.create(Deadline(hours: 1),
              testingAccount.publicAccount, 'name', 'testing', '', NetworkType.MIJIN_TEST, Uint64.zero);
          final signedTransaction = await testingAccount.signTransaction(modifyMetadataTransaction, generationHash);

          expect(modifyMetadataTransaction.size(), 173);
          expect(signedTransaction.payload.length, 173 * 2);
          expect(signedTransaction.payload.substring(244, signedTransaction.payload.length,).toLowerCase(),
              (testingAccount.publicKey + '859CBD19B98E068F' + '0700070074657374696E67').toLowerCase());
        });

      });
    });
  });
}
