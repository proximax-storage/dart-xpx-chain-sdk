import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const privateKey = 'B3543906F375F9259FC4687EAE644FF71982ED1AEA97E9AAF6D031B200DE849C';

  /// Create an Account from a given Private key.
  final accountOne = await Account.fromPrivateKey(privateKey, NetworkType.PUBLIC_TEST);
  print(accountOne);

  /// Create an random Account from a given networkType.
  final accountTwo = await Account.random(NetworkType.PUBLIC_TEST);
  print(accountTwo);

  const publicKey = '9a6a4e41d2b69dfe899c0c34d56261059986340cf83fc597d4b6715ab9e77ac8';

  /// Create an Account from a given publicKey hex string.
  final publicAccount = PublicAccount.fromPublicKey(publicKey, NetworkType.PUBLIC_TEST);
  print(publicAccount);

  const rawAddress = 'VAQXZH7TDE6EMG7KIGJ5KPCHHAEDYK4VIMLZD7VK';

  /// Creates an Sirius 'Address' from a given raw address string.
  ///
  /// A Sirius raw address string looks like:
  /// * VAQXZH7TDE6EMG7KIGJ5KPCHHAEDYK4VIMLZD7VK or VAQXZH-7TDE6E-MG7KIG-J5KPCH-HAEDYK-4VIMLZ-D7VK.
  final addressOne = Address.fromRawAddress(rawAddress);
  print(addressOne);

  /// Create an [Address] from a given public key.
  final addressTwo = Address.fromPublicKey(publicKey, NetworkType.PUBLIC_TEST);
  print(addressTwo);

  const encodedAddress = 'A83850DF3301785F586F156D71879E870626093580406EBC5A';

  /// Create an Symbol `Address` from the given hex string address
  ///
  /// A hex string address looks like: 908E2C873E8552039933562AFB74A193B48BDD300BEBDB93.
  ///
  /// * Before: A83850DF3301785F586F156D71879E870626093580406EBC5A
  /// * After: VA4FBXZTAF4F6WDPCVWXDB46Q4DCMCJVQBAG5PC2
  final addressThree = Address.fromEncoded(encodedAddress);
  print(addressThree);
}
