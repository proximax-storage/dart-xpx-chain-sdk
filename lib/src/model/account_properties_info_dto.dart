part of xpx_chain_sdk;

class _AccountPropertiesInfoDTO {
  _AccountPropertiesInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta =  _AccountPropertiesMetaDTO.fromJson(
        json['meta'] as Map<String, dynamic>);
    accountProperties =  _AccountPropertiesDTO.fromJson(
        json['accountProperties'] as Map<String, dynamic>);
  }

  _AccountPropertiesMetaDTO meta;

  _AccountPropertiesDTO accountProperties;

  static List<_AccountPropertiesInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_AccountPropertiesInfoDTO>()
        : json
            .map((dynamic value) =>  _AccountPropertiesInfoDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountPropertiesInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _AccountPropertiesInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _AccountPropertiesInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['meta'] = meta;
    data['accountProperties'] = accountProperties;

    return data;
  }
}
