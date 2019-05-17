import 'package:xpx_catapult_sdk/xpx_sdk.dart';

const baseUrl = "http://bcstage1.xpxsirius.io:3000";

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
  try {
    var result = await client.Transaction.GetTransaction(
            "C0B0C87B76C9C8333F734EA5EA758B4C2144DC47F1AA62981931BAF489726333")
        as TransferTransaction;

    print(result);
  } catch (e) {
    print("Exception when calling Transaction->GetTransaction: $e\n");
  }
}
