/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MosaicDTO {
  MosaicDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    id = UInt64DTO.fromJson(json['id']);
    amount = UInt64DTO.fromJson(json['amount']);
  }

  UInt64DTO? id;

  UInt64DTO? amount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;

    return data;
  }

  static List<MosaicDTO> listFromJson(List<Map> json) =>
      json.isEmpty ? <MosaicDTO>[] : json.map(MosaicDTO.fromJson).toList();
}

class MosaicInfoDTO {
  MosaicInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    meta = MosaicMetaDTO.fromJson(json['meta']);
    mosaic = MosaicDefinitionDTO.fromJson(json['mosaic']);
  }

  MosaicMetaDTO? meta;

  MosaicDefinitionDTO? mosaic;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['mosaic'] = mosaic;

    return data;
  }
}

class MosaicMetaDTO {
  MosaicMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    id = json['id'];
  }

  String? id;

  Map<String, dynamic> toJson() => {'id': id};
}

class MosaicDefinitionDTO {
  MosaicDefinitionDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    supply = UInt64DTO.fromJson(json['supply']);
    height = UInt64DTO.fromJson(json['height']);
    owner = json['owner'];
    revision = json['revision'];

    if (json['properties'] != null) {
      properties = [];
      for (int i = 0; i < 3; i++) {
        properties.add(MosaicPropertyDTO.fromJson(json['properties'][i]));
      }
    }
  }

  late UInt64DTO mosaicId;
  late UInt64DTO supply;
  late UInt64DTO height;
  String? owner;
  int? revision;
  late List<MosaicPropertyDTO> properties;
}

class MosaicNameDTO {
  MosaicNameDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    names = List.from(json['names']);
  }

  UInt64DTO? parentId;

  UInt64DTO? mosaicId;

  List<String>? names;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['mosaicId'] = mosaicId;
    data['names'] = names;

    return data;
  }
}

class MosaicPropertyDTO {
  MosaicPropertyDTO.fromJson(Map json) {
    id = json['id'];
    value = UInt64DTO.fromJson(json['value']);
  }

  int? id;
  UInt64DTO? value;

  static List<MosaicPropertyDTO> listFromJson(List<Map> json) => json.isEmpty
      ? <MosaicPropertyDTO>[]
      : json.map(MosaicPropertyDTO.fromJson).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;

    return data;
  }
}

class MosaicDefinitionTransactionInfoDTO {
  MosaicDefinitionTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta =
        json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null
        ? MosaicDefinitionTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  MetaTransactionDTO? meta;
  MosaicDefinitionTransactionDTO? transaction;

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

class MosaicDefinitionTransactionDTO extends AbstractTransactionDTO {
  MosaicDefinitionTransactionDTO(
      {String? signature,
      String? signer,
      int? version,
      int? type,
      List<int>? maxFee,
      List<int>? deadline,
      this.mosaicId,
      this.mosaicNonce,
      this.properties,
      this.duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  MosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    mosaicNonce = json['mosaicNonce'];
    properties = MosaicPropertyDTO.listFromJson(json['properties'].cast<Map>());
    duration = UInt64DTO.fromJson(json['duration']);
  }

  UInt64DTO? mosaicId;
  int? mosaicNonce;
  List<MosaicPropertyDTO>? properties;
  UInt64DTO? duration;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['duration'] = duration;
    return data;
  }
}

class MosaicSupplyChangeTransactionInfoDTO {
  MosaicSupplyChangeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta =
        json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null
        ? _MosaicSupplyChangeTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  MetaTransactionDTO? meta;
  _MosaicSupplyChangeTransactionDTO? transaction;

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

class _MosaicSupplyChangeTransactionDTO extends AbstractTransactionDTO {
  _MosaicSupplyChangeTransactionDTO(
      {String? signature,
      String? signer,
      int? version,
      int? type,
      List<int>? maxFee,
      List<int>? deadline,
      this.mosaicId,
      this.direction,
      this.delta}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  _MosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    direction = json['direction'];
    delta = UInt64DTO.fromJson(json['delta']);
  }

  UInt64DTO? mosaicId;
  int? direction;
  UInt64DTO? delta;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['mosaicId'] = mosaicId;
    data['direction'] = direction;
    data['delta'] = delta;
    return data;
  }
}

class MosaicAliasTransactionInfoDTO {
  MosaicAliasTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta =
        json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null
        ? MosaicAliasDTO.fromJson(json['transaction'])
        : null;
  }

  MetaTransactionDTO? meta;
  MosaicAliasDTO? transaction;

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

class MosaicAliasDTO extends AbstractTransactionDTO {
  MosaicAliasDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    deadline = UInt64DTO.fromJson(json['deadline']);
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    aliasAction = json['aliasAction'];
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
  }

  int? aliasAction;
  UInt64DTO? mosaicId;
  UInt64DTO? namespaceId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = aliasAction;
    data['mosaicId'] = mosaicId;
    data['namespaceId'] = namespaceId;
    return data;
  }
}
