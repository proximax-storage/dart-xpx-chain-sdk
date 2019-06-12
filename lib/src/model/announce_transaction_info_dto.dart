part of xpx_chain_sdk;

class AnnounceTransactionInfoDTO {
  String message = null;

  AnnounceTransactionInfoDTO();

  @override
  String toString() {
    return 'AnnounceTransactionInfoDTO[message=$message, ]';
  }

  AnnounceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  static List<AnnounceTransactionInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AnnounceTransactionInfoDTO>()
        : json
            .map((value) => new AnnounceTransactionInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, AnnounceTransactionInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AnnounceTransactionInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AnnounceTransactionInfoDTO.fromJson(value));
    }
    return map;
  }
}
