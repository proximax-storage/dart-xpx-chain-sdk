/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.exchange;

final OfferType sellOffer = _SellOffer();

final OfferType buyOffer = _BuyOffer();

class OfferType implements Comparable<OfferType> {
  const OfferType(this.value);

  final int? value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(final other) => other is OfferType && value == other.value;

  @override
  int compareTo(final OfferType other) => value!.compareTo(other.value!);

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

  Offer.fromDTO(OfferDTO dto) {
    offerType = dto.type;
    mosaic = Mosaic(MosaicId(dto.mosaicId.toUint64()), dto.cost.toUint64());
    cost = dto.cost.toUint64();
  }

  OfferType? offerType;
  Mosaic? mosaic;
  Uint64? cost;

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
  int compareTo(final Offer other) => offerType!.compareTo(other.offerType!);

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

  static List<Offer> listFromDto(List<OfferDTO> dto) => dto.isEmpty ? [] : dto.map(Offer.fromDTO).toList();
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

  UserExchangeInfo.fromDTO(ExchangeDTO dto) {
    owner = dto.owner;

    if (dto.sellOffers!.isNotEmpty) {
      final sellMap = <MosaicId, OfferInfo>{};

      for (final sellDto in dto.sellOffers!) {
        final offer = OfferInfo.fromDTO(sellDto);
        offer.type = sellOffer;
        offer.owner = owner;
        sellMap[MosaicId(sellDto.mosaicId.toUint64())] = offer;
      }

      offers![sellOffer] = sellMap;
    }

    if (dto.buyOffers!.isNotEmpty) {
      final buyMap = <MosaicId, OfferInfo>{};

      for (final buyDto in dto.buyOffers!) {
        final offer = OfferInfo.fromDTO(buyDto);
        offer.type = buyOffer;
        offer.owner = owner;
        buyMap[MosaicId(buyDto.mosaicId.toUint64())] = offer;
      }

      offers![buyOffer] = buyMap;
    }
  }

  String? owner;
  Map<OfferType, Map<MosaicId, OfferInfo>>? offers = {};

  List<OfferInfo> get sellOffers => _offersToList(offers![sellOffer]);

  List<OfferInfo> get buyOffers => _offersToList(offers![buyOffer]);

  List<OfferInfo> _offersToList(Map<MosaicId, OfferInfo>? offer) {
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
  OfferInfo.fromDTO(OfferInfoDTO dto) {
    type = OfferType(dto.type);
    owner = dto.owner;
    mosaic = Mosaic(MosaicId(dto.mosaicId.toUint64()), dto.amount.toUint64());
    priceNumerator = dto.priceNumerator.toUint64();
    priceDenominator = dto.priceDenominator.toUint64();
    deadline = Deadline.fromUInt64DTO(dto.deadline);
  }

  OfferType? type;
  String? owner;
  late Mosaic mosaic;
  Uint64? priceNumerator;
  Uint64? priceDenominator;
  Deadline? deadline;

  Uint64 cost(Uint64 amount) {
    if (mosaic.amount < amount) {
      throw errorInvalidMosaicsOffer;
    }

    switch (type.runtimeType) {
      case _SellOffer:
        return Uint64((priceNumerator! * amount).toInt().ceilToDouble() / priceDenominator!.toDouble());
      case _BuyOffer:
        return Uint64((priceNumerator! * amount).toInt().floorToDouble() / priceDenominator!.toDouble());
      default:
        throw errUnknownOfferType;
    }
  }

  ExchangeConfirmation confirmOffer(Uint64 amount) {
    try {
      final Uint64 _cost = cost(amount);

      final Offer _offer = Offer(type, Mosaic(mosaic.assetId, amount), _cost);

      return ExchangeConfirmation(_offer, owner: owner);
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

  static List<OfferInfo> listFromDTO(List<OfferInfoDTO>? json) =>
      json == null ? [] : json.map(OfferInfo.fromDTO).toList();
}

class AddOffer extends Offer {
  AddOffer({required Offer offer, this.duration}) : super(offer.offerType, offer.mosaic, offer.cost);

  AddOffer.fromDTO(AddOfferDTO dto) : super.fromDTO(dto) {
    duration = dto.duration.toUint64();
  }

  Uint64? duration;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $offerType,')
      ..writeln('\t"assetId": ${mosaic!.assetId}')
      ..writeln('\t"amount": ${mosaic!.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"duration": $duration')
      ..write('}');
    return sb.toString();
  }

  static List<AddOffer>? listFromDto(List<AddOfferDTO>? dto) => dto == null ? null : dto.map(AddOffer.fromDTO).toList();
}

class RemoveOffer {
  RemoveOffer({this.offerType, this.assetId});

  RemoveOffer.fromDTO(RemoveOfferDTO dto) {
    offerType = dto.offerType;
    assetId = MosaicId(dto.mosaicId.toUint64());
  }

  OfferType? offerType;
  AssetId? assetId;

  @override
  String toString() => 'type: $offerType, assetId: $assetId';

  static List<RemoveOffer>? listFromDto(List<RemoveOfferDTO>? dto) =>
      dto == null ? null : dto.map(RemoveOffer.fromDTO).toList();
}

class ExchangeConfirmation extends Offer {
  ExchangeConfirmation(Offer offer, {this.owner}) : super(offer.offerType, offer.mosaic, offer.cost);

  ExchangeConfirmation.fromDTO(ConfirmationOfferDTO dto) : super.fromDTO(dto) {
    owner = dto.owner;
  }

  String? owner;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $offerType,')
      ..writeln('\t"assetId": ${mosaic!.assetId}')
      ..writeln('\t"amount": ${mosaic!.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"owner": $owner')
      ..write('}');
    return sb.toString();
  }

  static List<ExchangeConfirmation>? listFromDto(List<ConfirmationOfferDTO>? dto) =>
      dto == null ? null : dto.map(ExchangeConfirmation.fromDTO).toList();
}
