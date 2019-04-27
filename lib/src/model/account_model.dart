part of nem2_sdk_dart;

const NUM_CHECKSUM_BYTES = 4;

class Address {
  int networkType = null;
  String address = null;

  Address();
  @override
  String toString() {
    return 'Address[networkType=$networkType, address=$address]';
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

// Create an PublicAccount from a given hex public key.
PublicAccount NewAccountFromPublicKey(String pKey, int networkType){
  var ad = _generateEncodedAddress(pKey, networkType);
  var address = NewAddress(ad, networkType);
  var pa = new PublicAccount();
  pa.address = address;
  pa.publicKey = pKey;
  return pa;
}

// Create an Account from a given hex private key.
Account NewAccountFromPrivateKey(String sHex, int networkType){
  var k = crypto.NewPrivateKeyFromHexString(sHex);
  var kp = crypto.NewKeyPair(k, null);
  print(kp.publicKey.toString());
  var pa = NewAccountFromPublicKey(kp.publicKey.toString(), networkType);
  var account = new Account();
  account.publicAccount = pa;
  account.account = kp;
  return account;
}

String _generateEncodedAddress(String pKey, int version){
  // step 1: sha3 hash of the public key
  var pKeyD =  HEX.decode(pKey);

  var sha3PublicKeyHash = crypto.HashesSha3_256(pKeyD);

  // step 2: ripemd160 hash of (1)
  var ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
  var versionPrefixedRipemd160Hash = addUint8List(Uint8List.fromList([version]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  var stepThreeChecksum = GenerateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  var concatStepThreeAndStepSix = addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List GenerateChecksum(Uint8List b){
  // step 1: sha3 hash of (input
  var sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first NUM_CHECKSUM_BYTES bytes of (1)
  var p = sha3StepThreeHash.getRange(0, NUM_CHECKSUM_BYTES);
  Uint8List hash = Uint8List(NUM_CHECKSUM_BYTES);
  for (int i = 0; i < NUM_CHECKSUM_BYTES; i++) hash[i] = p.toList()[i];
  return hash;
}

Uint8List addUint8List(Uint8List a, Uint8List b){
  Uint8List hash = Uint8List(b.length+a.length);
  for (int i = 0; i < a.length; i++) hash[i] = a[i];
  for (int i = 0; i < b.length; i++) hash[i+a.length] = b[i];
  return hash;
}