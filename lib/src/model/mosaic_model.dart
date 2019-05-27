part of xpx_catapult_sdk;

const Decrease = 0, Increase = 1;

// Create xpx with using xpx as unit
Mosaic Xpx(int amount) {
  return new Mosaic(XpxMosaicId, new BigInt.from(amount));
}

Mosaic XpxRelative(int amount) {
  return Xpx((BigInt.from(1000000) * BigInt.from(amount)).toInt());
}

class Mosaic {
  BigInt id;

  BigInt amount;

  Mosaic(BigInt mosaicId, amount) {
    if (mosaicId == null) {
      throw ErrNullMosaicId;
    }

    if (amount == null) {
      throw ErrNullMosaicAmount;
    }

    if (EqualsBigInts(amount, BigInt.zero)) {
      throw ErrNullMosaicAmount;
    }

    this.id = mosaicId;
    this.amount = amount;
  }

  @override
  String toString() {
    return '\n\t{\n'
        '\t"MosaicId": $id,\n'
        '\t"Amount": $amount\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount};
  }

  Mosaic.fromDTO(_mosaicDTO v) {
    id = v.id.toBigInt();
    amount = v.amount.toBigInt();
  }

  static List<Mosaic> listFromDTO(List<_mosaicDTO> json) {
    return json == null
        ? new List<Mosaic>()
        : json.map((value) => new Mosaic.fromDTO(value)).toList();
  }
}

class MosaicIds {
  List<BigInt> _list = [];

  MosaicIds();

  MosaicIds add(BigInt id) {
    _list.add(id);
    return this;
  }

  @override
  String toString() {
    return '{mosaicIds:$_list}';
  }

  Map<String, dynamic> toJson() {
    List<String> nsIds = List(_list.length);

    for (int i = 0; i < _list.length; i++) nsIds[i] = bigIntegerToHex(_list[i]);

    return {
      'mosaicIds': nsIds,
    };
  }
}

class MosaicInfo {
  BigInt mosaicId;
  BigInt supply;
  BigInt height;
  PublicAccount owner;
  int revision;
  MosaicProperties properties;
  MosaicInfo();

  @override
  String toString() {
    return '\n\t{\n'
        '\t"MosaicId": $mosaicId,\n'
        '\t"Supply": $supply\n'
        '\t"Height": $height\n'
        '\t"Owner": $owner\n'
        '\t"Revision": $revision\n'
        '\t"Properties": $properties\n'
        '\t}';
  }

  MosaicInfo.fromDTO(_mosaicInfoDTO value) {
    if (json == null) return;

    mosaicId = value.mosaic.mosaicId.toBigInt();
    supply = value.mosaic.supply.toBigInt();
    height = value.mosaic.height.toBigInt();
    owner =
        new PublicAccount.fromPublicKey(value.mosaic.owner, ConfigNetworkType);
    revision = value.mosaic.revision;
    properties = new MosaicProperties.fromJson(value.mosaic.properties);
  }

  static List<MosaicInfo> listFromDTO(List<_mosaicInfoDTO> json) {
    return json == null
        ? new List<MosaicInfo>()
        : json.map((value) => new MosaicInfo.fromDTO(value)).toList();
  }
}

class MosaicName {
  BigInt parentId;

  BigInt mosaicId;

  String name;

  MosaicName();

  @override
  String toString() {
    return '{ParentId:${bigIntegerToHex(parentId)}, MosaicId:${bigIntegerToHex(mosaicId).toUpperCase()}, Name:$name}';
  }

  MosaicName.fromDTO(_mosaicNameDTO value) {
    if (json == null) return;
    parentId = value.parentId == null ? value.parentId.toBigInt() : null;
    mosaicId = value.mosaicId.toBigInt();
    name = value?.name;
  }

  static List<MosaicName> listFromDTO(List<_mosaicNameDTO> json) {
    return json == null
        ? new List<MosaicName>()
        : json.map((value) => new MosaicName.fromDTO(value)).toList();
  }
}

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  bool supplyMutable;
  bool transferable;
  bool levyMutable;
  int divisibility;
  BigInt duration;

  MosaicProperties(this.supplyMutable, this.transferable, this.levyMutable,
      this.divisibility, this.duration);

  @override
  String toString() {
    return '{\n'
        '\t"SupplyMutable": $supplyMutable,\n'
        '\t"Transferable": $transferable,\n'
        '\t"LevyMutable": $levyMutable,\n'
        '\t"Divisibility": $divisibility,\n'
        '\t"Duratione": $duration\n'
        '\t}';
  }

  MosaicProperties.fromJson(List<UInt64DTO> value) {
    if (json == null) throw ErrInvalidMosaicProperties;

    if (value.length < 3) {
      throw ErrInvalidMosaicProperties;
    }

    final flags = "00" + value[0].toBigInt().toRadixString(2);
    final bitMapFlags = flags.substring(flags.length - 3, flags.length);

    supplyMutable = bitMapFlags[2] == '1';
    transferable = bitMapFlags[1] == '1';
    levyMutable = bitMapFlags[0] == '1';
    divisibility = value[1].toBigInt().toInt();
    duration = value[2].toBigInt();
  }

  MosaicProperties.fromDTO(List<_mosaicPropertiesDTO> value) {
    if (json == null) throw ErrInvalidMosaicProperties;

    if (value.length < 3) {
      throw ErrInvalidMosaicProperties;
    }

    final flags = "00" + value[0].value.toBigInt().toRadixString(2);
    final bitMapFlags = flags.substring(flags.length - 3, flags.length);

    supplyMutable = bitMapFlags[2] == '1';
    transferable = bitMapFlags[1] == '1';
    levyMutable = bitMapFlags[0] == '1';
    divisibility = value[1].value.toBigInt().toInt();
    duration = value[2].value.toBigInt();
  }
}

MosaicProperties NewMosaicProperties(bool SupplyMutable, Transferable,
    LevyMutable, int Divisibility, BigInt Duration) {
  return new MosaicProperties(
      SupplyMutable, Transferable, LevyMutable, Divisibility, Duration);
}

BigInt NewMosaicIdFromNonceAndOwner(int nonce, String ownerPublicKey) {
  if (ownerPublicKey.length != 64) {
    throw ErrInvalidOwnerPublicKey;
  }

  return _generateMosaicId(nonce, ownerPublicKey);
}

BigInt _generateMosaicId(int nonce, String ownerPublicKey) {
  var nonceB = new Buffer.LittleEndian(4);
  nonceB.writeInt32(nonce);

  var result = sha3.New256();

  result.update(nonceB.out, 0, nonceB.out.length);

  var ownerBytes = HEX.decode(ownerPublicKey);

  var t = result.process(ownerBytes);

  List<dynamic> raw() {
    return [
      EndianLittleUint32(t.getRange(0, 4).toList()),
      EndianLittleUint32(t.getRange(4, 8).toList()) & 0x7FFFFFFF
    ];
  }

  return new UInt64DTO.fromJson(raw()).toBigInt();
}

int MosaicNonce() {
  var random = Random.secure();
  return random.nextInt(1000000000);
}
