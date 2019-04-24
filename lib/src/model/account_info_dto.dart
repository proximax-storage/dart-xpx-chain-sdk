part of nem2_sdk_dart;

class AccountInfoDTO {
  AccountMetaDTO meta = null;

  AccountDTO account = null;

  AccountInfoDTO();

  @override
  String toString() {
    return 'AccountInfoDTO[meta=$meta, account=$account, ]';
  }

  AccountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new AccountMetaDTO.fromJson(json['meta']);
    account = new AccountDTO.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'account': account};
  }

  static List<AccountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountInfoDTO>()
        : json.map((value) => new AccountInfoDTO.fromJson(value)).toList();
  }

  static Map<String, AccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountInfoDTO.fromJson(value));
    }
    return map;
  }
}
