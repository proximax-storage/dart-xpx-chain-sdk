part of xpx_chain_sdk;

class _AccountPropertiesMetaDTO {
  _AccountPropertiesMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'] as String;
  }

  String id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;

    return data;
  }

  static List<_AccountPropertiesMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_AccountPropertiesMetaDTO>()
        : json
            .map((dynamic value) =>  _AccountPropertiesMetaDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountPropertiesMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _AccountPropertiesMetaDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _AccountPropertiesMetaDTO.fromJson(value));
    }
    return map;
  }
}
