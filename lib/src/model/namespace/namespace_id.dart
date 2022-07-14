/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

class NamespaceId extends AssetId {
  NamespaceId._internal(Uint64 id) : super(id);

  /// Creates a new [NamespaceId] from an [Uint64] id.
  factory NamespaceId(Uint64 id) {
    if (id != Uint64.zero && !hasBits(id, namespaceBit)) {
      throw ArgumentError("namespaceId doesn't have 64th bit");
    }
    return NamespaceId._internal(id);
  }

  /// Creates a new [NamespaceId] from a [bigInt].
  factory NamespaceId.fromBigInt(BigInt bigInt) => NamespaceId(Uint64.fromBigInt(bigInt));

  /// Creates a new [NamespaceId] from a [hex].
  factory NamespaceId.fromHex(String hex) => NamespaceId(Uint64.fromHex(hex));

  /// Creates a new [NamespaceId] from a pair of 32-bit integers.
  factory NamespaceId.fromInts([int value = 0, int value2 = 0]) => NamespaceId(Uint64.fromInts(value, value2));

  /// Creates a new [NamespaceId] from a [namespaceName].
  factory NamespaceId.fromName(String namespaceName) {
    if (namespaceName.isEmpty) {
      throw ArgumentError('Either fullName is required');
    }
    return generateNamespacePath(namespaceName);
  }

  @override
  int get hashCode => Object.hash('NamespaceId'.hashCode, super.hashCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NamespaceId && runtimeType == other.runtimeType && toHex() == other.toHex();
}
