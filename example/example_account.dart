import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Account API request
void main() async {
  const baseUrl = 'http://bctestnet1.brimstone.xpxsirius.io:3000';

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
  final addressOne = PublicAccount.fromPublicKey(
      '0D5248B9F8A9F8182DD2379F90F53906F054CC3A6C9FE621B291FD1212A7596A',
      networkType);

  final addressTwo = Address.fromPublicKey(
      '6152520970CF9E1278BB2CEFAC47D50E4204B91695E187449BF12AE9D217F2DA',
      networkType);

  try {
    /// Get AccountInfo for an account.
    /// Param address - A Address object.
    final result = await client.blockChain.getBlockByHeight(BigInt.from(118554));
    print(result);

  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountInfo: $e\n');
  }

//  final List<String> addresses = [];
//  addresses.add(addressOne.address);
//  addresses.add(addressTwo.address);
//
//  try {
//    /// Get accounts information.
//    /// Param addresses - A List of Address string.
//    final result = await client.account.getAccountsInfo(addresses);
//    print(result);
//  } on Exception catch (e) {
//    print('Exception when calling Account->GetAccountsInfo: $e\n');
//  }
}
