part of xpx_chain_sdk.multisig;

class Multisig {
  Multisig.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    accountAddress = Address.fromEncoded(json['accountAddress']);
    account = PublicAccount.fromPublicKey(json['account'], accountAddress.networkType);
    minApproval = json['minApproval'];
    minRemoval = json['minRemoval'];
    cosignatories = List<String>.from(json['cosignatories']);
    multisigAccounts = List<String>.from(json['multisigAccounts']);
  }

  PublicAccount account;

  Address accountAddress;

  int minApproval;

  int minRemoval;

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

  static List<Multisig> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => Multisig.fromJson(value)).toList();

  static Map<String, Multisig> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, Multisig>{};
    if (json != null && json.isNotEmpty) {
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

class MultisigAccountGraphInfo {
  MultisigAccountGraphInfo.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    level = json['level'];
    multisigEntries = MultisigAccountInfo.listFromJson(json['multisigEntries']);
  }

  int level;

  List<MultisigAccountInfo> multisigEntries = [];

  @override
  String toString() => '{\n'
      '\tlevel: $level,\n'
      '\tmultisigEntries: $multisigEntries\n'
      '}\n';

  static List<MultisigAccountGraphInfo> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MultisigAccountGraphInfo.fromJson(value)).toList();

  static Map<String, MultisigAccountGraphInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MultisigAccountGraphInfo>{};
    if (json != null && json.isNotEmpty) {
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

class MultisigAccountInfo {
  MultisigAccountInfo.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    multisig = Multisig.fromJson(json['multisig']);
  }

  Multisig multisig;

  @override
  String toString() => '$multisig';

  static List<MultisigAccountInfo> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MultisigAccountInfo.fromJson(value)).toList();

  static Map<String, MultisigAccountInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MultisigAccountInfo>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MultisigAccountInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['multisig'] = multisig;
    return data;
  }
}
