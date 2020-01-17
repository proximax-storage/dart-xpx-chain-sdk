part of xpx_chain_sdk.alias;

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
