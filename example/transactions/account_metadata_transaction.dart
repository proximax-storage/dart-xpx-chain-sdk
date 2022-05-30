import 'dart:io';

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet3.brimstone.xpxsirius.io:3000';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final generationHash = await client.generationHash;

  final networkType = await client.networkType;

  /// Create an Account from a given Private key.
  final bobAccount = await Account.fromPrivateKey(
      '970F8FE51765D1E426C0FE895B7B217FB47C39D049C68EEDFD71FB523812DF10',
      networkType);

  /// Create an Account from a given Private key.
  final alicePublicAccount = PublicAccount.fromPublicKey(
      'D04AB232742BB4AB3A1368BD4615E4E6D0224AB71A016BAF8520A332C9778737',
      networkType);

  /// Create a  transaction type transfer
  final metadataTx = AccountMetadataTransaction.create(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      alicePublicAccount,
      'CERT',
      'Hello world',
      '',
      networkType);

  print(metadataTx);

  metadataTx.toAggregate = bobAccount.publicAccount;

  final aggregateTransaction = AggregateTransaction.bonded(
    Deadline(hours: 1),
    [metadataTx],
    networkType,
  );

  final signedMetadataTxTransaction =
      await bobAccount.signTransaction(aggregateTransaction, generationHash!);

  final hashLockTransaction = LockFundsTransaction.create(
    Deadline(hours: 1),
    xpxRelative(10),
    Uint64.fromInt(480),
    signedMetadataTxTransaction,
    networkType,
  );

  final signedHashLockTransaction = await bobAccount.signTransaction(
    hashLockTransaction,
    generationHash,
  );

  try {
    final restTx = await client.transaction.announce(signedHashLockTransaction);
    print(restTx);
    print('Hash: ${signedHashLockTransaction.hash}');
    print('Signer: ${bobAccount.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }

  sleep(const Duration(seconds: 30));

  try {
    final restTx = await client.transaction
        .announcePartialTransaction(signedMetadataTxTransaction);
    print(restTx);
    print('Hash: ${signedMetadataTxTransaction.hash}');
    print('Signer: ${bobAccount.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
