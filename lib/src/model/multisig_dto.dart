part of xpx_catapult_sdk;

class MultisigDTO {
  String account = null;

  String accountAddress = null;

  int minApproval = null;

  int minRemoval = null;

  List<String> cosignatories = [];

  List<String> multisigAccounts = [];

  MultisigDTO();

  @override
  String toString() {
    return 'MultisigDTO[account=$account, accountAddress=$accountAddress, minApproval=$minApproval, minRemoval=$minRemoval, cosignatories=$cosignatories, multisigAccounts=$multisigAccounts, ]';
  }

  MultisigDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    account = json['account'];
    accountAddress = json['accountAddress'];
    minApproval = json['minApproval'];
    minRemoval = json['minRemoval'];
    cosignatories =
        (json['cosignatories'] as List).map((item) => item as String).toList();
    multisigAccounts = (json['multisigAccounts'] as List)
        .map((item) => item as String)
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'accountAddress': accountAddress,
      'minApproval': minApproval,
      'minRemoval': minRemoval,
      'cosignatories': cosignatories,
      'multisigAccounts': multisigAccounts
    };
  }

  static List<MultisigDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigDTO>()
        : json.map((value) => new MultisigDTO.fromJson(value)).toList();
  }

  static Map<String, MultisigDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigDTO.fromJson(value));
    }
    return map;
  }
}

class MultisigAccountGraphInfoDTO {
  int level = null;

  List<MultisigAccountInfoDTO> multisigEntries = [];

  MultisigAccountGraphInfoDTO();

  @override
  String toString() {
    return 'MultisigAccountGraphInfoDTO[level=$level, multisigEntries=$multisigEntries, ]';
  }

  MultisigAccountGraphInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    level = json['level'];
    multisigEntries =
        MultisigAccountInfoDTO.listFromJson(json['multisigEntries']);
  }

  Map<String, dynamic> toJson() {
    return {'level': level, 'multisigEntries': multisigEntries};
  }

  static List<MultisigAccountGraphInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigAccountGraphInfoDTO>()
        : json
            .map((value) => new MultisigAccountGraphInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, MultisigAccountGraphInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigAccountGraphInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigAccountGraphInfoDTO.fromJson(value));
    }
    return map;
  }
}

class MultisigAccountInfoDTO {
  MultisigDTO multisig = null;

  MultisigAccountInfoDTO();

  @override
  String toString() {
    return 'MultisigAccountInfoDTO[multisig=$multisig, ]';
  }

  MultisigAccountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    multisig = new MultisigDTO.fromJson(json['multisig']);
  }

  Map<String, dynamic> toJson() {
    return {'multisig': multisig};
  }

  static List<MultisigAccountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigAccountInfoDTO>()
        : json
            .map((value) => new MultisigAccountInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, MultisigAccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigAccountInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigAccountInfoDTO.fromJson(value));
    }
    return map;
  }
}
