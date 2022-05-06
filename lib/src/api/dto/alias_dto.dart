/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class AddressAliasDTO extends AbstractTransactionDTO {
  AddressAliasDTO.fromJson(json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    deadline = UInt64DTO.fromJson(json['deadline']);
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    aliasAction = json['aliasAction'];
    address = json['address'];
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
  }

  int? aliasAction;
  String? address;
  UInt64DTO? namespaceId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = aliasAction;
    data['address'] = address;
    data['namespaceId'] = namespaceId;
    return data;
  }

  static List<AddressAliasDTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? [] : json.map(AddressAliasDTO.fromJson).toList();

  static Map<String, AddressAliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AddressAliasDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AddressAliasDTO.fromJson(value));
    }
    return map;
  }
}

class AddressAliasTransactionInfoDTO {
  AddressAliasTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta =
        json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null
        ? AddressAliasDTO.fromJson(json['transaction'])
        : null;
  }

  MetaTransactionDTO? meta;
  AddressAliasDTO? transaction;

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

class AliasDTO {
  AliasDTO.fromJson(json) : assert(json.isNotEmpty, 'json must not be empty') {
    aliasAction = json['aliasAction'];
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    address = json['address'];
  }

  int? aliasAction;
  UInt64DTO? mosaicId;
  String? address;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = aliasAction;
    data['mosaicId'] = mosaicId;
    data['address'] = address;

    return data;
  }

  static List<AliasDTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? [] : json.map(AliasDTO.fromJson).toList();

  static Map<String, AliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AliasDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AliasDTO.fromJson(value));
    }
    return map;
  }
}
