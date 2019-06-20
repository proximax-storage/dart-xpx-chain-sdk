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
        ?  List<MerklePathItem>()
        : json
            .map((dynamic value) =>
                 MerklePathItem.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, MerklePathItem> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, MerklePathItem>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  MerklePathItem.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['position'] = position;
    data['hash'] = hash;

    return data;
  }
}
