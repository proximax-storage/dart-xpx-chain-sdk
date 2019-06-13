import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

final networkType = PublicTest;

/// Simple Node API request
void main() async {
  var config = new NewConfig(baseUrl, networkType);

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = NewClient(config, new BrowserClient());
  var client = NewClient(config, null);

  /// Get the node information.
  try {
    var result = await client.Node.GetNodeInfo();
    print(result);
  } catch (e) {
    print("Exception when calling Transaction->GetNodeInfo: $e\n");
  }

  /// Get the node time.
  try {
    var result = await client.Node.GetNodeTime();
    print(result);
  } catch (e) {
    print("Exception when calling Transaction->GetNodeTime: $e\n");
  }
}
