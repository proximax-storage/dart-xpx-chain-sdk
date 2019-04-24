part of nem2_sdk_dart;

class Addresses {
  List<String> addresses = [];

  Addresses();

  @override
  String toString() {
    return 'Addresses[addresses=$addresses, ]';
  }

  Addresses.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    addresses =
        (json['addresses'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'addresses': addresses};
  }

  static List<Addresses> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Addresses>()
        : json.map((value) => new Addresses.fromJson(value)).toList();
  }

  static Map<String, Addresses> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Addresses>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Addresses.fromJson(value));
    }
    return map;
  }
}
