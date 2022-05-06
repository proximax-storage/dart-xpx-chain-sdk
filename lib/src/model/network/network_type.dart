/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.network;

class NetworkType {
  /// Returns a new constant [NetworkType] using [identifier] and [name].
  NetworkType._(this.identifier, this.name);

  static NetworkType UNKNOWN_NETWORK_TYPE =
      NetworkType._(0x0, 'network type is unknown');

  /// The Mijin [NetworkType] identifier. Decimal value = 96.
  static NetworkType MIJIN = NetworkType._(0x60, 'Mijin');

  /// The MijinTest [NetworkType] identifier. Decimal value = 144.
  static NetworkType MIJIN_TEST = NetworkType._(0x90, 'MijinTest');

  /// The Public [NetworkType] identifier. Decimal value = 184.
  static NetworkType PUBLIC = NetworkType._(0xb8, 'Public');

  /// The PublicTest [NetworkType] identifier. Decimal value = 168.
  static NetworkType PUBLIC_TEST = NetworkType._(0xa8, 'PublicTest');

  /// The Private [NetworkType] identifier. Decimal value = 200.
  static NetworkType PRIVATE = NetworkType._(0xc8, 'Private');

  /// The PrivateTest [NetworkType] identifier. Decimal value = 176.
  static NetworkType PRIVATE_TEST = NetworkType._(0xb0, 'PrivateTest');

  /// Returns a [NetworkType] for the given int value.
  ///
  /// Throws an error when the type is unknown.
  static NetworkType fromInt(final int value) {
    for (var type in values) {
      if (type.identifier == value) {
        return type;
      }
    }

    throw ArgumentError(UNKNOWN_NETWORK_TYPE);
  }

  static NetworkType fromName(String name) {
    switch (name) {
      case 'mijin':
        return getAddressNet('M');
      case 'mijinTest':
        return getAddressNet('S');
      case 'public':
        return getAddressNet('X');
      case 'publicTest':
        return getAddressNet('V');
      case 'private':
        return getAddressNet('Z');
      case 'privateTest':
        return getAddressNet('W');
      default:
        return NetworkType.UNKNOWN_NETWORK_TYPE;
    }
  }

  static NetworkType getAddressNet(String prefix) {
    final Map<String, int> addressNetMap = {
      'M': MIJIN.identifier,
      'S': MIJIN_TEST.identifier,
      'X': PUBLIC.identifier,
      'V': PUBLIC_TEST.identifier,
      'Z': PRIVATE.identifier,
      'W': PRIVATE_TEST.identifier,
    };
    final networkTypeValue = addressNetMap[prefix];
    if (networkTypeValue == null) {
      return NetworkType.UNKNOWN_NETWORK_TYPE;
    }
    return fromInt(networkTypeValue);
  }

  /// Returns a Map for all of the [NetworkType]s in [byIndex], mapping each
  /// [NetworkType]'s [identifier] to the [NetworkType].
  static Map<int, NetworkType> initByValue(List<NetworkType> byIndex) {
    final byValue = <int, NetworkType>{};
    for (var v in byIndex) {
      byValue[v.identifier] = v;
    }
    return byValue;
  }

  /// Supported network types.
  static final List<NetworkType> values = <NetworkType>[
    MIJIN,
    MIJIN_TEST,
    PUBLIC,
    PUBLIC_TEST,
    PRIVATE,
    PRIVATE_TEST
  ];

  /// This [NetworkType]'s integer value.
  late final int identifier;

  /// This [NetworkType]'s name.
  late final String name;

  /// Checks if the given [NetworkType] is valid.
  ///
  /// Throws an error if network type is invalid and when the parameter [throwError] is set to true.
  static bool isValid(final NetworkType userEventType,
          {bool throwError = false}) =>
      NetworkType.isValidValue(userEventType.identifier,
          throwError: throwError);

  /// Checks if the given int value is of a valid user network type.
  ///
  /// Throws an error if network type is invalid and when the parameter [throwError] is set to true.
  static bool isValidValue(final int userEventTypeInt,
      {final bool throwError = false}) {
    try {
      fromInt(userEventTypeInt);
      return true;
    } on Exception catch (_) {
      if (throwError) {
        rethrow;
      }
      return false;
    }
  }

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['networkIdentifier'] = identifier;
    data['name'] = name;

    return data;
  }
}
