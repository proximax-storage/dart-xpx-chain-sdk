part of nem2_sdk_dart;

class MultisigDTO {
  
  String account = null;
  

  String accountAddress = null;
  

  int minApproval = null;
  

  int minRemoval = null;
  

  List<String> cosignatories = [];
  

  List<String> multisigAccounts = [];
  
  MultisigDTO();

  @override
  String toString() {
    return 'MultisigDTO[account=$account, accountAddress=$accountAddress, minApproval=$minApproval, minRemoval=$minRemoval, cosignatories=$cosignatories, multisigAccounts=$multisigAccounts, ]';
  }

  MultisigDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    account =
        json['account']
    ;
    accountAddress =
        json['accountAddress']
    ;
    minApproval =
        json['minApproval']
    ;
    minRemoval =
        json['minRemoval']
    ;
    cosignatories =
        (json['cosignatories'] as List).map((item) => item as String).toList()
    ;
    multisigAccounts =
        (json['multisigAccounts'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'accountAddress': accountAddress,
      'minApproval': minApproval,
      'minRemoval': minRemoval,
      'cosignatories': cosignatories,
      'multisigAccounts': multisigAccounts
     };
  }

  static List<MultisigDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<MultisigDTO>() : json.map((value) => new MultisigDTO.fromJson(value)).toList();
  }

  static Map<String, MultisigDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MultisigDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MultisigDTO.fromJson(value));
    }
    return map;
  }
}

