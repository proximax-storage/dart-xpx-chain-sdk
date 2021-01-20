import 'package:xpx_chain_sdk/xpx_sdk.dart';

/// Simple Namespace API request
void main() async {
  const baseUrl = 'http://bctestnet1.brimstone.xpxsirius.io:3000';

  const networkType = publicTest;

  /// Creating a client instance
  /// xpx_chain_sdk uses the Dart's native HttpClient.
  /// Depending on the platform, you may want to use either
  /// the one which comes from dart:io or the BrowserClient
  /// example:
  /// 1- import 'package:http/browser_client.dart';
  /// 2- var client = newClient(config,  BrowserClient());
  final client = SiriusClient.fromUrl(baseUrl, null);

  final nsId = NamespaceId.fromName('prx');

  /// Generate Id from namespaceName
  try {
    final result = await client.namespace.getNamespace(nsId);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespace: $e\n');
  }
  print('\n');

  /// Returns friendly names for mosaics.
  try {
    final result = await client.namespace.getNamespacesNames([nsId]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesNames: $e\n');
  }

  final address =
      Address.fromPublicKey('6F4416CA9AE06AF4DDDE4A30132C55B47740C0262568BEE99D59CF3A92BD04D1', networkType);

  /// Gets an list of namespaces for a given account address.
  try {
    final result = await client.namespace.getNamespacesFromAccount(address);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesFromAccount: $e\n');
  }
  print('\n');

  /// Gets namespaces for a given array of addresses.
  try {
    final result = await client.namespace.getNamespacesFromAccounts([address]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesFromAccounts: $e\n');
  }
}
