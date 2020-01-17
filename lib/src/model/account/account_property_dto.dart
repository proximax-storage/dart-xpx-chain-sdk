part of xpx_chain_sdk.account;

class AccountPropertyDTO {
  AccountPropertyDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _propertyType = json['propertyType'];
    _values = json['values'];
  }

  int _propertyType;

  List<Object> _values = [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['propertyType'] = _propertyType;
    data['values'] = _values;

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
