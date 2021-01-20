part of xpx_chain_sdk.alias;

// AliasType enums
enum AliasType {
  noneAliasType,
  mosaicAliasType,
  addressAliasType,
}

enum AliasActionType { aliasLink, aliasUnlink }

extension AliasTypeToInt on AliasType {
  int get toInt => index;
}

extension AliasActionTypeToInt on AliasActionType {
  int get toInt => index;
}

class Alias {
  Alias.fromDTO(AliasDTO dto) : assert(dto != null, 'dto must not be null') {
    if (dto.address != null) address = Address.fromEncoded(dto.address);
    if (dto.mosaicId != null) mosaicId = MosaicId.fromId(dto.mosaicId.toUint64());
    if (dto.aliasAction == 1)
      type = AliasType.mosaicAliasType;
    else
      type = AliasType.addressAliasType;
  }

  AliasType type;

  Address address;

  MosaicId mosaicId;

  @override
  String toString() {
    final sb = StringBuffer()..write('{');
    sb.write('type: ${type.index}, ');
    if (mosaicId != null) {
      sb.write('mosaicId: $mosaicId');
    }
    if (address != null) {
      sb.write('address: $address');
    }
    sb.write('}');
    return sb.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type.toInt;
    data['mosaicId'] = mosaicId;
    data['address'] = address;
    return data;
  }
}
