part of xpx_chain_sdk.account;

class AccountPropertyDTO {
  AccountPropertyDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    propertyType = json['propertyType'];

    if (propertyType & 0x01 != 0) {
      addresses = List<String>.from(json['values']);
    } else if (propertyType & 0x02 != 0) {
      mosaicIds = UInt64DTO.listFromJson(json['values']);
    } else if (propertyType & 0x04 != 0) {
      entityTypes = List<int>.from(json['values']);
    } else {
      throw errUnknownPropertyType;
    }
  }

  int propertyType;
  List<String> addresses;
  List<UInt64DTO> mosaicIds;
  List<int> entityTypes;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['propertyType'] = propertyType;
    data['addresses'] = addresses;
    data['mosaicIds'] = mosaicIds;
    data['entityTypes'] = entityTypes;

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
