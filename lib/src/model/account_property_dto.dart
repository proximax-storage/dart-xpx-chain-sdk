part of xpx_chain_sdk;

class AccountPropertyDTO {
  int propertyType = null;

  List<Object> values = [];

  AccountPropertyDTO();

  @override
  String toString() {
    return 'AccountPropertyDTO[propertyType=$propertyType, values=$values, ]';
  }

  AccountPropertyDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    propertyType = json['propertyType'];
//    values =
//      Object.listFromJson(json['values'])
    ;
  }

  Map<String, dynamic> toJson() {
    return {'propertyType': propertyType, 'values': values};
  }

  static List<AccountPropertyDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountPropertyDTO>()
        : json.map((value) => new AccountPropertyDTO.fromJson(value)).toList();
  }

  static Map<String, AccountPropertyDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountPropertyDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountPropertyDTO.fromJson(value));
    }
    return map;
  }
}
