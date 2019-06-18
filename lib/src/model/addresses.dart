part of xpx_chain_sdk;

class Addresses {
  Addresses();

  Addresses.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    addresses = (json['addresses'] as List)
        .map((dynamic item) => item as String)
        .toList();
  }

  List<String> addresses = [];

  @override
  String toString() {
    return 'addresses:$addresses';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addresses'] = addresses;
    return data;
  }

  static List<Addresses> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Addresses>()
        : json
            .map((dynamic value) =>
                new Addresses.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, Addresses> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Addresses>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Addresses.fromJson(value));
    }
    return map;
  }
}
