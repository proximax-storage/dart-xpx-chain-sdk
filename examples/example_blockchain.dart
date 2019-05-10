import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://bcstage1.xpxsirius.io:3000";
const networkType = PublicTest;

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
    var result = await client.BlockChain.GetBlockchainHeight();
    print(result);
  } catch (e) {
    print("Exception when calling BlockChain->GetBlockByHeight: $e\n");
  }

  ///Get BlockInfo for a given block height.
  try {
    var height = BigInt.from(1);
    var result = await client.BlockChain.GetBlockByHeight(height);
    print(result);
  } catch (e) {
    print("Exception when calling BlockChain->GetBlockByHeight: $e\n");
  }

}