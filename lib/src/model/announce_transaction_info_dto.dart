part of xpx_chain_sdk;

class AnnounceTransactionInfoDTO {
  AnnounceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    message = json['message'] as String;
  }

  String message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;

    return data;
  }

  static List<AnnounceTransactionInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AnnounceTransactionInfoDTO>()
        : json
            .map((dynamic value) => new AnnounceTransactionInfoDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, AnnounceTransactionInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AnnounceTransactionInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AnnounceTransactionInfoDTO.fromJson(value));
    }
    return map;
  }
}
