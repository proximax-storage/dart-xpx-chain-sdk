/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

class NamespaceName {
  NamespaceName.fromDTO(NamespaceNameDTO dto) {
    parentId =
        dto.parentId == null ? NamespaceId._(dto.parentId!.toUint64()) : null;
    namespaceId = NamespaceId._(dto.namespaceId!.toUint64());
    name = dto.name;
  }

  NamespaceId? parentId;

  late NamespaceId namespaceId;

  String? name;

  @override
  String toString() => encoder.convert(this);

  static List<NamespaceName> listFromDTO(List<NamespaceNameDTO> json) =>
      json.isEmpty
          ? <NamespaceName>[]
          : json.map(NamespaceName.fromDTO).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (parentId != null) {
      data['parentId'] = parentId!.toHex();
    }
    data['namespaceId'] = namespaceId.toHex();
    data['name'] = name;

    return data;
  }
}
