import 'dart:io';

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://demo-api-1.edlx.io:3000';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final generationHash = await client.generationHash.catchError((err) {
    print('Get generationHash Error: ${err.error}');
    // print('StackTrace: ${err.stackTrace}');
    exit(0);
  });

  final networkType = await client.networkType.catchError((err) {
    print('Get networkType Error: ${err.error}');
    // print('StackTrace: ${err.stackTrace}');
    exit(0);
  });

  /// Create an [Account] from a given Private key.
  final bobAccount =
      await Account.fromPrivateKey('970F8FE51765D1E426C0FE895B7B217FB47C39D049C68EEDFD71FB523812DF11', networkType);

  /// Create an [PublicAccount] from a given Public key.
  final alicePublicAccount =
      PublicAccount.fromPublicKey('D04AB232742BB4AB3A1368BD4615E4E6D0224AB71A016BAF8520A332C9778737', networkType);

  // replace with mosaic id
  final mosaicId = MosaicId.fromHex('2111AB580BD93748');

  /// Create a  transaction type transfer
  final metadataTx = MosaicMetadataTransaction.create(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      mosaicId,
      bobAccount.publicAccount,
      'name',
      'testing',
      '',
      networkType);

  metadataTx.toAggregate = bobAccount.publicAccount;

  final aggregateTransaction = AggregateTransaction.complete(
    Deadline(hours: 1),
    [metadataTx],
    networkType,
  );

  final signedMetadataTxTransaction = await bobAccount.signTransaction(aggregateTransaction, generationHash!);

  // final hashLockTransaction = LockFundsTransaction.create(
  //   Deadline(hours: 1),
  //   xpxRelative(10),
  //   Uint64.fromInt(480),
  //   signedMetadataTxTransaction,
  //   networkType,
  // );
  //
  // final signedHashLockTransaction = await bobAccount.signTransaction(
  //   hashLockTransaction,
  //   generationHash,
  // );
  //
  // try {
  //   final restTx = await client.transaction.announce(signedHashLockTransaction);
  //   print(restTx);
  //   print('Hash: ${signedHashLockTransaction.hash}');
  //   print('Signer: ${bobAccount.publicAccount.publicKey}');
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->Announce: $e\n');
  // }
  //
  // sleep(const Duration(seconds: 30));

  try {
    final restTx = await client.transaction.announce(signedMetadataTxTransaction);
    print(restTx);
    print('Hash: ${signedMetadataTxTransaction.hash}');
    print('Signer: ${bobAccount.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
