/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class AccountDTO {
  AccountDTO.fromJson(Map json) : assert(json.isNotEmpty, 'json must not be empty') {
    address = json['address'];
    addressHeight = UInt64DTO.fromJson(json['addressHeight']);
    publicKey = json['publicKey'];
    publicKeyHeight = UInt64DTO.fromJson(json['publicKeyHeight']);
    mosaics = MosaicDTO.listFromJson(json['mosaics'].cast<Map>());
    accountType = json['accountType'];
    linkedAccountKey = json['linkedAccountKey'];
  }

  String? address;

  UInt64DTO? addressHeight;

  String? publicKey;

  UInt64DTO? publicKeyHeight;

  List<MosaicDTO>? mosaics = [];

  int? accountType;

  String? linkedAccountKey;

  Map<String, dynamic> toJson() => {
        'address': address,
        'addressHeight': addressHeight,
        'publicKey': publicKey,
        'publicKeyHeight': publicKeyHeight,
        'mosaics': mosaics,
        'accountType': accountType,
        'linkedAccountKey': linkedAccountKey,
      };
}

class AccountInfoDTO {
  AccountInfoDTO.fromJson(Map<dynamic, dynamic> json) : assert(json.isNotEmpty, 'json must not be empty') {
    account = AccountDTO.fromJson(json['account']);
  }

  AccountDTO? account;

  Map<String, dynamic> toJson() => {'account': account};
}

class AccountNamesDTO {
  AccountNamesDTO();

  AccountNamesDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    address = json['address'];
    names = (json['names'] == null)
        ? null
        :
        // ignore: avoid_as
        (json['names'] as List).cast<String>();
  }

  /* The address of the account in hexadecimal. */
  String? address;

  /* The mosaic linked namespace names. */
  List<String>? names;
}
