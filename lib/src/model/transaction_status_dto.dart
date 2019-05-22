part of xpx_catapult_sdk;

class TransactionStatusDTO {
  String group;

  String status;

  String hash;

  UInt64DTO deadline;

  UInt64DTO height;

  TransactionStatusDTO();

  @override
  String toString() {
    return 'TransactionStatusDTO[group=$group, status=$status, hash=$hash, deadline=$deadline, height=$height, ]';
  }

  TransactionStatusDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    group = json['group'];
    status = json['status'];
    hash = json['hash'];
    deadline = new UInt64DTO.fromJson(json['deadline']);
    height = new UInt64DTO.fromJson(json['height']);
  }

  Map<String, dynamic> toJson() {
    return {
      'group': group,
      'status': status,
      'hash': hash,
      'deadline': deadline,
      'height': height
    };
  }

  static List<TransactionStatusDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TransactionStatusDTO>()
        : json
            .map((value) => new TransactionStatusDTO.fromJson(value))
            .toList();
  }

  static Map<String, TransactionStatusDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TransactionStatusDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TransactionStatusDTO.fromJson(value));
    }
    return map;
  }
}
