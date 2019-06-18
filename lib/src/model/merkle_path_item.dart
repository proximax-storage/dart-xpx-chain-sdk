part of xpx_chain_sdk;

class MerklePathItem {
  MerklePathItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    position = json['position'] as int;
    hash = json['hash'] as String;
  }

  int position;

  String hash;

  @override
  String toString() {
    return 'MerklePathItem[position=$position, hash=$hash, ]';
  }

  static List<MerklePathItem> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MerklePathItem>()
        : json
            .map((dynamic value) =>
                new MerklePathItem.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, MerklePathItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MerklePathItem>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MerklePathItem.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = position;
    data['hash'] = hash;

    return data;
  }
}
