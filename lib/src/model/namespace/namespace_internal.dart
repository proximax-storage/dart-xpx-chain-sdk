/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

const int namespaceBit = 1 << 63;

enum NamespaceType { root, sub }

// namespace id for PRX mosaic
final NamespaceId prxNamespaceId = NamespaceId.fromName('prx');

// namespace id for XPX mosaic
final NamespaceId xpxNamespaceId = NamespaceId.fromName('prx.xpx');

// namespace id for storage mosaic
final NamespaceId storageNamespaceId = NamespaceId.fromName('prx.storage');

// namespace id for streaming mosaic
final NamespaceId streamingNamespaceId = NamespaceId.fromName('prx.streaming');

/// generateNamespaceId create NamespaceId from namespace string name
/// (ex: prx or domain.subdom.subdome)
Uint64 generateNamespacePath(String name) {
  final parts = name.split('.');
  if (parts.isEmpty) {
    throw errInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw errInvalidNamespaceName;
  }

  var namespaceId = Uint64.zero;
  final List<Uint64> path = [];

  for (final part in parts) {
    if (!regValidNamespace.hasMatch(part)) {
      throw errInvalidNamespaceName;
    }

    namespaceId = generateNamespaceId(part, namespaceId);

    path.add(namespaceId);
  }
  return path[path.length - 1];
}

List<Uint64?> extractLevels(NamespaceInfoDTO ref) {
  final List<Uint64?> levels = [];

  if (ref.namespace!.level0!.higher != null) {
    final nsName = ref.namespace!.level0!.toUint64();
    levels.add(nsName);
  }

  if (ref.namespace!.level1!.higher != null) {
    final nsName = ref.namespace!.level1!.toUint64();
    levels.add(nsName);
  }

  if (ref.namespace!.level2!.higher != null) {
    final nsName = ref.namespace!.level2!.toUint64();
    levels.add(nsName);
  }

  return levels;
}

Uint64 generateNamespaceId(String name, Uint64 parentId) {
  final Uint8List parentIdBytes = parentId.toBytes();

  final sha3_256 = SHA3(256, SHA3_PADDING, 256);
  final result = sha3_256.update(parentIdBytes);

  final nameBytes = Uint8List(name.length);
  for (int i = 0; i < name.length; i++) {
    nameBytes[i] = name.codeUnits[i];
  }

  final t = result.update(nameBytes);
  final g = Int64.fromBytes(t.digest());

  final p = g | namespaceBit;

  return Uint64.fromHex(p.toHexString());
}

final RegExp regValidNamespace = RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);
