part of nem2_sdk_dart;

class MultisigAccountGraphInfoDTO {
  int level = null;

  List<MultisigAccountInfoDTO> multisigEntries = [];

  MultisigAccountGraphInfoDTO();

  @override
  String toString() {
    return 'MultisigAccountGraphInfoDTO[level=$level, multisigEntries=$multisigEntries, ]';
  }

  MultisigAccountGraphInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    level = json['level'];
    multisigEntries =
        MultisigAccountInfoDTO.listFromJson(json['multisigEntries']);
  }

  Map<String, dynamic> toJson() {
    return {'level': level, 'multisigEntries': multisigEntries};
  }

  static List<MultisigAccountGraphInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MultisigAccountGraphInfoDTO>()
        : json
            .map((value) => new MultisigAccountGraphInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, MultisigAccountGraphInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigAccountGraphInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MultisigAccountGraphInfoDTO.fromJson(value));
    }
    return map;
  }
}
