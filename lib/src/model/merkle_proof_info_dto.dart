part of xpx_chain_sdk;

class _MerkleProofInfoDTO {
  _MerkleProofInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    payload = new MerkleProofInfoPayload.fromJson(
        json['payload'] as Map<String, dynamic>);
    type = json['type'] as String;
  }

  MerkleProofInfoPayload payload;

  String type;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payload'] = payload;
    data['type'] = type;

    return data;
  }

  static List<_MerkleProofInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_MerkleProofInfoDTO>()
        : json
            .map((dynamic value) =>
                new _MerkleProofInfoDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MerkleProofInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _MerkleProofInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _MerkleProofInfoDTO.fromJson(value));
    }
    return map;
  }
}
