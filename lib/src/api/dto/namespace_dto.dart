/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class NamespaceDTO {
  NamespaceDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    owner = json['owner'];
    ownerAddress = json['ownerAddress'];
    startHeight = UInt64DTO.fromJson(json['startHeight']);
    endHeight = UInt64DTO.fromJson(json['endHeight']);
    depth = json['depth'];
    level0 = UInt64DTO.fromJson(json['level0']);
    level1 = UInt64DTO.fromJson(json['level1']);
    level2 = UInt64DTO.fromJson(json['level2']);
    type = json['type'];
    alias = AliasDTO.fromJson(json['alias']);
    parentId = UInt64DTO.fromJson(json['parentId']);
  }

  String? owner;
  String? ownerAddress;
  UInt64DTO? startHeight;
  UInt64DTO? endHeight;
  int? depth;
  UInt64DTO? level0;
  UInt64DTO? level1;
  UInt64DTO? level2;
  int? type;
  AliasDTO? alias;
  UInt64DTO? parentId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['owner'] = owner;
    data['ownerAddress'] = ownerAddress;
    data['startHeight'] = startHeight;
    data['endHeight'] = endHeight;
    data['depth'] = depth;
    data['level0'] = level0;
    data['level1'] = level1;
    data['level2'] = level2;
    data['type'] = type;
    data['alias'] = alias;
    data['parentId'] = parentId;

    return data;
  }

  static List<NamespaceDTO> listFromJson(List<Map> json) =>
      json.isEmpty ? [] : json.map(NamespaceDTO.fromJson).toList();

  static Map<String, NamespaceDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceDTO.fromJson(value));
    }
    return map;
  }
}

class NamespaceInfoDTO {
  NamespaceInfoDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    meta = NamespaceMetaDTO.fromJson(json['meta']);
    namespace = NamespaceDTO.fromJson(json['namespace']);
  }

  NamespaceMetaDTO? meta;

  NamespaceDTO? namespace;

  static List<NamespaceInfoDTO> listFromJson(List<Map> json) =>
      json.isEmpty ? [] : json.map(NamespaceInfoDTO.fromJson).toList();

  static Map<String, NamespaceInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceInfoDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['namespace'] = namespace;

    return data;
  }
}

class NamespaceMetaDTO {
  NamespaceMetaDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    id = json['id'];
    active = json['active'];
    index = json['index'];
  }

  String? id;

  bool? active;

  int? index;

  static List<NamespaceMetaDTO> listFromJson(List<Map> json) =>
      json.isEmpty ? [] : json.map(NamespaceMetaDTO.fromJson).toList();

  static Map<String, NamespaceMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceMetaDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceMetaDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['index'] = index;

    return data;
  }
}

class NamespaceNameDTO {
  NamespaceNameDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    parentId = UInt64DTO.fromJson(json['parentId']);
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'];
  }

  UInt64DTO? parentId;

  UInt64DTO? namespaceId;

  String? name;

  static List<NamespaceNameDTO> listFromJson(List<Map<String, dynamic>> json) =>
      json.isEmpty
          ? <NamespaceNameDTO>[]
          : json.map(NamespaceNameDTO.fromJson).toList();

  static Map<String, NamespaceNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceNameDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceNameDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['namespaceId'] = namespaceId;
    data['name'] = name;

    return data;
  }
}

class RegisterNamespaceTransactionInfoDTO {
  RegisterNamespaceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta =
        json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null
        ? RegisterNamespaceTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  MetaTransactionDTO? meta;
  RegisterNamespaceTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class RegisterNamespaceTransactionDTO extends AbstractTransactionDTO {
  RegisterNamespaceTransactionDTO(
      {String? signature,
      String? signer,
      int? version,
      int? type,
      List<int>? maxFee,
      List<int>? deadline,
      this.namespaceId,
      this.namespaceType,
      this.name,
      UInt64DTO? parenId,
      this.duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
    parentId = UInt64DTO.fromJson(parenId);
  }

  RegisterNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);

    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    namespaceType = json['namespaceType'];
    name = json['name'];
    parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    duration =
        json['duration'] != null ? UInt64DTO.fromJson(json['duration']) : null;
  }

  UInt64DTO? namespaceId;
  int? namespaceType;
  String? name;
  UInt64DTO? duration;
  UInt64DTO? parentId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['namespaceId'] = namespaceId;
    data['namespaceType'] = namespaceType;
    data['name'] = name;
    data['duration'] = duration;
    return data;
  }
}
