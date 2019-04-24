part of nem2_sdk_dart;

class Address {
  int networkType = null;
  String address = null;

  Address();
  @override
  String toString() {
    return 'Address[address=$address, networkType=$networkType]';
  }
}

class PublicAccount {
  String publicKey = null;
  Address address = null;

  PublicAccount();
  @override
  String toString() {
    return 'PublicAccount[address=$address, publicKey=$publicKey]';
  }
}

class Account {
  PublicAccount publicAccount = null;
  crypto.KeyPair account = null;

  Account();
  @override
  String toString() {
    return 'Account[account=$account, publicAccount=$publicAccount]';
  }
}

// Create an Address from a given raw address
Address NewAddress(String address, int networkType) {
  address = address.replaceAll("-", "");
  var ad = new Address();
  ad.address = address.toUpperCase();
  ad.networkType = networkType;
  return ad;
}
