import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API request
void main() async {
  const baseUrl = 'http://bctestnet1.xpxsirius.io:3000';

  const networkType = publicTest;

  final config = Config(baseUrl, networkType);

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = newClient(config,  BrowserClient());
  final client = ApiClient.fromConf(config, null);

  /// Create an Address from a given public key.
  final addressOne = Address.fromPublicKey(
      '52BFDA0BDC6456ECAF78B8D2046A8ECB1D951B5BB95EE37165627959DD7C029E',
      networkType);

  final addressTwo = Address.fromPublicKey(
      'B4F12E7C9F6946091E2CB8B6D3A12B50D17CCBBF646386EA27CE2946A7423DCF',
      networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    final result = await client.account.getAccountInfo(addressTwo);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountInfo: $e\n');
  }

  final List<String> addresses = [];
  addresses.add(addressOne.address);
  addresses.add(addressTwo.address);

  try {
    /// Get accounts information.
    /// Param addresses - A List of Address string.
    final result = await client.account.getAccountsInfo(addresses);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsInfo: $e\n');
  }
}