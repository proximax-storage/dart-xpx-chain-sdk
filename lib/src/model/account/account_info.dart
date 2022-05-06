/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

class AccountInfo {
  AccountInfo.fromDTO(AccountInfoDTO v) {
    final List<Mosaic?> mList =
        List.filled(v.account!.mosaics!.length, null, growable: false);
    for (var i = 0; i < v.account!.mosaics!.length; i++) {
      mList[i] = Mosaic.fromDTO(v.account!.mosaics![i]);
    }

    address = Address.fromEncoded(v.account!.address!);
    addressHeight = v.account!.addressHeight!.toUint64();
    publicKey = v.account!.publicKey;
    publicKeyHeight = v.account!.publicKeyHeight!.toUint64();
    accountType = v.account!.accountType;
    linkedAccountKey = v.account!.linkedAccountKey;
    mosaics = mList;
  }

  Address? address;
  Uint64? addressHeight;
  String? publicKey;
  Uint64? publicKeyHeight;
  List<Mosaic?>? mosaics;
  int? accountType;
  String? linkedAccountKey;
  num? reputation;

  static List<AccountInfo> listFromDTO(List<AccountInfoDTO> dto) =>
      dto.isEmpty ? <AccountInfo>[] : dto.map(AccountInfo.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {};

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('address', address);
    writeNotNull('addressHeight', addressHeight);
    writeNotNull('publicKey', publicKey);
    writeNotNull('publicKeyHeight', publicKeyHeight);
    writeNotNull('accountType', accountType);
    writeNotNull('linkedAccountKey', linkedAccountKey);
    writeNotNull('mosaics', mosaics);
    writeNotNull('reputation', reputation);

    return val;
  }
}
