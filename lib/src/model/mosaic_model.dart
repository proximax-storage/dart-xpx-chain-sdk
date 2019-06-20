part of xpx_chain_sdk;

// Create xpx with using xpx as unit
Mosaic Xpx(int amount) {
  return  Mosaic(xpxMosaicId,  BigInt.from(amount));
}

Mosaic XpxRelative(int amount) {
  return Xpx((BigInt.from(1000000) * BigInt.from(amount)).toInt());
}

class Mosaic {
  Mosaic._(this.id, this.amount);

  Mosaic(MosaicId mosaicId, BigInt amount) {
    if (mosaicId == null) {
      throw errNullMosaicId;
    }

    if (amount == null) {
      throw errNullMosaicAmount;
    }

    if (EqualsBigInts(amount, BigInt.zero)) {
      throw errNullMosaicAmount;
    }

    this.id = mosaicId;
    this.amount = amount;
  }

  Mosaic.fromDTO(_MosaicDTO v) {
    id = MosaicId.fromId(v.id.toBigInt());
    amount = v.amount.toBigInt();
  }

  MosaicId id;

  BigInt amount;

  @override
  String toString() {
    return '\n\t{\n'
        '\t"mosaicId": ${id.toHex()},\n'
        '\t"mmount": $amount\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id.toHex();
    data['amount'] = this.amount;

    return data;
  }

  static List<Mosaic> listFromDTO(List<_MosaicDTO> json) {
    return json == null
        ?  List<Mosaic>()
        : json.map((value) =>  Mosaic.fromDTO(value)).toList();
  }
}

class MosaicId extends Id {
  const MosaicId._(final BigInt id) : super(id);

  factory MosaicId({final BigInt id}) {
    if (id == null) {
      throw errNullId;
    }

    return  MosaicId._(id);
  }

  static MosaicId fromId(final BigInt id) {
    return  MosaicId(id: id);
  }

  static MosaicId fromBigInt(final BigInt bigInt) {
    if (bigInt == null) {
      throw errNullBigInt;
    }
    return  MosaicId(id: bigInt);
  }

  @override
  String toString() {
    return '${this.toHex()}';
  }

  @override
  int get hashCode => 'MosaicId'.hashCode ^ id.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) ||
      other is MosaicId && runtimeType == other.runtimeType && id == other.id;
}

class MosaicIds {
  List<MosaicId> _list = [];

  MosaicIds add(MosaicId id) {
    _list.add(id);
    return this;
  }

  @override
  String toString() {
    return '{mosaicIds:$_list}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['mosaicIds'] = _list.map((id) => id.toHex()).toList();
    return data;
  }
}

class MosaicInfo {
  MosaicInfo.fromDTO(_MosaicInfoDTO value) {
    if (json == null) return;
    mosaicId =  MosaicId(id: value.mosaic.mosaicId.toBigInt());
    supply = value.mosaic.supply.toBigInt();
    height = value.mosaic.height.toBigInt();
    owner =
         PublicAccount.fromPublicKey(value.mosaic.owner, ConfigNetworkType);
    revision = value.mosaic.revision;
    properties =  MosaicProperties.fromJson(value.mosaic.properties);
  }

  MosaicId mosaicId;
  BigInt supply;
  BigInt height;
  PublicAccount owner;
  int revision;
  MosaicProperties properties;

  @override
  String toString() {
    return '\n\t{\n'
        '\t"mosaicId": ${mosaicId.toHex()},\n'
        '\t"supply": $supply\n'
        '\t"height": $height\n'
        '\t"owner": $owner\n'
        '\t"revision": $revision\n'
        '\t"properties": $properties\n'
        '\t}';
  }

  static List<MosaicInfo> listFromDTO(List<_MosaicInfoDTO> json) {
    return json == null
        ?  List<MosaicInfo>()
        : json.map((value) =>  MosaicInfo.fromDTO(value)).toList();
  }
}

class MosaicName {
  MosaicName.fromDTO(_MosaicNameDTO value) {
    if (json == null) return;
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
  String toString() {
    return '{parentId:${parentId?.toHex()}, mosaicId:${mosaicId.toHex()}, names:$names}';
  }

  static List<MosaicName> listFromDTO(List<_MosaicNameDTO> json) {
    return json == null
        ?  List<MosaicName>()
        : json.map((value) =>  MosaicName.fromDTO(value)).toList();
  }
}

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  MosaicProperties(this.supplyMutable, this.transferable, this.levyMutable,
      this.divisibility, this.duration);

  MosaicProperties.fromJson(List<UInt64DTO> value) {
    if (json == null) throw errInvalidMosaicProperties;

    if (value.length < 3) {
      throw errInvalidMosaicProperties;
    }

    final flags = "00" + value[0].toBigInt().toRadixString(2);
    final bitMapFlags = flags.substring(flags.length - 3, flags.length);

    supplyMutable = bitMapFlags[2] == '1';
    transferable = bitMapFlags[1] == '1';
    levyMutable = bitMapFlags[0] == '1';
    divisibility = value[1].toBigInt().toInt();
    duration = value[2].toBigInt();
  }

  MosaicProperties.fromDTO(List<_MosaicPropertiesDTO> value) {
    if (json == null) throw errInvalidMosaicProperties;

    if (value.length < 3) {
      throw errInvalidMosaicProperties;
    }

    final flags = "00" + value[0].value.toBigInt().toRadixString(2);
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
  String toString() {
    return '{\n'
        '\t"supplyMutable": $supplyMutable,\n'
        '\t"transferable": $transferable,\n'
        '\t"levyMutable": $levyMutable,\n'
        '\t"divisibility": $divisibility,\n'
        '\t"duratione": $duration\n'
        '\t}';
  }
}

MosaicId NewMosaicIdFromNonceAndOwner(int nonce, String ownerPublicKey) {
  if (ownerPublicKey.length != 64) {
    throw errInvalidOwnerPublicKey;
  }

  return MosaicId.fromId(_generateMosaicId(nonce, ownerPublicKey));
}

BigInt _generateMosaicId(int nonce, String ownerPublicKey) {
  var nonceB =  Buffer.LittleEndian(4);
  nonceB.writeInt32(nonce);

  var result = sha3.New256();

  result.update(nonceB.out, 0, nonceB.out.length);

  var ownerBytes = hex.decode(ownerPublicKey);

  var t = result.process(Uint8List.fromList(ownerBytes));

  List<dynamic> raw() {
    return <dynamic>[
      EndianLittleUint32(t.getRange(0, 4).toList()),
      EndianLittleUint32(t.getRange(4, 8).toList()) & 0x7FFFFFFF
    ];
  }

  return  UInt64DTO.fromJson(raw()).toBigInt();
}

int MosaicNonce() {
  var random = Random.secure();
  return random.nextInt(1000000000);
}
