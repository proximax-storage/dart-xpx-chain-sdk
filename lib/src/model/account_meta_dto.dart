part of nem2_sdk_dart;

class AccountMetaDTO {
  AccountMetaDTO();

  @override
  String toString() {
    return 'AccountMetaDTO[]';
  }

  AccountMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<AccountMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountMetaDTO>()
        : json.map((value) => new AccountMetaDTO.fromJson(value)).toList();
  }

  static Map<String, AccountMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountMetaDTO.fromJson(value));
    }
    return map;
  }
}
