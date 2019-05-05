part of xpx_catapult_sdk ;

class MultisigAccountInfoDTO {
  MultisigDTO multisig = null;

  MultisigAccountInfoDTO();

  @override
  String toString() {
    return 'MultisigAccountInfoDTO[multisig=$multisig, ]';
  }

  MultisigAccountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    multisig = new MultisigDTO.fromJson(json['multisig']);
  }

  Map<String, dynamic> toJson() {
    return {'multisig': multisig};
  }

  static List<MultisigAccountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigAccountInfoDTO>()
        : json
            .map((value) => new MultisigAccountInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, MultisigAccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigAccountInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigAccountInfoDTO.fromJson(value));
    }
    return map;
  }
}
