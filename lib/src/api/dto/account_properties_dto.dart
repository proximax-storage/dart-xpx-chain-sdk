/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class AccountPropertiesDTO {
  AccountPropertiesDTO.fromJson(json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    final jsonRaw = json['accountProperties'];

    address = jsonRaw['address'];

    properties = AccountPropertyDTO.listFromJson(jsonRaw['properties']);
  }

  String? address;

  List<AccountPropertyDTO>? properties = [];

  static List<AccountPropertiesDTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? [] : json.map(AccountPropertiesDTO.fromJson).toList();

  static Map<String, AccountPropertiesDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesDTO> map = {};
    if (json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = AccountPropertiesDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'properties': properties};
}

class AccountPropertiesInfoDTO {
  AccountPropertiesInfoDTO.fromJson(json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    meta = AccountPropertiesMetaDTO.fromJson(json['meta']);
    _accountProperties =
        AccountPropertiesDTO.fromJson(json['accountProperties']);
  }

  AccountPropertiesMetaDTO? meta;

  AccountPropertiesDTO? _accountProperties;

  static List<AccountPropertiesInfoDTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? [] : json.map(AccountPropertiesInfoDTO.fromJson).toList();

  static Map<String, AccountPropertiesInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesInfoDTO> map = {};
    if (json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = AccountPropertiesInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() =>
      {'meta': meta, 'accountProperties': _accountProperties};
}

class AccountPropertiesMetaDTO {
  AccountPropertiesMetaDTO.fromJson(json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    _id = json['id'];
  }

  String? _id;

  Map<String, dynamic> toJson() => {'id': _id};

  static List<AccountPropertiesMetaDTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? [] : json.map(AccountPropertiesMetaDTO.fromJson).toList();

  static Map<String, AccountPropertiesMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesMetaDTO> map = {};
    if (json.isEmpty && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = AccountPropertiesMetaDTO.fromJson(value));
    }
    return map;
  }
}
