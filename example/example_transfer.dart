import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet1.brimstone.xpxsirius.io:3000';

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
  final account = Account.fromPrivateKey(
      'B5E83C52385CF97BBEA9A28C4EC495D95F7A3EF351290B6EEC70E80AA7F87B29',
      networkType);

  /// Create an Address from a given Public key.
  final recipient =
      Address.fromRawAddress('VC4XVXBWAR4JQ3NHCKS7PUHPZJKLXSWRVYXMDWW7');

  /// Create a  transaction type transfer
  final tx = TransferTransaction(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [xpx(1)],
      // The transaction message of 1024 characters.
      PlainMessage(payload: 'From ProximaX Dart SDK'),
      networkType);

  print(tx.mosaics[0].assetId);

  final stx = account.sign(tx, generationHash);

  try {
    final restTx = await client.transaction.announce(stx);
    print(restTx);
    print('Hash: ${stx.hash}');
    print('Signer: ${account.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
