part of xpx_catapult_sdk ;

class MerkleProofInfoDTO {
  MerkleProofInfoPayload payload = null;

  String type = null;

  MerkleProofInfoDTO();

  @override
  String toString() {
    return 'MerkleProofInfoDTO[payload=$payload, type=$type, ]';
  }

  MerkleProofInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    payload = new MerkleProofInfoPayload.fromJson(json['payload']);
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {'payload': payload, 'type': type};
  }

  static List<MerkleProofInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MerkleProofInfoDTO>()
        : json.map((value) => new MerkleProofInfoDTO.fromJson(value)).toList();
  }

  static Map<String, MerkleProofInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MerkleProofInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MerkleProofInfoDTO.fromJson(value));
    }
    return map;
  }
}
