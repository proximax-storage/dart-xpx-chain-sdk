import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet3.brimstone.xpxsirius.io:3000';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final generationHash = await client.generationHash;

  final networkType = await client.networkType;

  /// Create an Account from a given Private key.
  final account = await Account.fromPrivateKey(
      '970F8FE51765D1E426C0FE895B7B217FB47C39D049C68EEDFD71FB523812DF10',
      networkType);

  /// Create an Address from a given Public key.
  final recipient =
      Address.fromRawAddress('VDI5IS-5YXT5G-LRT5RS-S3EZIB-4QOAI2-6GLWR2-TDK7');

  /// Create a  transaction type transfer
  final tx = TransferTransaction.create(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [xpx(3)],
      // The transaction message of 1024 characters.
      PlainMessage(payload: 'Transfer from Dart sdk'),
      networkType);

  final stx = await account.signTransaction(tx, generationHash!);

  try {
    final restTx = await client.transaction.announce(stx);
    print(restTx);
    print('Hash: ${stx.hash}');
    print('Signer: ${account.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
