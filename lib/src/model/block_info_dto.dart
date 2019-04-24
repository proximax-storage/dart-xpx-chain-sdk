part of nem2_sdk_dart;

class BlockInfoDTO {
  BlockMetaDTO meta = null;

  BlockDTO block = null;

  BlockInfoDTO();

  @override
  String toString() {
    return 'BlockInfoDTO[meta=$meta, block=$block, ]';
  }

  BlockInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new BlockMetaDTO.fromJson(json['meta']);
    block = new BlockDTO.fromJson(json['block']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'block': block};
  }

  static List<BlockInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<BlockInfoDTO>()
        : json.map((value) => new BlockInfoDTO.fromJson(value)).toList();
  }

  static Map<String, BlockInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BlockInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new BlockInfoDTO.fromJson(value));
    }
    return map;
  }
}
