import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://54.169.118.203:3000";

const networkType = MijinTest;

/// Simple Account API request
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

  /// Create an Address from a given public key.
  var address = NewAddressFromPublicKey("7881B12F6080B0524F11AF08AB226F7BA7B57286A90A8DE0580E2BC9FE06289D", networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    var result = await client.Account().GetAccountInfo(address);
    print(result);
  } catch (e) {
    print("Exception when calling Account->GetAccountInfo: $e\n");
  }
}