import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://bcstage1.xpxsirius.io:3000";

final networkType = NetworkType.PUBLIC_TEST;

/// Simple Namespace API request
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

  /// Generate Id from namespaceName
  var ns = NewNamespaceIdFromName("prx");
  try {
    var result = await client.Namespace.GetNamespace(ns);
    print(result);
  } catch (e) {
    print("Exception when calling Namespace->GetNamespace: $e\n");
  }
}
