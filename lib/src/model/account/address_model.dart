part of xpx_chain_sdk.account;

class Address {
  Address._(this.address, this.networkType);

  static Address fromEncoded(String encoded) {
    final pH = hex.decode(encoded);
    final parsed = base32.encode(pH);
    final a = Address.fromRawAddress(parsed);
    return Address._(a.address, a.networkType);
  }

  /// Create an [Address] from a given public key.
  static Address fromPublicKey(String pKey, int networkType) {
    if (networkType == null || NetworkType.getType(networkType) == 0) {
      throw ArgumentError('Network type unsupported');
    }
    final address = _generateEncodedAddress(pKey, networkType);
    return Address._(address, networkType);
  }

  /// Create an [Address] from a given raw address
  static Address fromRawAddress(String address) {
    final addressRaw = address.trim().replaceAll('-', '').toUpperCase();

    if (addressRaw.length != addressEncodeSize) {
      throw ArgumentError('Address $addressRaw has to be $addressEncodeSize characters long');
    }

    return Address._(addressRaw, addressNet[addressRaw[0]]);
  }

  int networkType;

  String address;

  String get pretty => _pretty(address);

  Uint8List decode() => base32.decode(address);

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

  Map<String, dynamic> toJson() => {'networkType': networkType, 'address': address};
}

class Addresses {
  Addresses();

  Addresses.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    addresses = (json['addresses']).map((item) => item).toList();
  }

  Addresses.fromList(List<Address> list) : assert(list != null, 'list must not be null') {
    addresses = list.map((item) => item).toList();
  }

  List<Address> addresses = [];

  @override
  String toString() => 'addresses:$addresses';

  Map<String, dynamic> toJson() => {'addresses': addresses.map((a) => a.address).toList()};
}
