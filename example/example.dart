import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet2.brimstone.xpxsirius.io:3000';

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = newClient(config,  BrowserClient());
  final client = SiriusClient.fromUrl(baseUrl, null);

  final generationHash = await client.generationHash;

  final networkType = await client.networkType;

  /// Create an Account from a given Private key.
  final account =
      Account.fromPrivateKey('6703EBF8E23AFE09DA34EA27DD0A75DCB8A237AB6DB89E7A8C7545FE4B5155E1', networkType);

  /// Create an Address from a given Public key.
  final recipient = Address.fromRawAddress('VDI5IS-5YXT5G-LRT5RS-S3EZIB-4QOAI2-6GLWR2-TDK7');

  /// Create a  transaction type transfer
  final tx = TransferTransaction(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [xpx(10)],
      // The transaction message of 1024 characters.
      PlainMessage(payload: 'Transfer from Dart sdk'),
      networkType);

  final stx = account.signTransaction(tx, generationHash);

  try {
    final restTx = await client.transaction.announce(stx);
    print(restTx);
    print('Hash: ${stx.hash}');
    print('Signer: ${account.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
