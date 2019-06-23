import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet1.xpxsirius.io:3000';

  const networkType = publicTest;

  final config = NewConfig(baseUrl, networkType);

  final client = newClient(config, null);

  /// Create an Account from a given Private key.
  final account = Account.fromPrivateKey(
      '68f50e10e5b8be2b7e9ddb687a667d6e94dd55fe02b4aed8195f51f9a242558b',
      networkType);

  /// Create an Address from a given Public key.
  final recipient = Address.fromPublicKey(
      '68f50e10e5b8be2b7e9ddb687a667d6e94dd55fe02b4aed8195f51f9a242558b',
      networkType);

  /// Create a  transaction type transfer
  final tx = TransferTransaction(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [xpx(1)],
      // The transaction message of 1024 characters.
      Message.plainMessage('From ProximaX Dart SDK'),
      networkType);

  final stx = account.sign(tx);

  final restTx = await client.transaction.announceTransaction(stx);
  print(restTx);
  print('Hash: ${stx.hash}');
}
