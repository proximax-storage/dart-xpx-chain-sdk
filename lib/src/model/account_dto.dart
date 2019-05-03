part of nem2_sdk_dart;

class AccountDTO {
  String address = null;

  UInt64DTO addressHeight = null;

  String publicKey = null;

  UInt64DTO publicKeyHeight = null;

  List<MosaicDTO> mosaics = [];

  UInt64DTO importance = null;

  UInt64DTO importanceHeight = null;

  AccountDTO();

  @override
  String toString() {
    return 'AccountDTO[address=$address, addressHeight=$addressHeight, publicKey=$publicKey, publicKeyHeight=$publicKeyHeight, mosaics=$mosaics, importance=$importance, importanceHeight=$importanceHeight, ]';
  }

  AccountDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'];
    addressHeight = new UInt64DTO.fromJson(json['addressHeight']);
    publicKey = json['publicKey'];
    publicKeyHeight = new UInt64DTO.fromJson(json['publicKeyHeight']);
    mosaics = MosaicDTO.listFromJson(json['mosaics']);
    importance = new UInt64DTO.fromJson(json['importance']);
    importanceHeight = new UInt64DTO.fromJson(json['importanceHeight']);
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'addressHeight': addressHeight,
      'publicKey': publicKey,
      'publicKeyHeight': publicKeyHeight,
      'mosaics': mosaics,
      'importance': importance,
      'importanceHeight': importanceHeight
    };
  }

  static List<AccountDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AccountDTO>()
        : json.map((value) => new AccountDTO.fromJson(value)).toList();
  }

  static Map<String, AccountDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AccountDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AccountDTO.fromJson(value));
    }
    return map;
  }
}
