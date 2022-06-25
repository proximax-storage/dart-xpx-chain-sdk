/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.namespace;

class NamespaceInfo {
  NamespaceInfo(this.namespaceId);

  static NamespaceInfo fromDTO(NamespaceInfoDTO dto) {
    final levels = extractLevels(dto);
    final namespaceInfo = NamespaceInfo(NamespaceId(levels[levels.length - 1]!));
    namespaceInfo.metaId = dto.meta!.id;
    namespaceInfo.active = dto.meta!.active;
    namespaceInfo.index = dto.meta!.index;

    final _ownerAddress = Address.fromEncoded(dto.namespace!.ownerAddress!);

    namespaceInfo.owner = PublicAccount.fromPublicKey(dto.namespace!.owner, _ownerAddress.networkType);

    namespaceInfo.startHeight = dto.namespace!.startHeight!.toUint64();
    namespaceInfo.endHeight = dto.namespace!.endHeight!.toUint64();
    namespaceInfo.depth = dto.namespace!.depth;
    namespaceInfo.levels = extractLevels(dto);
    namespaceInfo.typeSpace = dto.namespace!.type;

    if (dto.namespace!.alias != null) {
      if (dto.namespace!.alias!.address != null) {
        namespaceInfo.alias = Alias(address: Address.fromEncoded(dto.namespace!.alias!.address!));
      } else {
        namespaceInfo.alias = Alias(mosaicId: MosaicId(dto.namespace!.alias!.mosaicId!.toUint64()));
      }
    }
    if (dto.namespace!.parentId!.toUint64().toInt() != 0) {
      namespaceInfo.parent = NamespaceInfo(NamespaceId(dto.namespace!.parentId!.toUint64()));
    }

    return namespaceInfo;
  }

  bool? active;

  int? index;

  NamespaceId namespaceId;

  String? fullName;

  String? metaId;

  int? typeSpace;

  int? depth;

  List<Uint64?>? levels;

  NamespaceInfo? parent;

  PublicAccount? owner;

  Uint64? startHeight;

  Uint64? endHeight;

  Alias? alias;

  @override
  String toString() => encoder.convert(this);

  static List<NamespaceInfo> listFromDTO(List<NamespaceInfoDTO> json) =>
      json.isEmpty ? <NamespaceInfo>[] : json.map(NamespaceInfo.fromDTO).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['active'] = active;
    data['index'] = index;
    data['namespaceId'] = namespaceId;
    if (fullName != null) {
      data['fullName'] = fullName;
    }
    data['metaId'] = metaId;
    data['typeSpace'] = typeSpace;
    data['depth'] = depth;
    if (levels != null) {
      data['levels'] = levels!.map((e) => e!.toHexString()).toList();
    }
    if (parent != null) {
      data['parent'] = parent;
    }

    data['owner'] = owner;
    data['startHeight'] = startHeight;
    data['endHeight'] = endHeight;
    if (alias != null) {
      data['alias'] = alias;
    }

    return data;
  }
}
