import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

const networkType = publicTest;

/// Simple Account API request
void main() async {
  var config =  NewConfig(baseUrl, networkType);

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = NewClient(config,  BrowserClient());
  var client = NewClient(config, null);

  /// Create an Address from a given public key.
  var addressOne =  Address.fromPublicKey(
      "16DBE8DC29CF06338133DEE64FC49B461CE489BF9588BE3B9670B5CB19C89368",
      networkType);

  var addressTwo =  Address.fromPublicKey(
      "C64FA80DB046F488CC1C480454834D4CAE8284DDC14D6E93332AD02E345FF2C5",
      networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    var result = await client.Account.GetAccountMultisigGraph(addressOne);
    print(result);
  } catch (e) {
    print("Exception when calling Account->GetAccountInfo: $e\n");
  }

  var adds = Addresses();
  adds.addresses.add(addressOne.address);
  adds.addresses.add(addressTwo.address);

  try {
    /// Get accounts information.
    /// Param address - A Address object.
    var result = await client.Account.GetAccountsInfo(adds);
    print(result);
  } catch (e) {
    print("Exception when calling Account->GetAccountInfo: $e\n");
  }
}
