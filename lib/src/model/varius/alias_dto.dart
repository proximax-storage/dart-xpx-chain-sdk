part of xpx_chain_sdk;

class _AddressAliasDTO extends _AbstractTransactionDTO {
  _AddressAliasDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _aliasAction = json['aliasAction'];
    _address = json['address'];
    _namespaceId = UInt64DTO.fromJson(json['namespaceId']);
  }

  int _aliasAction;
  String _address;
  UInt64DTO _namespaceId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = _aliasAction;
    data['address'] = _address;
    data['namespaceId'] = _namespaceId;
    return data;
  }

  static List<_AddressAliasDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _AddressAliasDTO.fromJson(value)).toList();

  static Map<String, _AddressAliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _AddressAliasDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _AddressAliasDTO.fromJson(value));
    }
    return map;
  }
}
