import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API AnnounceTransaction
void main() async {
  const baseUrl = 'http://bctestnet1.xpxsirius.io:3000';

  const networkType = publicTest;

  final config = NewConfig(baseUrl, networkType);

  final client = newClient(config, null);

  /// Create an Account from a given Private key.
  final account = Account.fromPrivateKey(
      'B4F12E7C9F6946091E2CB8B6D3A12B50D17CCBBF646386EA27CE2946A7423DCF',
      networkType);

  /// Create an Address from a given Public key.
  final recipient = Address.fromPublicKey(
      '52BFDA0BDC6456ECAF78B8D2046A8ECB1D951B5BB95EE37165627959DD7C029E',
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
