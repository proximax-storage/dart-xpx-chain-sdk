part of xpx_chain_sdk.transaction;

class AnnounceTransactionInfoDTO {
  AnnounceTransactionInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _message = json['message'];
  }

  String _message;

  Map<String, dynamic> toJson() => {'message': _message};

  static List<AnnounceTransactionInfoDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AnnounceTransactionInfoDTO.fromJson(value)).toList();

  static Map<String, AnnounceTransactionInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, AnnounceTransactionInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AnnounceTransactionInfoDTO.fromJson(value));
    }
    return map;
  }
}
