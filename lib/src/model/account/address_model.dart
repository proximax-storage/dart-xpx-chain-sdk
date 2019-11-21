part of xpx_chain_sdk;

class Address {
  Address._(this._address, this._networkType);

  Address.fromEncoded(String encoded) {
    final pH = hex.decode(encoded);
    final parsed = base32.encode(pH);
    final a = Address.fromRawAddress(parsed);
    _address = a.address;
    _networkType = a.networkType;
  }

  /// Create an Address from a given public key.
  Address.fromPublicKey(String pKey, int networkType) {
    if (networkType == null || NetworkType.getType(networkType) == 0) {
      throw ArgumentError('Network type unsupported');
    }

    _address = _generateEncodedAddress(pKey, networkType);
    _networkType = networkType;
  }

  int _networkType;

  String _address;

  int get networkType => _networkType;

  String get address => _address;

  String get pretty => _pretty(_address);

  /// Create an [Address] from a given raw address
  static Address fromRawAddress(String address) {
    final addressRaw = address.trim().replaceAll('-', '').toUpperCase();

    if (addressRaw.length != addressEncodeSize) {
      throw ArgumentError(
          'Address $addressRaw has to be $addressEncodeSize characters long');
    }

    return Address._(addressRaw, addressNet[addressRaw[0]]);
  }

  @override
  String toString() => '${toJson()}';

  static String _pretty(final String address) {
    final buffer = StringBuffer();

    for (int i = 0; i < 6; i++) {
      // ignore: use_string_buffers
      buffer.write(address.substring(i * 6, i * 6 + 6) + '-');
    }
    // ignore: join_return_with_assignment
    buffer.write(address.substring(address.length - 4));
    return buffer.toString();
  }

  Map<String, dynamic> toJson() =>
      {'networkType': networkType, 'address': address};
}

class Addresses {
  Addresses();

  Addresses.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    addresses = (json['addresses']).map((item) => item).toList();
  }

  Addresses.fromList(List<Address> list)
      : assert(json != null, 'json must not be null') {
    addresses = list.map((item) => item).toList();
  }

  List<Address> addresses = [];

  @override
  String toString() => 'addresses:$addresses';

  Map<String, dynamic> toJson() => {'addresses':addresses.map((a) => a._address).toList()};
}

String _generateEncodedAddress(String pKey, int version) {
  // step 1: sha3 hash of the public key
  final pKeyD = hex.decode(pKey);

  final sha3PublicKeyHash = crypto.HashesSha3_256(Uint8List.fromList(pKeyD));

  // step 2: ripemd160 hash of (1)
  final ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
  final versionPrefixedRipemd160Hash =
  addUint8List(Uint8List.fromList([version]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  final stepThreeChecksum = _generateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  final concatStepThreeAndStepSix =
  addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List _generateChecksum(Uint8List b) {
  // step 1: sha3 hash of (input
  final sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first numChecksumBytes bytes of (1)
  final p = sha3StepThreeHash.getRange(0, numChecksumBytes);
  final Uint8List hash = Uint8List(numChecksumBytes);
  for (int i = 0; i < numChecksumBytes; i++) {
    hash[i] = p.toList()[i];
  }
  return hash;
}
