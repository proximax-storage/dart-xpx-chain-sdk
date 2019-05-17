import 'package:xpx_catapult_sdk/xpx_sdk.dart';

const baseUrl = "http://bcstage1.xpxsirius.io:3000";

final networkType = PublicTest;

/// Simple Mosaic API request
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

  /// Gets the mosaic definition for a given mosaicId.
  try {
    var result = await client.Mosaic.GetMosaic(XpxMosaicId);
    print(result);
  } catch (e) {
    print("Exception when calling Mosaic->GetMosaic: $e\n");
  }

  /// Gets an array of mosaic definition.
  MosaicIds Ids = new MosaicIds();
  Ids.add(XpxMosaicId);
  try {
    var result = await client.Mosaic.GetMosaics(Ids);
    print(result);
  } catch (e) {
    print("Exception when calling Mosaic->GetMosaics: $e\n");
  }

  /// Returns friendly names for mosaics.
  try {
    var result = await client.Mosaic.GetMosaicsName(Ids);
    print(result);
  } catch (e) {
    print("Exception when calling Mosaic->GetMosaicsName: $e\n");
  }
}
