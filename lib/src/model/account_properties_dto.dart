part of xpx_catapult_sdk ;

class AccountPropertiesDTO {
  String address = null;

  List<AccountPropertyDTO> properties = [];

  AccountPropertiesDTO();

  @override
  String toString() {
    return 'AccountPropertiesDTO[address=$address, properties=$properties, ]';
  }

  AccountPropertiesDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'];
    properties = AccountPropertyDTO.listFromJson(json['properties']);
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'properties': properties};
  }

  static List<AccountPropertiesDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountPropertiesDTO>()
        : json
            .map((value) => new AccountPropertiesDTO.fromJson(value))
            .toList();
  }

  static Map<String, AccountPropertiesDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountPropertiesDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountPropertiesDTO.fromJson(value));
    }
    return map;
  }
}
