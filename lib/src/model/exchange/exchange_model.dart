part of xpx_chain_sdk.exchange;

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

  Offer.fromDTO(OfferDTO dto) : assert(dto != null, 'dto must not be null') {
    offerType = dto.type;
    mosaic = Mosaic(MosaicId(id: dto.mosaicId.toUint64()), dto.cost.toUint64());
    cost = dto.cost.toUint64();
  }

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

  static List<Offer> listFromDto(List<dynamic> dto) =>
      dto == null ? null : dto.map((value) => Offer.fromDTO(value)).toList();
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

  UserExchangeInfo.fromDTO(ExchangeDTO dto) : assert(dto != null, 'dto must not be null') {
    owner = dto.owner;

    if (dto.sellOffers.isNotEmpty) {
      final sellMap = <MosaicId, OfferInfo>{};

      for (final sellDto in dto.sellOffers) {
        final offer = OfferInfo.fromDTO(sellDto);
        offer.type = sellOffer;
        offer.owner = owner;
        sellMap[MosaicId.fromId(sellDto.mosaicId.toUint64())] = offer;
      }

      offers[sellOffer] = sellMap;
    }

    if (dto.buyOffers.isNotEmpty) {
      final buyMap = <MosaicId, OfferInfo>{};

      for (final buyDto in dto.buyOffers) {
        final offer = OfferInfo.fromDTO(buyDto);
        offer.type = buyOffer;
        offer.owner = owner;
        buyMap[MosaicId.fromId(buyDto.mosaicId.toUint64())] = offer;
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
  OfferInfo.fromDTO(OfferInfoDTO dto) : assert(dto != null, 'dto must not be null') {
    type = OfferType(dto.type);
    owner = dto.owner;
    mosaic = Mosaic(MosaicId.fromId(dto.mosaicId.toUint64()), dto.amount.toUint64());
    priceNumerator = dto.priceNumerator.toUint64();
    priceDenominator = dto.priceDenominator.toUint64();
    deadline = Deadline.fromUInt64DTO(dto.deadline);
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
        return Uint64((priceNumerator * amount).toInt().ceilToDouble() / priceDenominator.toDouble());
      case _BuyOffer:
        return Uint64((priceNumerator * amount).toInt().floorToDouble() / priceDenominator.toDouble());
      default:
        throw errUnknownOfferType;
    }
  }

  ExchangeConfirmation confirmOffer(Uint64 amount) {
    try {
      final Uint64 _cost = cost(amount);

      final Offer _offer = Offer(type, Mosaic(mosaic.assetId, amount), _cost);

      return ExchangeConfirmation(owner: owner, offer: _offer);
    } on Exception {
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

  static List<OfferInfo> listFromDTO(List<OfferInfoDTO> json) =>
      json == null ? null : json.map((value) => OfferInfo.fromDTO(value)).toList();
}

class AddOffer extends Offer {
  AddOffer({Offer offer, this.duration}) : super(offer.offerType, offer.mosaic, offer.cost);

  AddOffer.fromDTO(AddOfferDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDTO(dto) {
    duration = dto.duration.toUint64();
  }

  Uint64 duration;

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

  static List<AddOffer> listFromDto(List<dynamic> dto) =>
      dto == null ? null : dto.map((value) => AddOffer.fromDTO(value)).toList();
}

class RemoveOffer {
  RemoveOffer({this.offerType, this.assetId});

  RemoveOffer.fromDTO(RemoveOfferDTO dto) : assert(dto != null, 'dto must not be null') {
    offerType = dto.offerType;
    assetId = MosaicId.fromId(dto.mosaicId.toUint64());
  }

  OfferType offerType;
  AssetId assetId;

  @override
  String toString() => 'type: $offerType, assetId: $assetId';

  static List<RemoveOffer> listFromDto(List<dynamic> dto) =>
      dto == null ? null : dto.map((value) => RemoveOffer.fromDTO(value)).toList();
}

class ExchangeConfirmation extends Offer {
  ExchangeConfirmation({this.owner, Offer offer}) : super(offer.offerType, offer.mosaic, offer.cost);

  ExchangeConfirmation.fromDTO(ConfirmationOfferDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDTO(dto) {
    owner = dto.owner;
  }

  String owner;

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

  static List<ExchangeConfirmation> listFromDto(List<dynamic> dto) =>
      dto == null ? null : dto.map((value) => ExchangeConfirmation.fromDTO(value)).toList();
}
