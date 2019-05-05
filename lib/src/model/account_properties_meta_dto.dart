part of xpx_catapult_sdk ;

class AccountPropertiesMetaDTO {
  String id = null;

  AccountPropertiesMetaDTO();

  @override
  String toString() {
    return 'AccountPropertiesMetaDTO[id=$id, ]';
  }

  AccountPropertiesMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  static List<AccountPropertiesMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountPropertiesMetaDTO>()
        : json
            .map((value) => new AccountPropertiesMetaDTO.fromJson(value))
            .toList();
  }

  static Map<String, AccountPropertiesMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountPropertiesMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountPropertiesMetaDTO.fromJson(value));
    }
    return map;
  }
}
