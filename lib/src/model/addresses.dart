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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['addresses'] = addresses;
    return data;
  }

  static List<Addresses> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<Addresses>()
        : json
            .map((dynamic value) =>
                 Addresses.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, Addresses> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, Addresses>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  Addresses.fromJson(value));
    }
    return map;
  }
}
