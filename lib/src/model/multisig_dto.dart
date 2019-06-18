part of xpx_chain_sdk;

class _MultisigDTO {
  _MultisigDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    account = json['account'] as String;
    accountAddress = json['accountAddress'] as String;
    minApproval = json['minApproval'] as int;
    minRemoval = json['minRemoval'] as int;
    cosignatories = (json['cosignatories'] as List)
        .map((dynamic item) => item as String)
        .toList();
    multisigAccounts = (json['multisigAccounts'] as List)
        .map((dynamic item) => item as String)
        .toList();
  }
  String account;

  String accountAddress;

  int minApproval;

  int minRemoval;

  List<String> cosignatories = [];

  List<String> multisigAccounts = [];

  static List<_MultisigDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_MultisigDTO>()
        : json
            .map((dynamic value) =>
                new _MultisigDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MultisigDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _MultisigDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _MultisigDTO.fromJson(value));
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
    multisigEntries = _MultisigAccountInfoDTO.listFromJson(
        json['multisigEntries'] as List<dynamic>);
  }

  int level;

  List<_MultisigAccountInfoDTO> multisigEntries = [];

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

class _MultisigAccountInfoDTO {
  _MultisigAccountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    multisig =
        new _MultisigDTO.fromJson(json['multisig'] as Map<String, dynamic>);
  }

  _MultisigDTO multisig;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['multisig'] = multisig;
    return data;
  }

  static List<_MultisigAccountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_MultisigAccountInfoDTO>()
        : json
            .map((dynamic value) => new _MultisigAccountInfoDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MultisigAccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _MultisigAccountInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _MultisigAccountInfoDTO.fromJson(value));
    }
    return map;
  }
}
