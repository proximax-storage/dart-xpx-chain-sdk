/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class AnnounceTransactionInfoDTO {
  AnnounceTransactionInfoDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() => {'message': message};

  static List<AnnounceTransactionInfoDTO> listFromJson(List<Map> json) =>
      json.isEmpty
          ? <AnnounceTransactionInfoDTO>[]
          : json.map(AnnounceTransactionInfoDTO.fromJson).toList();

  static Map<String, AnnounceTransactionInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AnnounceTransactionInfoDTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) =>
          map[key] = AnnounceTransactionInfoDTO.fromJson(value));
    }
    return map;
  }
}
