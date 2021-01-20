part of xpx_chain_sdk.blockchain;

class MerklePathItem {
  MerklePathItem.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    position = json['position'];
    hash = json['hash'];
  }

  int position;

  String hash;

  @override
  String toString() => 'MerklePathItem[position=$position, hash=$hash, ]';

  static List<MerklePathItem> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MerklePathItem.fromJson(value)).toList();

  static Map<String, MerklePathItem> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, MerklePathItem>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = MerklePathItem.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['position'] = position;
    data['hash'] = hash;

    return data;
  }
}
