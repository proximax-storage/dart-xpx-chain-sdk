import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

const networkType = PublicTest;

/// Simple Account API request
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

  /// Create an Address from a given public key.
  var addressOne = new Address.fromPublicKey(
      "95DE2FFDCC397BB9688DA28A18A70FDD23F4CE2EF4240A4A7B6BAF5DFA07E5DC",
      networkType);

  var addressTwo = new Address.fromPublicKey(
      "C64FA80DB046F488CC1C480454834D4CAE8284DDC14D6E93332AD02E345FF2C5",
      networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    var result = await client.Account.GetAccountInfo(addressOne);
    print(result);
  } catch (e) {
    print("Exception when calling Account->GetAccountInfo: $e\n");
  }

  var adds = new Addresses();
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
