import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

const networkType = publicTest;

/// Simple Account API AnnounceTransaction
void main() async {
  var config =  NewConfig(baseUrl, networkType);

  var client = NewClient(config, null);

  /// Create an Account from a given Private key.
  var account =  Account.fromPrivateKey(
      "1ACE45EAD3C2F0811D9F4355F35BF78483324975083BE4E503EA49DFFEA691A0",
      networkType);

  /// Create an Address from a given Public key.
  var recipient =  Address.fromPublicKey(
      "68f50e10e5b8be2b7e9ddb687a667d6e94dd55fe02b4aed8195f51f9a242558b",
      networkType);

  /// Create a  transaction type transfer
  var tx =  TransferTransaction(
      // The maximum amount of time to include the transaction in the blockchain.
       Deadline(hours: 1),
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [Xpx(15)],
      // The transaction message of 1024 characters.
       Message.PlainMessage("From ProximaX Dart SDK"),
      networkType);

  var stx = account.sign(tx);

  var restTx = await client.Transaction.AnnounceTransaction(stx);
  print(restTx);
  print("Hash: ${stx.hash}");
  print("Signer: ${account.publicAccount.publicKey}");
}
