part of xpx_chain_sdk;

class _AccountDTO {
  _AccountDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _address = json['address'];
    _addressHeight = UInt64DTO.fromJson(json['addressHeight']);
    _publicKey = json['publicKey'];
    _publicKeyHeight = UInt64DTO.fromJson(json['publicKeyHeight']);
    _mosaics = _MosaicDTO.listFromJson(json['mosaics']);
    _accountType = json['accountType'];
    _linkedAccountKey = json['linkedAccountKey'];
  }

  String _address;

  UInt64DTO _addressHeight;

  String _publicKey;

  UInt64DTO _publicKeyHeight;

  List<_MosaicDTO> _mosaics = [];

  int _accountType;

  String _linkedAccountKey;

  Map<String, dynamic> toJson() => {
        'address': _address,
        'addressHeight': _addressHeight,
        'publicKey': _publicKey,
        'publicKeyHeight': _publicKeyHeight,
        'mosaics': _mosaics,
        'accountType': _accountType,
        'linkedAccountKey': _linkedAccountKey,
      };
}

class _AccountInfoDTO {
  _AccountInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _account = _AccountDTO.fromJson(json['account']);
  }

  _AccountDTO _account;

  Map<String, dynamic> toJson() => {'account': _account};
}

class _AccountNames {
  _AccountNames();

  _AccountNames.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    _address = json['address'];
    _names = (json['names'] == null) ?
    null :
    // ignore: avoid_as
    (json['names'] as List).cast<String>();
  }

  /* The address of the account in hexadecimal. */
  String _address;
  /* The mosaic linked namespace names. */
  List<String> _names;
}
