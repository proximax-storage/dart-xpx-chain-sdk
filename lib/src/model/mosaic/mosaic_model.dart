part of xpx_chain_sdk.mosaic;

enum MosaicPropertyId {
  mosaicPropertyFlagsId,
  mosaicPropertyDivisibilityId,
  mosaicPropertyDurationId,
}

class Mosaic {
  Mosaic(this.assetId, this.amount) {
    if (assetId == null) {
      throw errNullMosaicId;
    } else if (amount == null) {
      throw errNullMosaicAmount;
    } else if (amount.isZero) {
      throw errNullMosaicAmount;
    } else {
      assetId = assetId;
      amount = amount;
    }
  }

  Mosaic.fromDTO(MosaicDTO v) {
    assetId = MosaicId.fromId(v._id.toUint64());
    amount = v._amount.toUint64();
  }

  AssetId assetId;
  Uint64 amount;

  @override
  String toString() => '\n\t{\n'
      '\t"assetId": ${assetId.toHex()},\n'
      '\t"amount": $amount\n'
      '\t}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = assetId.toHex();
    data['amount'] = amount;
    return data;
  }

  static List<Mosaic> listFromDTO(List<MosaicDTO> json) =>
      json == null ? <Mosaic>[] : json.map((value) => Mosaic.fromDTO(value)).toList();
}

class MosaicId extends AssetId {
  factory MosaicId({final Uint64 id}) {
    if (id == null) {
      throw errNullId;
    }

    return MosaicId._(id);
  }

  const MosaicId._(final Uint64 id) : super(id);

  MosaicId.fromId(final Uint64 id) : super(id);

  MosaicId.fromUint64(final Uint64 bigInt) : super(bigInt);

  static MosaicId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final Uint64 bigInt = Uint64.fromHex(hex);
    return MosaicId._(bigInt);
  }

  static MosaicId fromNonceAndOwner(int nonce, String ownerPublicKey) {
    if (ownerPublicKey.length != 64) {
      throw errInvalidOwnerPublicKey;
    }

    return MosaicId._(_generateMosaicId(nonce, ownerPublicKey));
  }

  @override
  String toString() => '${toHex()}';

  @override
  int get hashCode => 'MosaicId'.hashCode ^ super.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) || other is MosaicId && runtimeType == other.runtimeType && toBytes() == other.toBytes();
}

class MosaicIds {
  MosaicIds.fromList(List<MosaicId> list) : assert(list != null, 'list must not be null') {
    _list = list.map((item) => item).toList();
  }

  List<MosaicId> _list = [];

  @override
  String toString() => '{mosaicIds:$_list}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mosaicIds'] = _list.map((id) => id.toHex()).toList();
    return data;
  }
}

class MosaicInfo {
  MosaicInfo.fromDTO(MosaicInfoDTO dto) : assert(dto != null, 'dto must not be null') {
    mosaicId = MosaicId(id: dto._mosaic.mosaicId.toUint64());
    supply = dto._mosaic._supply.toUint64();
    height = dto._mosaic._height.toUint64();
    owner = dto._mosaic._owner;
    revision = dto._mosaic._revision;
    properties = MosaicProperties.fromDTO(dto._mosaic._properties);
  }

  MosaicId mosaicId;
  Uint64 supply;
  Uint64 height;
  String owner;
  int revision;
  MosaicProperties properties;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"assetId": ${mosaicId.toHex()},')
      ..writeln('\t"supply": $supply,')
      ..writeln('\t"height": $height,')
      ..writeln('\t"owner": $owner,')
      ..writeln('\t"revision": $revision,')
      ..writeln('\t"properties": $properties');
    sb.write('}');
    return sb.toString();
  }

  static List<MosaicInfo> listFromDTO(List<MosaicInfoDTO> json) =>
      json == null ? null : json.map((value) => MosaicInfo.fromDTO(value)).toList();
}

class MosaicName {
  MosaicName.fromDTO(MosaicNameDTO dto) : assert(dto != null, 'dto must not be null') {
    mosaicId = MosaicId.fromId(dto.mosaicId.toUint64());
    names = dto._names != null ? List.from(dto._names) : null;
  }

  MosaicId mosaicId;

  List<String> names;

  @override
  String toString() => '"assetId":${mosaicId.toHex()},'
      ' "names":$names}';

  static List<MosaicName> listFromDTO(List<MosaicNameDTO> json) =>
      json == null ? null : json.map((value) => MosaicName.fromDTO(value)).toList();
}

class MosaicProperty {
  MosaicProperty(this.id, this.value);

  MosaicProperty.fromDTO(_MosaicPropertyDTO dto) {
    if (dto == null) return;
    id = getPropertyId(dto._id);
    value = dto._value.toUint64();
  }

  MosaicPropertyId id;

  Uint64 value;

  static List<MosaicProperty> listFromDTO(List<_MosaicPropertyDTO> json) =>
      json == null ? <MosaicProperty>[] : json.map((value) => MosaicProperty.fromDTO(value)).toList();

  @override
  String toString() => 'id: $id, value: $value';

  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  MosaicProperties(
      // ignore: avoid_positional_boolean_parameters
      this.supplyMutable,
      this.transferable,
      this.divisibility,
      Uint64 duration,
      [this.optionalProperties]) {
    optionalProperties = duration.toInt() != 0
        ? List<MosaicProperty>.from([MosaicProperty(MosaicPropertyId.mosaicPropertyDurationId, duration)])
        : List(0);
  }

  MosaicProperties.fromDTO(List<_MosaicPropertyDTO> value) : assert(value != null, 'mosaic Properties is not valid') {
    var flags = Uint64.zero;

    divisibility = 0;

    for (_MosaicPropertyDTO property in value) {
      switch (property._id) {
        case 0:
          flags = property._value.toUint64();
          break;
        case 1:
          divisibility = property._value.toUint64().toInt();
          break;
        case 2:
          optionalProperties = <MosaicProperty>[];
          break;
        default:
          throw errPropertyId;
      }
    }

    supplyMutable = hasBits(flags, getSupplyMutable);
    transferable = hasBits(flags, getTransferable);
  }

  bool supplyMutable;
  bool transferable;
  int divisibility;
  List<MosaicProperty> optionalProperties;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t\t"supplyMutable": $supplyMutable,')
      ..writeln('\t\t"transferable": $transferable,');
    if (optionalProperties != null) {
      sb.writeln('\t\t"optionalProperties": $optionalProperties,');
    }
    sb.writeln('\t\t"divisibility": $divisibility');
    sb.write('\t}');
    return sb.toString();
  }
}
