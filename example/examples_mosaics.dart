import 'package:fixnum/fixnum.dart';
import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bcstage1.xpxsirius.io:3000";

final networkType = publicTest;

/// Simple Mosaic API request
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

  var toto = Int64.fromInts(231112638, 481110499);
//  final BigInt bigInt = BigInt.parse(toto, radix: 16);
  print(toto.toHexString());

//  print(bigIntegerToHex(BigInt.parse(toto, radix: 16)));
  /// Gets the mosaic definition for a given mosaicId.
  try {
    var result = await client.Mosaic.GetMosaic(xpxMosaicId);
    print(result);
  } catch (e) {
    print("Exception when calling Mosaic->GetMosaic: $e\n");
  }

  /// Gets an array of mosaic definition.
  MosaicIds Ids = new MosaicIds();
  Ids.add(xpxMosaicId);
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
