import 'package:xpx_catapult_sdk/xpx_sdk.dart';

const baseUrl = "http://bcstage1.xpxsirius.io:3000";

final networkType = PublicTest;

/// Simple Namespace API request
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

  var nsId = NewNamespaceIdFromName("prx");

  /// Generate Id from namespaceName
  try {
    var result = await client.Namespace.GetNamespace(nsId);
    print(result);
  } catch (e) {
    print("Exception when calling Namespace->GetNamespace: $e\n");
  }
  print('\n');

  /// Gets an array of namespaces for a given account address.
  var address = new Address.fromPublicKey(
      "B4F12E7C9F6946091E2CB8B6D3A12B50D17CCBBF646386EA27CE2946A7423DCF",
      networkType);

  try {
    var result = await client.Namespace.GetNamespacesFromAccount(address);
    print(result);
  } catch (e) {
    print("Exception when calling Namespace->GetNamespacesFromAccount: $e\n");
  }
  print('\n');

  /// Gets namespaces for a given array of addresses.
  var d = new Addresses();
  d.addresses.add(address.address);

  try {
    var result = await client.Namespace.GetNamespacesFromAccounts(d);
    print(result);
  } catch (e) {
    print("Exception when calling Namespace->GetNamespacesFromAccounts: $e\n");
  }
  print('\n');

  /// Returns friendly names for mosaics.
  var nsIds = new NamespaceIds();
  nsIds.namespaceIds.add(nsId);

  try {
    var result = await client.Namespace.GetNamespacesNames(nsIds);
    print(result);
  } catch (e) {
    print("Exception when calling Namespace->GetNamespacesNames: $e\n");
  }
}
