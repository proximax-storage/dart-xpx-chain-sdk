/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

class NamespaceId extends AssetId {
  factory NamespaceId({final Uint64? id}) {
    if (id == null) {
      throw errNullId;
    }

    return NamespaceId._(id);
  }

  const NamespaceId._(final Uint64? id) : super(id);

  /// NewNamespaceIdFromName generate Id from namespaceName
  NamespaceId.fromName(String namespaceName)
      : super(generateNamespacePath(namespaceName));

  static NamespaceId fromInts([final int value = 0, final int value2 = 0]) => NamespaceId._(Uint64.fromInts(value, value2));
  
  NamespaceId.fromUint64(final Uint64 value) : super(value);

  static NamespaceId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final Uint64 bigInt = Uint64.fromHex(hex);
    return NamespaceId._(bigInt);
  }

  @override
  int get hashCode => 'NamespaceId'.hashCode ^ super.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) ||
      other is NamespaceId &&
          runtimeType == other.runtimeType &&
          toBytes() == other.toBytes();

  @override
  String toString() => encoder.convert(this);

  @override
  String toJson() => super.value!.toHexString();
}
