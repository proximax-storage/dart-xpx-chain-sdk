part of xpx_chain_sdk.transaction;

class TransactionStatus {
  TransactionStatus.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    group = json['group'];
    status = json['status'];
    hash = json['hash'];
    deadline = Deadline.fromUInt64DTO(UInt64DTO.fromJson(json['deadline']));
    height = UInt64DTO.fromJson(json['height']).toUint64();
  }

  String group;

  String status;

  String hash;

  Deadline deadline;

  Uint64 height;

  @override
  String toString() => '{\n'
      '\tgroup: $group,\n'
      '\tstatus: $status,\n'
      '\thash: $hash,\n'
      '\tdeadline: $deadline,\n'
      '\theight: $height\n'
      '}\n';

  static List<TransactionStatus> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => TransactionStatus.fromJson(value)).toList();

  static Map<String, TransactionStatus> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionStatus>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = TransactionStatus.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['group'] = group;
    data['status'] = status;
    data['hash'] = hash;
    data['deadline'] = deadline;
    data['height'] = height;

    return data;
  }
}
