import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

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

  /// Create a MosaicSupplyChange transaction.
  final mosaicSupplyChange = MosaicSupplyChangeTransaction.create(
      // The maximum amount of time to include the transaction in the blockchain.
      Deadline(hours: 1),
      MosaicSupplyType.increase,
      MosaicId.fromHex('2111AB580BD93748'),
      Uint64.fromInt(100000000),
      // The network type
      networkType);

  final stx =
      await account.signTransaction(mosaicSupplyChange, generationHash!);
  try {
    final restTx = await client.transaction.announce(stx);
    print(restTx);
    print('Hash: ${stx.hash}');
    print('Signer: ${account.publicAccount.publicKey}');
  } on Exception catch (e) {
    print('Exception when calling Transaction->Announce: $e\n');
  }
}
