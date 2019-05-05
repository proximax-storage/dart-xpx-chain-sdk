part of xpx_catapult_sdk ;

class MerkleProofInfoPayload {
  List<MerklePathItem> merklePath = [];

  MerkleProofInfoPayload();

  @override
  String toString() {
    return 'MerkleProofInfoPayload[merklePath=$merklePath, ]';
  }

  MerkleProofInfoPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    merklePath = MerklePathItem.listFromJson(json['merklePath']);
  }

  Map<String, dynamic> toJson() {
    return {'merklePath': merklePath};
  }

  static List<MerkleProofInfoPayload> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MerkleProofInfoPayload>()
        : json
            .map((value) => new MerkleProofInfoPayload.fromJson(value))
            .toList();
  }

  static Map<String, MerkleProofInfoPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MerkleProofInfoPayload>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MerkleProofInfoPayload.fromJson(value));
    }
    return map;
  }
}
