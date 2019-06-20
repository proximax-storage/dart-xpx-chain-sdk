part of xpx_chain_sdk;

class TransactionStatus {
  TransactionStatus.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    group = json['group'] as String;
    status = json['status'] as String;
    hash = json['hash'] as String;
    deadline =  Deadline.fromUInt64DTO(UInt64DTO.fromJson(json['deadline']));
    height =  UInt64DTO.fromJson(json['height']).toBigInt();
  }

  String group;

  String status;

  String hash;

  Deadline deadline;

  BigInt height;

  @override
  String toString() {
    return '{\n'
        '\tgroup: $group,\n'
        '\tstatus: $status,\n'
        '\thash: $hash,\n'
        '\tdeadline: $deadline,\n'
        '\theight: $height\n'
        '}\n';
  }

  static List<TransactionStatus> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<TransactionStatus>()
        : json
            .map((dynamic value) =>  TransactionStatus.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, TransactionStatus> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, TransactionStatus>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  TransactionStatus.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['group'] = this.group;
    data['status'] = this.status;
    data['hash'] = this.hash;
    data['deadline'] = this.deadline;
    data['height'] = this.height;

    return data;
  }
}
