import 'package:nem2_sdk_dart/api.dart';
import "package:nem2_crypto/nem2_crypto.dart" show n;


void main() {
  var api_instance = new AccountRoutesApi();

  // String | The public key or address of the account.
  var accountId =
      "ca619089b881145046ba18e2c626945d3e9ab3078a6c4391c66b466ba4a27289";

  var plomo = nem2Const.();
  try {
    var result = api_instance.getAccountInfo(accountId);
    print(result);
  } catch (e) {
    print("Exception when calling AccountRoutesApi->getAccountInfo: $e\n");
  }
}
