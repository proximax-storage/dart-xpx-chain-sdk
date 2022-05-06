/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.multisig;

class MultisigAccountInfo {
  MultisigAccountInfo.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    multisig = Multisig.fromJson(json['multisig']);
  }

  Multisig? multisig;

  @override
  String toString() => encoder.convert(this);

  static List<MultisigAccountInfo> listFromJson(List<Map> json) => json.isEmpty
      ? <MultisigAccountInfo>[]
      : json.map(MultisigAccountInfo.fromJson).toList();

  static Map<String, MultisigAccountInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, MultisigAccountInfo>{};
    if (json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = MultisigAccountInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['multisig'] = multisig;
    return data;
  }
}
