import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const privateKey = '16a0422ca629765a04d2da88404e90f6d82c44c6009cffc7664517731df7746d';

  /// Create an Account from a given Private key.
  final accountOne = await Account.fromPrivateKey(privateKey, NetworkType.PRIVATE);
  print(accountOne);

  /// Create an random Account from a given networkType.
  final accountTwo = await Account.random(NetworkType.PRIVATE);
  print(accountTwo);

  const publicKey = 'b4f12e7c9f6946091e2cb8b6d3a12b50d17ccbbf646386ea27ce2946a7423dcf';

  /// Create an Account from a given publicKey hex string.
  final publicAccount = PublicAccount.fromPublicKey(publicKey, NetworkType.PRIVATE_TEST);
  print(publicAccount.address);

  const rawAddress = 'z';

  /// Creates an Sirius 'Address' from a given raw address string.
  ///
  /// A Sirius raw address string looks like:
  /// * VAQXZH7TDE6EMG7KIGJ5KPCHHAEDYK4VIMLZD7VK or VAQXZH-7TDE6E-MG7KIG-J5KPCH-HAEDYK-4VIMLZ-D7VK.
  final addressOne = Address.fromRawAddress(rawAddress);
  print(Uint64.fromUtf8(addressOne.address).toHex());

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
