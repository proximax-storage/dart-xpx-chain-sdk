import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://bcstage1.xpxsirius.io:3000";

const networkType = PublicTest;

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
  var address = NewAddressFromPublicKey("B4F12E7C9F6946091E2CB8B6D3A12B50D17CCBBF646386EA27CE2946A7423DCF", networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    var result = await client.Account().GetAccountInfo(address);
    print(result);
  } catch (e) {
    print("Exception when calling Account->GetAccountInfo: $e\n");
  }
}