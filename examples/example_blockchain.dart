import 'package:xpx_catapult_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

final networkType = PublicTest;

/// Simple BlockChain API request
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

  /// Gets the current score of the blockchain.
  try {
    var result = await client.BlockChain.GetBlockchainScore();
    print(result);
  } catch (e) {
    print("Exception when calling BlockChain->GetBlockchainScore: $e\n");
  }

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

  /// Returns statistical information about the blockchain.
  try {
    var result = await client.BlockChain.GetDiagnosticStorage();
    print(result);
  } catch (e) {
    print("Exception when calling BlockChain->GetDiagnosticStorage: $e\n");
  }

  /// Gets up to limit number of blocks after given block height.
  final height = BigInt.from(1);
  final limit = BigInt.from(50);
  try {
    var result =
        await client.BlockChain.GetBlocksByHeightWithLimit(height, limit);
    print(result);
  } catch (e) {
    print(
        "Exception when calling BlockChain->GetBlocksByHeightWithLimit: $e\n");
  }
}
