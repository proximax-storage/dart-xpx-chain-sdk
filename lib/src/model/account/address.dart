/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

class Address {
  Address._(this.address, this.networkType);

  static Address fromEncoded(String encoded) {
    final List<int> pH = hex.decode(encoded);
    final parsed = base32.encode(Uint8List.fromList(pH));
    final a = Address.fromRawAddress(parsed);
    return Address._(a.address, a.networkType);
  }

  /// Create an [Address] from a given public key.
  static Address fromPublicKey(String pKey, NetworkType networkType) {
    if (networkType == NetworkType.UNKNOWN_NETWORK_TYPE) {
      throw ArgumentError('Network type unsupported');
    }
    final address = _generateEncodedAddress(pKey, networkType.identifier);
    return Address._(address, networkType);
  }

  /// Create an [Address] from a given raw address
  static Address fromRawAddress(String address) {
    final addressRaw = address.trim().replaceAll('-', '').toUpperCase();

    if (addressRaw.length != addressEncodeSize) {
      throw ArgumentError('Address $addressRaw has to be $addressEncodeSize characters long');
    }

    return Address._(addressRaw, NetworkType.getAddressNet(addressRaw[0]));
  }

  NetworkType networkType;
  String address;

  String get pretty => _pretty(address);

  Uint8List decode() => base32.decode(address);

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

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'networkType': networkType, 'address': address};
}
