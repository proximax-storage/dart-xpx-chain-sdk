part of xpx_chain_sdk;

class _TransactionStatusDTO {
  _TransactionStatusDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    group = json['group'] as String;
    status = json['status'] as String;
    hash = json['hash'] as String;
    deadline = new UInt64DTO.fromJson(json['deadline']);
    height = new UInt64DTO.fromJson(json['height']);
  }

  String group;

  String status;

  String hash;

  UInt64DTO deadline;

  UInt64DTO height;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['status'] = this.status;
    data['hash'] = this.hash;
    data['deadline'] = this.deadline;
    data['height'] = this.height;

    return data;
  }

  static List<_TransactionStatusDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_TransactionStatusDTO>()
        : json
            .map((dynamic value) => new _TransactionStatusDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _TransactionStatusDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _TransactionStatusDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _TransactionStatusDTO.fromJson(value));
    }
    return map;
  }
}
