import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API request
void main() async {
  const baseUrl = 'http://bctestnet2.brimstone.xpxsirius.io:3000';

  const networkType = publicTest;

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = newClient(config,  BrowserClient());
  final client = SiriusClient.fromUrl(baseUrl, null);

  /// Create an Address from a given public key.
  final addressOne = Account.fromPrivateKey(
      '3B7560B5CB19C893694FC49B461CE489BF9588BE16DBE8DC29CF06338133DEE6',
      networkType);

  final addressTwo = PublicAccount.fromPublicKey(
      '29CF06338133DEE64FC49BCB19C8936916DBE8DC461CE489BF9588BE3B9670B5',
      networkType);

  final addressThree = Address.fromPublicKey(
      '3B49BF0A08BB7528E54BB803BEEE0D935B2C800364917B6EFF331368A4232FD5',
      networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    final result = await client.account.transactions(addressOne.publicAccount);
    print(result);

  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountInfo: $e\n');
  }



//  try {
//    /// Get accounts information.
//    /// Param addresses - A List of Address string.
//    final result = await client.account.getAccountsInfo([addressOne.address, addressTwo]);
//    print(result);
//  } on Exception catch (e) {
//    print('Exception when calling Account->GetAccountsInfo: $e\n');
//  }
}
