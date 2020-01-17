part of xpx_chain_sdk.exchange;

class Exchange {
  String owner;
  String ownerAddress;
  List<_BuyOffer> buyOffers;
  List<_SellOffer> sellOffers;

  Exchange({this.owner, this.ownerAddress, this.buyOffers, this.sellOffers});

  Exchange.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    ownerAddress = json['ownerAddress'];
//    if (json['buyOffers'] != null) {
//      buyOffers = new List<Null>();
//      json['buyOffers'].forEach((v) {
//        buyOffers.add(new Null.fromJson(v));
//      });
//    }
//    if (json['sellOffers'] != null) {
//      sellOffers = new List<SellOffers>();
//      json['sellOffers'].forEach((v) {
//        sellOffers.add(new SellOffers.fromJson(v));
//      });
//    }
  }
}

final OfferType sellOffer = _SellOffer();

final OfferType buyOffer = _BuyOffer();

class OfferType implements Comparable<OfferType> {
  const OfferType(this.value);

  final int value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(final other) => other is OfferType && value == other.value;

  @override
  int compareTo(final OfferType other) => value.compareTo(other.value);

  @override
  String toString() {
    switch (value) {
      case 0:
        return 'sell';
      case 1:
        return 'buy';
      default:
        return 'unknown';
    }
  }
}

class Offer implements Comparable<Offer> {
  Offer(this.offerType, this.mosaic, this.cost);

  OfferType offerType;
  Mosaic mosaic;
  Uint64 cost;

  @override
  int get hashCode => offerType.hashCode ^ mosaic.hashCode ^ cost.hashCode;

  @override
  bool operator ==(final other) =>
      other is Offer &&
      runtimeType == other.runtimeType &&
      offerType == other.offerType &&
      mosaic == other.mosaic &&
      cost == other.cost;

  @override
  int compareTo(final Offer other) => offerType.compareTo(other.offerType);

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $offerType,')
      ..writeln('\t"mosaic": $mosaic')
      ..writeln('\t"cost": $cost')
      ..write('}');
    return sb.toString();
  }
}

class _SellOffer extends OfferType {
  factory _SellOffer() => const _SellOffer._(0);

  const _SellOffer._(int t) : super(t);

  @override
  int get hashCode => '_SellOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is _SellOffer && value == other.value;

  @override
  String toString() => 'sell';
}

class _BuyOffer extends OfferType {
  factory _BuyOffer() => const _BuyOffer._(1);

  const _BuyOffer._(int t) : super(t);

  @override
  int get hashCode => '_BuyOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is _BuyOffer && value == other.value;

  @override
  String toString() => 'buy';
}

class UserExchangeInfo {
  UserExchangeInfo({this.owner, this.offers});

  UserExchangeInfo.fromDTO(ExchangeDTO dto)
      : assert(dto != null, 'dto must not be null') {
    owner = dto.owner;

    if (dto.sellOffers.isNotEmpty) {
      final sellMap = <MosaicId, OfferInfo>{};

      for (final sell in dto.sellOffers) {
        final offer = OfferInfo.fromDTO(sell);
        offer.type = sellOffer;
        offer.owner = owner;
        sellMap[MosaicId.fromId(sell.mosaicId.toUint64())] = offer;
      }

      offers[sellOffer] = sellMap;
    }

    if (dto.buyOffers.isNotEmpty) {

      final buyMap = <MosaicId, OfferInfo>{};

      for (final buy in dto.buyOffers) {
        final offer = OfferInfo.fromDTO(buy);
        offer.type = buyOffer;
        offer.owner = owner;
        buyMap[MosaicId.fromId(buy.mosaicId.toUint64())] = offer;
      }

      offers[buyOffer] = buyMap;
    }
  }

  String owner;

  Map<OfferType, Map<MosaicId, OfferInfo>> offers = {};

  List<OfferInfo> get sellOffers => _offersToList(offers[sellOffer]);

  List<OfferInfo> get buyOffers => _offersToList(offers[buyOffer]);

  List<OfferInfo> _offersToList(Map<MosaicId, OfferInfo> offer) {
    final List<OfferInfo> _offers = [];
    if (offer == null) {
      return _offers;
    }
    offer.forEach((k, v) => _offers.add(v));
    return _offers;
  }

  @override
  String toString() => 'owner: $owner, offers: $offers';
}

class OfferInfo {
  OfferInfo.fromDTO(OfferInfoDTO value)
      : assert(value != null, 'json must not be null') {
    type = OfferType(value.type);
    owner = value.owner;
    mosaic = Mosaic(
        MosaicId.fromId(value.mosaicId.toUint64()), value.amount.toUint64());
    priceNumerator = value.priceNumerator.toUint64();
    priceDenominator = value.priceDenominator.toUint64();
    deadline = Deadline.fromUInt64DTO(value.deadline);
  }

  OfferType type;
  String owner;
  Mosaic mosaic;
  Uint64 priceNumerator;
  Uint64 priceDenominator;
  Deadline deadline;

  Uint64 cost(Uint64 amount) {
    if (mosaic.amount < amount) {
      throw errorInvalidMosaicsOffer;
    }

    switch (type.runtimeType) {
      case _SellOffer:
        return Uint64((priceNumerator * amount).toInt().ceilToDouble() /
            priceDenominator.toDouble());
      case _BuyOffer:
        return Uint64((priceNumerator * amount).toInt().floorToDouble() /
            priceDenominator.toDouble());
      default:
        throw errUnknownOfferType;
    }
  }

  ExchangeConfirmation confirmOffer(Uint64 amount) {
    try {
      final Uint64 _cost = cost(amount);

      final Offer _offer = Offer(type, Mosaic(mosaic.assetId, amount), _cost);

      return ExchangeConfirmation(owner: owner, offer: _offer);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $type,')
      ..writeln('\t"owner": $owner')
      ..writeln('\t"mosaic": ${mosaic.toJson()}')
      ..writeln('\t"priceNumerator": $priceNumerator')
      ..writeln('\t"priceDenominator": $priceDenominator')
      ..writeln('\t"deadline": $deadline')
      ..write('}');
    return sb.toString();
  }

  static List<OfferInfo> listFromDTO(List<OfferInfoDTO> json) => json == null
      ? null
      : json.map((value) => OfferInfo.fromDTO(value)).toList();
}

class AddOffer extends Offer {
  AddOffer({Offer offer, this.duration})
      : super(offer.offerType, offer.mosaic, offer.cost);

  Uint64 duration;

//  Offer get offer => super;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $offerType,')
      ..writeln('\t"assetId": ${mosaic.assetId}')
      ..writeln('\t"amount": ${mosaic.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"duration": $duration')
      ..write('}');
    return sb.toString();
  }
}

class RemoveOffer {
  RemoveOffer({this.offerType, this.assetId});

  OfferType offerType;

  Id assetId;

  @override
  String toString() => 'type: $offerType, assetId: $assetId';
}

class ExchangeConfirmation extends Offer {
  ExchangeConfirmation({this.owner, Offer offer})
      : super(offer.offerType, offer.mosaic, offer.cost);

  String owner;

//  Offer get offer => super;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $offerType,')
      ..writeln('\t"assetId": ${mosaic.assetId}')
      ..writeln('\t"amount": ${mosaic.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"owner": $owner')
      ..write('}');
    return sb.toString();
  }
}
