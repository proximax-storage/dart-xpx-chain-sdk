part of nem2_sdk_dart;

class AccountPropertiesInfoDTO {
  
  AccountPropertiesMetaDTO meta = null;
  

  AccountPropertiesDTO accountProperties = null;
  
  AccountPropertiesInfoDTO();

  @override
  String toString() {
    return 'AccountPropertiesInfoDTO[meta=$meta, accountProperties=$accountProperties, ]';
  }

  AccountPropertiesInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta =
      
      
      new AccountPropertiesMetaDTO.fromJson(json['meta'])
;
    accountProperties =
      
      
      new AccountPropertiesDTO.fromJson(json['accountProperties'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta,
      'accountProperties': accountProperties
     };
  }

  static List<AccountPropertiesInfoDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<AccountPropertiesInfoDTO>() : json.map((value) => new AccountPropertiesInfoDTO.fromJson(value)).toList();
  }

  static Map<String, AccountPropertiesInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountPropertiesInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AccountPropertiesInfoDTO.fromJson(value));
    }
    return map;
  }
}

