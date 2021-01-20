part of xpx_chain_sdk.account;

class AccountDTO {
  AccountDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    address = json['address'];
    addressHeight = UInt64DTO.fromJson(json['addressHeight']);
    _publicKey = json['publicKey'];
    _publicKeyHeight = UInt64DTO.fromJson(json['publicKeyHeight']);
    _mosaics = MosaicDTO.listFromJson(json['mosaics']);
    _accountType = json['accountType'];
    _linkedAccountKey = json['linkedAccountKey'];
  }

  String address;

  UInt64DTO addressHeight;

  String _publicKey;

  UInt64DTO _publicKeyHeight;

  List<MosaicDTO> _mosaics = [];

  int _accountType;

  String _linkedAccountKey;

  Map<String, dynamic> toJson() => {
        'address': address,
        'addressHeight': addressHeight,
        'publicKey': _publicKey,
        'publicKeyHeight': _publicKeyHeight,
        'mosaics': _mosaics,
        'accountType': _accountType,
        'linkedAccountKey': _linkedAccountKey,
      };
}

class AccountInfoDTO {
  AccountInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _account = AccountDTO.fromJson(json['account']);
  }

  AccountDTO _account;

  Map<String, dynamic> toJson() => {'account': _account};
}

class AccountNamesDTO {
  AccountNamesDTO();

  AccountNamesDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'];
    _names = (json['names'] == null)
        ? null
        :
        // ignore: avoid_as
        (json['names'] as List).cast<String>();
  }

  /* The address of the account in hexadecimal. */
  String address;

  /* The mosaic linked namespace names. */
  List<String> _names;
}
