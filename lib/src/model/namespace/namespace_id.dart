/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

class NamespaceId extends AssetId {
  /// Creates a new [NamespaceId] from an [Uint64] id.
  NamespaceId(Uint64 id) : super(id);

  /// Creates a new [NamespaceId] from a [bigInt].
  NamespaceId.fromBigInt(BigInt bigInt) : super(Uint64.fromBigInt(bigInt));

  /// Creates a new [NamespaceId] from a [hex].
  NamespaceId.fromHex(String hex) : super(Uint64.fromHex(hex));

  /// Creates a new [NamespaceId] from a pair of 32-bit integers.
  NamespaceId.fromInts([int value = 0, int value2 = 0]) : super(Uint64.fromInts(value, value2));

  /// Creates a new [NamespaceId] from a [namespaceName].
  factory NamespaceId.fromName(String namespaceName) {
    if (namespaceName.isEmpty) {
      throw ArgumentError('Either fullName is required');
    }
    return NamespaceId(generateNamespacePath(namespaceName));
  }

  @override
  int get hashCode => 'NamespaceId'.hashCode ^ super.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) || other is NamespaceId && runtimeType == other.runtimeType && toHex() == other.toHex();
}
