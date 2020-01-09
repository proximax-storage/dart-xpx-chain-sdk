part of xpx_chain_sdk.mosaic;

enum MosaicPropertyId {
  mosaicPropertyFlagsId,
  mosaicPropertyDivisibilityId,
  mosaicPropertyDurationId,
}

class Mosaic {
  Mosaic(Id mosaicId, BigInt amount) {
    if (mosaicId == null) {
      throw errNullMosaicId;
    } else if (amount == null) {
      throw errNullMosaicAmount;
    } else if (equalsBigInts(amount, BigInt.zero)) {
      throw errNullMosaicAmount;
    } else {
      assetId = mosaicId;
      this.amount = amount;
    }
  }

  Mosaic._(this.assetId, this.amount);

  Mosaic.fromDTO(MosaicDTO v) {
    assetId = MosaicId.fromId(v._id.toBigInt());
    amount = v._amount.toBigInt();
  }

  Id assetId;

  BigInt amount;

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

  static List<Mosaic> listFromDTO(List<MosaicDTO> json) => json == null
      ? <Mosaic>[]
      : json.map((value) => Mosaic.fromDTO(value)).toList();
}

class MosaicId extends Id {
  factory MosaicId({final BigInt id}) {
    if (id == null) {
      throw errNullId;
    }

    return MosaicId._(id);
  }

  const MosaicId._(final BigInt id) : super(id);

  MosaicId.fromId(final BigInt id) : super(id);

  MosaicId.fromBigInt(final BigInt bigInt) : super(bigInt);

  static MosaicId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final BigInt bigInt = BigInt.parse(hex, radix: 16);
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
  int get hashCode => 'MosaicId'.hashCode ^ id.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) ||
      other is MosaicId && runtimeType == other.runtimeType && id == other.id;
}

class MosaicIds {
  MosaicIds._();

  MosaicIds.fromList(List<MosaicId> list)
      : assert(list != null, 'list must not be null') {
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
  MosaicInfo.fromDTO(MosaicInfoDTO value)
      : assert(value != null, 'json must not be null') {
    mosaicId = MosaicId(id: value._mosaic.mosaicId.toBigInt());
    supply = value._mosaic._supply.toBigInt();
    height = value._mosaic._height.toBigInt();
    owner = value._mosaic._owner;
    revision = value._mosaic._revision;
    properties = MosaicProperties.fromDTO(value._mosaic._properties);
  }

  MosaicId mosaicId;
  BigInt supply;
  BigInt height;
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

  static List<MosaicInfo> listFromDTO(List<MosaicInfoDTO> json) => json == null
      ? null
      : json.map((value) => MosaicInfo.fromDTO(value)).toList();
}

class MosaicName {
  MosaicName.fromDTO(MosaicNameDTO value)
      : assert(value != null, 'json must not be null') {
    mosaicId = MosaicId.fromId(value.mosaicId.toBigInt());
    names = value._names != null ? List.from(value._names) : null;
  }

  MosaicId mosaicId;

  List<String> names;

  @override
  String toString() => '"assetId":${mosaicId.toHex()},'
      ' "names":$names}';

  static List<MosaicName> listFromDTO(List<MosaicNameDTO> json) => json == null
      ? null
      : json.map((value) => MosaicName.fromDTO(value)).toList();
}

class MosaicProperty {
  MosaicProperty(this.id, this.value);

  MosaicProperty.fromDTO(_MosaicPropertyDTO value) {
    if (value == null) return;
    id = getPropertyId(value._id);
    this.value = value._value.toBigInt();
  }

  MosaicPropertyId id;

  BigInt value;

  static List<MosaicProperty> listFromDTO(List<_MosaicPropertyDTO> json) =>
      json == null
          ? <MosaicProperty>[]
          : json.map((value) => MosaicProperty.fromDTO(value)).toList();

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
      BigInt duration,
      [this.optionalProperties]) {
    optionalProperties = duration.toInt() != 0
        ? List<MosaicProperty>.from([
            MosaicProperty(MosaicPropertyId.mosaicPropertyDurationId, duration)
          ])
        : List(0);
  }

  MosaicProperties.fromDTO(List<_MosaicPropertyDTO> value)
      : assert(value != null, 'mosaic Properties is not valid') {
//    if (value.length < 3) {
//      print(value.length);
//
//      throw errInvalidMosaicProperties;
//    }

    var flags = BigInt.zero;

    divisibility = 0;

    for (_MosaicPropertyDTO property in value) {
      switch (property._id) {
        case 0:
          flags = property._value.toBigInt();
          break;
        case 1:
          divisibility = property._value.toBigInt().toInt();
          break;
        case 2:
          optionalProperties = <MosaicProperty>[];
          break;
        default:
          throw errPropertyId;
      }
    }

    supplyMutable = hasBits(flags, _supplyMutable);
    transferable = hasBits(flags, _transferable);
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
    if (optionalProperties.isNotEmpty) {
      sb.writeln('\t\t"optionalProperties": $optionalProperties,');
    }
    sb.writeln('\t\t"divisibility": $divisibility');
    sb.write('\t}');
    return sb.toString();
  }
}
