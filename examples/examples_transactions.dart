import 'package:xpx_catapult_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

final networkType = PublicTest;

/// Simple Transactions API request
void main() async {
  var config = new NewConfig(baseUrl, networkType);

  /// Creating a client instance
  /// xpx_catapult_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = NewClient(config, new BrowserClient());
  var client = NewClient(config, null);

  /// Returns transaction information given a transactionId or hash.
  var hash = "A07DD284D846186A36AE2787D264DBA332CE0ED92DFF758A9443E04E610EA2EB";

  try {
    var result = await client.Transaction.GetTransaction(hash);
    print(result);
  } catch (e) {
    print("Exception when calling Transaction->GetTransaction: $e\n");
  }

  /// Returns transaction information given a transactionId or hash.
  var d = new TransactionIds();
  d.transactionIds.add("C0B0C87B76C9C8333F734EA5EA758B4C2144DC47F1AA62981931BAF489726333");
  d.transactionIds.add("BDD805FEAD00C53D114D670188046F3B0A12F9B1C2E6AF12FB8035FC9B0576EA");

  try {
    var result = await client.Transaction.GetTransactions(d);
    print(result);
  } catch (e) {
    print("Exception when calling Transaction->GetTransactions: $e\n");
  }
}
