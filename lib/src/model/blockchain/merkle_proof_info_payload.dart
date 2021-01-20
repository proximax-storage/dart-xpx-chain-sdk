part of xpx_chain_sdk.blockchain;

class MerkleProofInfoPayload {
  MerkleProofInfoPayload.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    merklePath = MerklePathItem.listFromJson(json['merklePath']);
  }

  List<MerklePathItem> merklePath = [];

  @override
  String toString() => 'merklePath: $merklePath';

  Map<String, dynamic> toJson() => {'merklePath': merklePath};

  static List<MerkleProofInfoPayload> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MerkleProofInfoPayload.fromJson(value)).toList();

  static Map<String, MerkleProofInfoPayload> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MerkleProofInfoPayload>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MerkleProofInfoPayload.fromJson(value));
    }
    return map;
  }
}
