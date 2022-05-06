/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.blockchain;

class MerklePathItem {
  MerklePathItem.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    position = json['position'];
    hash = json['hash'];
  }

  int? position;

  String? hash;

  @override
  String toString() => 'MerklePathItem[position=$position, hash=$hash, ]';

  static List<MerklePathItem> listFromJson(List<Map<String, dynamic>>? json) =>
      json == null ? [] : json.map(MerklePathItem.fromJson).toList();

  static Map<String, MerklePathItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, MerklePathItem>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MerklePathItem.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['position'] = position;
    data['hash'] = hash;

    return data;
  }
}
