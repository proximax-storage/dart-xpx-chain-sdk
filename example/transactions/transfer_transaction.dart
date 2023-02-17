import 'dart:io';

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'https://api-1.testnet2.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final generationHash = await client.generationHash.catchError((err) {
    print('Get generationHash Error: ${err.error}');
    print('StackTrace: ${err.stackTrace}');
    exit(0);
  });

  final networkType = await client.networkType.catchError((err) {
    print('Get networkType Error: ${err.error}');
    // print('StackTrace: ${err.stackTrace}');
    exit(0);
  });

  /// Create an Account from a given Private key.
  final account =
      await Account.fromPrivateKey('26b64cb10f005e5988a36744ca19e20d835ccc7c105aaa5f3b212da593180930', networkType);
  print(account);

  /// Create an Address from a given Public key.
  final recipient = Address.fromRawAddress('VDI5IS-5YXT5G-LRT5RS-S3EZIB-4QOAI2-6GLWR2-TDK7');

  /// Create a  transaction type transfer
  final tx = TransferTransaction.create(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 2),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [xpx(1)],
      // The transaction message of 1024 characters.
      PlainMessage(payload: 'Dart Sirius Chain SDK'),
      networkType);

  final stx = await account.signTransaction(tx, generationHash!);

  try {
    final restTx = await client.transaction.announce(stx);
    print(restTx);
    print('Signer: ${account.publicAccount.publicKey}');
    print('Hash: ${stx.hash}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
