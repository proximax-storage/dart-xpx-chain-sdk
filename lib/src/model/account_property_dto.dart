part of xpx_chain_sdk;

class AccountPropertyDTO {
  AccountPropertyDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    propertyType = json['propertyType'] as int;
//    values =
//      Object.listFromJson(json['values'])
    ;
  }

  int propertyType;

  List<Object> values = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['propertyType'] = propertyType;
    data['values'] = values;

    return data;
  }

  static List<AccountPropertyDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<AccountPropertyDTO>()
        : json
            .map((dynamic value) =>
                 AccountPropertyDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, AccountPropertyDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, AccountPropertyDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  AccountPropertyDTO.fromJson(value));
    }
    return map;
  }
}
