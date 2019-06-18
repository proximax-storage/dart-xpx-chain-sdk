part of xpx_chain_sdk;

class MerkleProofInfoPayload {
  MerkleProofInfoPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    merklePath =
        MerklePathItem.listFromJson(json['merklePath'] as List<dynamic>);
  }

  List<MerklePathItem> merklePath = [];

  @override
  String toString() {
    return 'merklePath: $merklePath';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merklePath'] = merklePath;
    return data;
  }

  static List<MerkleProofInfoPayload> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MerkleProofInfoPayload>()
        : json
            .map((dynamic value) => new MerkleProofInfoPayload.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, MerkleProofInfoPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MerkleProofInfoPayload>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MerkleProofInfoPayload.fromJson(value));
    }
    return map;
  }
}
