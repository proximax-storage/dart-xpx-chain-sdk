/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.alias;

AliasType getAliasType(int value) {
  switch (value) {
    case 1:
      return AliasType.mosaicAliasType;
    case 0:
      return AliasType.addressAliasType;
    default:
      return AliasType.noneAliasType;
  }
}
