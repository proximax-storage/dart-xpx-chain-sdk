/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

class AccountNames {
  AccountNames._(this.address, this.names);

  static AccountNames fromDto(AccountNamesDTO dto) {
    final address = Address.fromEncoded(dto.address!);
    final names = (dto.names == null) ? null : dto.names!.cast<String>();
    return AccountNames._(address, names);
  }

  /* The address of the account in hexadecimal. */
  Address address;

  /* The mosaic linked namespace names. */
  List<String>? names;

  static List<AccountNames> listFromJson(List<AccountNamesDTO>? json) =>
      json == null ? <AccountNames>[] : json.map(AccountNames.fromDto).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'address': address, 'names': names};
}
