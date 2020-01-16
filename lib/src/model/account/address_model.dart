part of xpx_chain_sdk.account;

class Address {
  Address._(this.address, this.networkType);

  Address.fromEncoded(String encoded) {
    final pH = hex.decode(encoded);
    final parsed = base32.encode(pH);
    final a = Address.fromRawAddress(parsed);
    address = a.address;
    networkType = a.networkType;
  }

  /// Create an Address from a given public key.
  Address.fromPublicKey(String pKey, this.networkType) {
    if (networkType == null || NetworkType.getType(networkType) == 0) {
      throw ArgumentError('Network type unsupported');
    }
    address = _generateEncodedAddress(pKey, networkType);
  }

  int networkType;

  String address;

  String get pretty => _pretty(address);

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
      : assert(list != null, 'json must not be null') {
    addresses = list.map((item) => item).toList();
  }

  List<Address> addresses = [];

  @override
  String toString() => 'addresses:$addresses';

  Map<String, dynamic> toJson() =>
      {'addresses': addresses.map((a) => a.address).toList()};
}
