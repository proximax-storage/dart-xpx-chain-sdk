/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MerkleProofInfoDTO {
  MerkleProofInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    payload = MerkleProofInfoPayload.fromJson(json['payload']);
    type = json['type'];
  }

  MerkleProofInfoPayload? payload;

  String? type;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['payload'] = payload;
    data['type'] = type;

    return data;
  }

  static List<MerkleProofInfoDTO> listFromJson(
          List<Map<String, dynamic>> json) =>
      json.isEmpty ? [] : json.map(MerkleProofInfoDTO.fromJson).toList();

  static Map<String, MerkleProofInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, MerkleProofInfoDTO>{};
    if (json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = MerkleProofInfoDTO.fromJson(value));
    }
    return map;
  }
}
