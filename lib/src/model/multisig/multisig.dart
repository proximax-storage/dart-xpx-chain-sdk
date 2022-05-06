/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.multisig;

class Multisig {
  Multisig.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    accountAddress = Address.fromEncoded(json['accountAddress']);
    account = PublicAccount.fromPublicKey(
        json['account'], accountAddress!.networkType);
    minApproval = json['minApproval'];
    minRemoval = json['minRemoval'];
    cosignatories = List<String>.from(json['cosignatories']);
    multisigAccounts = List<String>.from(json['multisigAccounts']);
  }

  PublicAccount? account;

  Address? accountAddress;

  int? minApproval;

  int? minRemoval;

  List<String> cosignatories = [];

  List<String> multisigAccounts = [];

  @override
  String toString() {
    final sb = StringBuffer()
      ..write('{\n')
      ..writeln('\taccount: $account,')
      ..writeln('\tminApproval: $minApproval,')
      ..writeln('\tminRemoval: $minRemoval,')
      ..writeln('\tcosignatories: $cosignatories,')
      ..writeln('\tmultisigAccounts: $multisigAccounts')
      ..write('}\n');
    return sb.toString();
  }

  static List<Multisig> listFromJson(List<Map> json) =>
      json.isEmpty ? <Multisig>[] : json.map(Multisig.fromJson).toList();

  static Map<String, Multisig> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, Multisig>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = Multisig.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['account'] = account;
    data['accountAddress'] = accountAddress;
    data['minApproval'] = minApproval;
    data['minRemoval'] = minRemoval;
    data['cosignatories'] = cosignatories;
    data['multisigAccounts'] = multisigAccounts;

    return data;
  }
}
