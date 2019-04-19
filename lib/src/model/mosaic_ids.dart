part of nem2_sdk_dart;

class MosaicIds {
  
  List<String> mosaicIds = [];
  
  MosaicIds();

  @override
  String toString() {
    return 'MosaicIds[mosaicIds=$mosaicIds, ]';
  }

  MosaicIds.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mosaicIds =
        (json['mosaicIds'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'mosaicIds': mosaicIds
     };
  }

  static List<MosaicIds> listFromJson(List<dynamic> json) {
    return json == null ? new List<MosaicIds>() : json.map((value) => new MosaicIds.fromJson(value)).toList();
  }

  static Map<String, MosaicIds> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicIds>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MosaicIds.fromJson(value));
    }
    return map;
  }
}

