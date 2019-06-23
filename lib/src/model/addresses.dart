part of xpx_chain_sdk;

class Addresses {
  Addresses();

  Addresses.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    addresses = (json['addresses']).map((item) => item).toList();
  }

  Addresses.fromList(List<String> list)
      : assert(json != null, 'json must not be null') {
    addresses = list.map((item) => item).toList();
  }

  List<String> addresses = [];

  @override
  String toString() => 'addresses: $addresses';

  Map<String, dynamic> toJson() => {'addresses': addresses};

  static List<Addresses> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => Addresses.fromJson(value)).toList();

  static Map<String, Addresses> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = Addresses.fromJson(value));
    }
    return map;
  }
}
