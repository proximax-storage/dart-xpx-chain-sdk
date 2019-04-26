part of nem2_sdk_dart;

const NUM_CHECKSUM_BYTES = 4;

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

// Create an Address from a given raw address.
Address NewAddressFromPublicKey(String pKey, int networkType){
  var ad = _generateEncodedAddress(pKey, networkType);
  return NewAddress(ad, networkType);
}

String _generateEncodedAddress(String pKey, int version){
  // step 1: sha3 hash of the public key
  var pKeyD =  new Uint8List.fromList(pKey.codeUnits);
	var sha3PublicKeyHash = crypto.HashesSha3_256(pKeyD);

  // step 2: ripemd160 hash of (1)
  var ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
	ripemd160StepOneHash.insert(0, version);

  // step 4: get the checksum of (3)
  var stepThreeChecksum = GenerateChecksum(ripemd160StepOneHash);

  // step 5: concatenate (3) and (4)
  ripemd160StepOneHash.addAll(stepThreeChecksum);

  // step 6: base32 encode (5)
 return base32.encode(ripemd160StepOneHash);
}

Uint8List GenerateChecksum(Uint8List b){
  // step 1: sha3 hash of (input
  var sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first NUM_CHECKSUM_BYTES bytes of (1)
	return sha3StepThreeHash.getRange(0, NUM_CHECKSUM_BYTES);
}