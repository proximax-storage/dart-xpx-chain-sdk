/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class TransactionStatus {
  TransactionStatus.fromJson(Map json) : assert(json.isNotEmpty, 'json must not be empty') {
    group = json['group'];
    status = json['status'];
    hash = json['hash'];
    deadline = Deadline.fromUInt64DTO(UInt64DTO.fromJson(json['deadline']));
    height = UInt64DTO.fromJson(json['height']).toUint64();
  }

  String? group;

  String? status;

  String? hash;

  Deadline? deadline;

  Uint64? height;

  @override
  String toString() => encoder.convert(this);

  static List<TransactionStatus> listFromJson(List<Map> json) =>
      json.isEmpty ? [] : json.map(TransactionStatus.fromJson).toList();

  static Map<String, TransactionStatus> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionStatus>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = TransactionStatus.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['group'] = group;
    data['status'] = status;
    data['hash'] = hash;
    data['deadline'] = deadline;
    data['height'] = height;

    return data;
  }
}
