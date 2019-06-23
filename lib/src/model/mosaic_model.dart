part of xpx_chain_sdk;

// Create xpx with using xpx as unit
Mosaic xpx(int amount) => Mosaic(xpxMosaicId, BigInt.from(amount));

Mosaic xpxRelative(int amount) =>
    xpx((BigInt.from(1000000) * BigInt.from(amount)).toInt());

class Mosaic {
  Mosaic(MosaicId mosaicId, BigInt amount) {
    if (mosaicId == null) {
      throw _errNullMosaicId;
    } else if (amount == null) {
      throw _errNullMosaicAmount;
    } else if (equalsBigInts(amount, BigInt.zero)) {
      throw _errNullMosaicAmount;
    } else {
      id = mosaicId;
      this.amount = amount;
    }
  }

  Mosaic._(this.id, this.amount);

  Mosaic.fromDTO(_MosaicDTO v) {
    id = MosaicId.fromId(v.id.toBigInt());
    amount = v.amount.toBigInt();
  }

  MosaicId id;

  BigInt amount;

  @override
  String toString() => '\n\t{\n'
      '\t"mosaicId": ${id.toHex()},\n'
      '\t"mmount": $amount\n'
      '\t}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id.toHex();
    data['amount'] = amount;

    return data;
  }

  static List<Mosaic> listFromDTO(List<_MosaicDTO> json) =>
      json == null ? <Mosaic>[] : json.map((value) => Mosaic.fromDTO(value)).toList();
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
  MosaicInfo.fromDTO(_MosaicInfoDTO value)
      : assert(json != null, 'json must not be null') {
    mosaicId = MosaicId(id: value.mosaic.mosaicId.toBigInt());
    supply = value.mosaic.supply.toBigInt();
    height = value.mosaic.height.toBigInt();
    owner = PublicAccount.fromPublicKey(value.mosaic.owner, configNetworkType);
    revision = value.mosaic.revision;
    properties = MosaicProperties.fromJson(value.mosaic.properties);
  }

  MosaicId mosaicId;
  BigInt supply;
  BigInt height;
  PublicAccount owner;
  int revision;
  MosaicProperties properties;

  @override
  String toString() => '\n\t{\n'
      '\t"mosaicId": ${mosaicId.toHex()},\n'
      '\t"supply": $supply\n'
      '\t"height": $height\n'
      '\t"owner": $owner\n'
      '\t"revision": $revision\n'
      '\t"properties": $properties\n'
      '\t}';

  static List<MosaicInfo> listFromDTO(List<_MosaicInfoDTO> json) => json == null
      ? null
      : json.map((value) => MosaicInfo.fromDTO(value)).toList();
}

class MosaicName {
  MosaicName.fromDTO(_MosaicNameDTO value)
      : assert(json != null, 'json must not be null') {
    parentId = value.parentId == null
        ? MosaicId.fromId(value.parentId.toBigInt())
        : null;
    mosaicId = MosaicId.fromId(value.mosaicId.toBigInt());
    names = value.names != null ? List.from(value.names) : null;
  }

  MosaicId parentId;

  MosaicId mosaicId;

  List<String> names;

  @override
  String toString() => '{parentId:${parentId?.toHex()},'
      ' mosaicId:${mosaicId.toHex()},'
      ' names:$names}';

  static List<MosaicName> listFromDTO(List<_MosaicNameDTO> json) => json == null
      ? null
      : json.map((value) => MosaicName.fromDTO(value)).toList();
}

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  // ignore: avoid_positional_boolean_parameters
  MosaicProperties(this.supplyMutable, this.transferable, this.levyMutable,
      this.divisibility, this.duration);

  MosaicProperties.fromJson(List<UInt64DTO> value)
      : assert(json != null, 'mosaic Properties is not valid') {

    if (value.length < 3) {
      throw _errInvalidMosaicProperties;
    }

    final flags = '00' + value[0].toBigInt().toRadixString(2);
    final bitMapFlags = flags.substring(flags.length - 3, flags.length);

    supplyMutable = bitMapFlags[2] == '1';
    transferable = bitMapFlags[1] == '1';
    levyMutable = bitMapFlags[0] == '1';
    divisibility = value[1].toBigInt().toInt();
    duration = value[2].toBigInt();
  }

  MosaicProperties.fromDTO(List<_MosaicPropertiesDTO> value)
    : assert(json != null, 'mosaic Properties is not valid') {

    if (value.length < 3) {
      throw _errInvalidMosaicProperties;
    }

    final flags = '00' + value[0].value.toBigInt().toRadixString(2);
    final bitMapFlags = flags.substring(flags.length - 3, flags.length);

    supplyMutable = bitMapFlags[2] == '1';
    transferable = bitMapFlags[1] == '1';
    levyMutable = bitMapFlags[0] == '1';
    divisibility = value[1].value.toBigInt().toInt();
    duration = value[2].value.toBigInt();
  }

  bool supplyMutable;
  bool transferable;
  bool levyMutable;
  int divisibility;
  BigInt duration;

  @override
  String toString() => '{\n'
      '\t"supplyMutable": $supplyMutable,\n'
      '\t"transferable": $transferable,\n'
      '\t"levyMutable": $levyMutable,\n'
      '\t"divisibility": $divisibility,\n'
      '\t"duratione": $duration\n'
      '\t}';
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
