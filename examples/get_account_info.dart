import 'package:nem2_sdk_dart/api.dart';

void main() {
  // String | The public key.
  var accountId = "ca619089b881145046ba18e2c626945d3e9ab3078a6c4391c66b466ba4a27289";

  var account  = NewAddressFromPublicKey(accountId, 168);

    print(account);

}
