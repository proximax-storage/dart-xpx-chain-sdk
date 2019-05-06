import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://54.169.118.203:3000";
const networkType = MijinTest;

/// Simple BlockChain API request
void main() async {
  var config = new  NewConfig(baseUrl, networkType);

  /// Creating a client instance
  /// xpx_catapult_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = NewClient(config, new BrowserClient());
  var client =  NewClient(config, null);

  /// Get the current height of the chain.
  try {
    var result = await client.BlockChain().GetBlockByHeight(1333762);
    print(result);
  } catch (e) {
    print("Exception when calling BlockChain->GetBlockByHeight: $e\n");
  }
}