part of xpx_chain_sdk;

class Multisig {
  Multisig.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    accountAddress = new Address.fromEncoded(json['accountAddress'] as String);
    account = new PublicAccount.fromPublicKey(
        json['account'] as String, accountAddress._networkType);
    minApproval = json['minApproval'] as int;
    minRemoval = json['minRemoval'] as int;
    cosignatories = (json['cosignatories'] as List)
        .map((dynamic item) => item as String)
        .toList();
    multisigAccounts = (json['multisigAccounts'] as List)
        .map((dynamic item) => item as String)
        .toList();
  }

  PublicAccount account;

  Address accountAddress;

  int minApproval;

  int minRemoval;

  List<String> cosignatories = [];

  List<String> multisigAccounts = [];

  @override
  String toString() {
    return '{\n'
        '\taccount: $account,\n'
        '\tminApproval: $minApproval,\n'
        '\tminRemoval: $minRemoval,\n'
        '\tcosignatories: $cosignatories,\n'
        '\tmultisigAccounts: $multisigAccounts\n'
        '}\n';
  }

  static List<Multisig> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Multisig>()
        : json
            .map((dynamic value) =>
                new Multisig.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, Multisig> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Multisig>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Multisig.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = account;
    data['accountAddress'] = accountAddress;
    data['minApproval'] = minApproval;
    data['minRemoval'] = minRemoval;
    data['cosignatories'] = cosignatories;
    data['multisigAccounts'] = multisigAccounts;

    return data;
  }
}

class _MultisigAccountGraphInfoDTO {
  _MultisigAccountGraphInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    level = json['level'] as int;
    multisigEntries = MultisigAccountInfo.listFromJson(
        json['multisigEntries'] as List<dynamic>);
  }

  int level;

  List<MultisigAccountInfo> multisigEntries = [];

  static List<_MultisigAccountGraphInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_MultisigAccountGraphInfoDTO>()
        : json
            .map((dynamic value) => new _MultisigAccountGraphInfoDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MultisigAccountGraphInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _MultisigAccountGraphInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _MultisigAccountGraphInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = level;
    data['multisigEntries'] = multisigEntries;

    return data;
  }
}

class MultisigAccountInfo {
  MultisigAccountInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    multisig = new Multisig.fromJson(json['multisig'] as Map<String, dynamic>);
  }

  Multisig multisig;

  @override
  String toString() {
    return '${toJson()}';
  }

  static List<MultisigAccountInfo> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigAccountInfo>()
        : json
            .map((dynamic value) =>
                new MultisigAccountInfo.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, MultisigAccountInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigAccountInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigAccountInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['multisig'] = multisig;
    return data;
  }
}
