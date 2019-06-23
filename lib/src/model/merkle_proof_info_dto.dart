part of xpx_chain_sdk;

class _MerkleProofInfoDTO {
  _MerkleProofInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    payload = MerkleProofInfoPayload.fromJson(json['payload']);
    type = json['type'];
  }

  MerkleProofInfoPayload payload;

  String type;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['payload'] = payload;
    data['type'] = type;

    return data;
  }

  static List<_MerkleProofInfoDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _MerkleProofInfoDTO.fromJson(value)).toList();

  static Map<String, _MerkleProofInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _MerkleProofInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _MerkleProofInfoDTO.fromJson(value));
    }
    return map;
  }
}
