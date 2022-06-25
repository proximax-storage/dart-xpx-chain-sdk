/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.multisig;

class MultisigAccountGraphInfo {
  MultisigAccountGraphInfo.fromJson(Map json) : assert(json.isNotEmpty, 'json must not be empty') {
    level = json['level'];
    multisigEntries = MultisigAccountInfo.listFromJson(json['multisigEntries'].cast<Map>());
  }

  int? level;

  List<MultisigAccountInfo>? multisigEntries = [];

  @override
  String toString() => encoder.convert(this);

  static List<MultisigAccountGraphInfo> listFromJson(List<Map> json) =>
      json.isEmpty ? <MultisigAccountGraphInfo>[] : json.map(MultisigAccountGraphInfo.fromJson).toList();

  static Map<String, MultisigAccountGraphInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MultisigAccountGraphInfo>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MultisigAccountGraphInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['level'] = level;
    data['multisigEntries'] = multisigEntries;

    return data;
  }
}
