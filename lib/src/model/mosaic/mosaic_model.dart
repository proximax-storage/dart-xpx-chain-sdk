part of xpx_chain_sdk;

// Create xpx with using xpx as unit
Mosaic xpx(int amount) => Mosaic(xpxMosaicId, BigInt.from(amount));

Mosaic xpxRelative(int amount) =>
    xpx((BigInt.from(1000000) * BigInt.from(amount)).toInt());

enum MosaicPropertyId {
  mosaicPropertyFlagsId,
  mosaicPropertyDivisibilityId,
}

// ignore: constant_identifier_names
const _supplyMutable = 0x01;

const _transferable = 0x02;

class Mosaic {
  Mosaic(Id mosaicId, BigInt amount) {
    if (mosaicId == null) {
      throw _errNullMosaicId;
    } else if (amount == null) {
      throw _errNullMosaicAmount;
    } else if (equalsBigInts(amount, BigInt.zero)) {
      throw _errNullMosaicAmount;
    } else {
      assetId = mosaicId;
      this.amount = amount;
    }
  }

  Mosaic._(this.assetId, this.amount);

  Mosaic._fromDTO(_MosaicDTO v) {
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

  static List<Mosaic> listFromDTO(List<_MosaicDTO> json) => json == null
      ? <Mosaic>[]
      : json.map((value) => Mosaic._fromDTO(value)).toList();
}

class MosaicId extends Id {
  factory MosaicId({final BigInt id}) {
    if (id == null) {
      throw _errNullId;
    }

    return MosaicId._(id);
  }

  const MosaicId._(final BigInt id) : super(id);

  MosaicId.fromId(final BigInt id) : super(id);

  MosaicId.fromBigInt(final BigInt bigInt) : super(bigInt);

  static MosaicId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw new ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw new ArgumentError('invalid hex');
    }
    final BigInt bigInt = BigInt.parse(hex, radix: 16);
    return MosaicId._(bigInt);
  }

  static MosaicId fromNonceAndOwner(int nonce, String ownerPublicKey) {
    if (ownerPublicKey.length != 64) {
      throw _errInvalidOwnerPublicKey;
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
  final List<MosaicId> _list = [];

  void add(MosaicId id) {
    _list.add(id);
  }

  @override
  String toString() => '{mosaicIds:$_list}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mosaicIds'] = _list.map((id) => id.toHex()).toList();
    return data;
  }
}

class MosaicInfo {
  MosaicInfo._fromDTO(_MosaicInfoDTO value)
      : assert(json != null, 'json must not be null') {
    mosaicId = MosaicId(id: value._mosaic._mosaicId.toBigInt());
    supply = value._mosaic._supply.toBigInt();
    height = value._mosaic._height.toBigInt();
    owner =
        PublicAccount.fromPublicKey(value._mosaic._owner, configNetworkType);
    revision = value._mosaic._revision;
    properties = MosaicProperties._fromDTO(value._mosaic._properties);
  }

  MosaicId mosaicId;
  BigInt supply;
  BigInt height;
  PublicAccount owner;
  int revision;
  MosaicProperties properties;

  @override
  String toString() => '\n\t{\n'
      '\t"assetId": ${mosaicId.toHex()},\n'
      '\t"supply": $supply\n'
      '\t"height": $height\n'
      '\t"owner": $owner\n'
      '\t"revision": $revision\n'
      '\t"properties": $properties\n'
      '\t}';

  static List<MosaicInfo> listFromDTO(List<_MosaicInfoDTO> json) => json == null
      ? null
      : json.map((value) => MosaicInfo._fromDTO(value)).toList();
}

class MosaicName {
  MosaicName._fromDTO(_MosaicNameDTO value)
      : assert(json != null, 'json must not be null') {
    mosaicId = MosaicId.fromId(value._mosaicId.toBigInt());
    names = value._names != null ? List.from(value._names) : null;
  }

  MosaicId mosaicId;

  List<String> names;

  @override
  String toString() => '"assetId":${mosaicId.toHex()},'
      ' "names":$names}';

  static List<MosaicName> listFromDTO(List<_MosaicNameDTO> json) => json == null
      ? null
      : json.map((value) => MosaicName._fromDTO(value)).toList();
}

class MosaicProperty {
  MosaicProperty(this.id, this.value);

  MosaicProperty._fromDTO(_MosaicPropertyDTO value) {
    if (value == null) return;
    id = value._id;
    this.value = value._value.toBigInt();
  }

  int id;

  BigInt value;

  static List<MosaicProperty> listFromDTO(List<_MosaicPropertyDTO> json) =>
      json == null
          ? <MosaicProperty>[]
          : json.map((value) => new MosaicProperty._fromDTO(value)).toList();

  @override
  String toString() => 'id: $id, value: $value';

  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  // ignore: avoid_positional_boolean_parameters
  MosaicProperties(this.supplyMutable, this.transferable,
      this.optionalProperties, this.divisibility);

//  MosaicProperties.fromJsonOLD(List<UInt64DTO> value)
//      : assert(json != null, 'mosaic Properties is not valid') {
//    if (value.length < 3) {
//      throw _errInvalidMosaicProperties;
//    }
//
//    final flags = '00' + value[0].toBigInt().toRadixString(2);
//    final bitMapFlags = flags.substring(flags.length - 3, flags.length);
//
//    supplyMutable = bitMapFlags[2] == '1';
//    transferable = bitMapFlags[1] == '1';
//    optionalProperties = bitMapFlags[0] == '1';
//    divisibility = value[1].toBigInt().toInt();
//    duration = value[2].toBigInt();
//  }

  MosaicProperties._fromDTO(List<_MosaicPropertyDTO> value)
      : assert(json != null, 'mosaic Properties is not valid') {
//    if (value.length < 3) {
//      print(value.length);
//
//      throw _errInvalidMosaicProperties;
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
          throw _errPropertyId;
      }
    }

    supplyMutable = hasBits(flags, _supplyMutable);
    transferable = hasBits(flags, _transferable);
  }

  bool supplyMutable;
  bool transferable;
  List<MosaicProperty> optionalProperties;
  int divisibility;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t\t"supplyMutable": $supplyMutable,')
      ..writeln('\t\t"transferable": $transferable,')
      ..writeln('\t\t"optionalProperties": $optionalProperties,')
      ..writeln('\t\t"divisibility": $divisibility,')
      ..write('\t}');
    return sb.toString();
  }
}

BigInt _generateMosaicId(int nonce, String ownerPublicKey) {
  final nonceB = Buffer.littleEndian(4)..writeInt32(nonce);

  final result = sha3.New256()..update(nonceB.out, 0, nonceB.out.length);

  final ownerBytes = hex.decode(ownerPublicKey);

  final t = result.process(Uint8List.fromList(ownerBytes));

  List<dynamic> raw() => <dynamic>[
        endianLittleUint32(t.getRange(0, 4).toList()),
        endianLittleUint32(t.getRange(4, 8).toList()) & 0x7FFFFFFF
      ];

  return UInt64DTO.fromJson(raw()).toBigInt();
}

int mosaicNonce() {
  final random = Random.secure();
  return random.nextInt(1000000000);
}
