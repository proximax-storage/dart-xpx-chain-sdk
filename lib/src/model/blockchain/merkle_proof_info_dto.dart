part of xpx_chain_sdk.blockchain;

class MerkleProofInfoDTO {
  MerkleProofInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _payload = MerkleProofInfoPayload.fromJson(json['payload']);
    type = json['type'];
  }

  MerkleProofInfoPayload _payload;

  String type;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['payload'] = _payload;
    data['type'] = type;

    return data;
  }

  static List<MerkleProofInfoDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MerkleProofInfoDTO.fromJson(value)).toList();

  static Map<String, MerkleProofInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MerkleProofInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MerkleProofInfoDTO.fromJson(value));
    }
    return map;
  }
}
