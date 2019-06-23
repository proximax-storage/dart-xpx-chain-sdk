part of xpx_chain_sdk;

class AccountPropertyDTO {
  AccountPropertyDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    propertyType = json['propertyType'];
    values = json['values'];
  }

  int propertyType;

  List<Object> values = [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['propertyType'] = propertyType;
    data['values'] = values;

    return data;
  }

  static List<AccountPropertyDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => AccountPropertyDTO.fromJson(value)).toList();

  static Map<String, AccountPropertyDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AccountPropertyDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = AccountPropertyDTO.fromJson(value));
    }
    return map;
  }
}
