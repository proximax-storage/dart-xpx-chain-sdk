import 'package:xpx_catapult_sdk/api.dart';

const baseUrl  = "http://bcstage1.xpxsirius.io:3000";

final networkType = NetworkType.PUBLIC_TEST;

/// Simple Mosaic API request
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

  /// Gets the mosaic definition for a given mosaicId.
  try {
    var result = await client.Mosaic.GetMosaic(XpxMosaicId);
    print(result.properties);
  } catch (e) {
    print("Exception when calling Mosaic->GetMosaic: $e\n");
  }
}
