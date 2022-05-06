/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.blockchain;

class MerkleProofInfoPayload {
  MerkleProofInfoPayload.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    merklePath = MerklePathItem.listFromJson(json['merklePath']);
  }

  List<MerklePathItem>? merklePath = [];

  @override
  String toString() => 'merklePath: $merklePath';

  Map<String, dynamic> toJson() => {'merklePath': merklePath};

  static List<MerkleProofInfoPayload> listFromJson(
          List<Map<String, dynamic>> json) =>
      json.isEmpty ? [] : json.map(MerkleProofInfoPayload.fromJson).toList();

  static Map<String, MerkleProofInfoPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, MerkleProofInfoPayload>{};
    if (json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = MerkleProofInfoPayload.fromJson(value));
    }
    return map;
  }
}
