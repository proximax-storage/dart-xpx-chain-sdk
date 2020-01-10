part of xpx_chain_sdk.exchange;

final OfferType sellOffer = _SellOffer();

final OfferType buyOffer = _BuyOffer();

abstract class OfferType implements Comparable<OfferType> {
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
  Offer(this.type, this.mosaic, this.cost);

  OfferType type;
  Mosaic mosaic;
  Uint64 cost;

  @override
  int get hashCode => type.hashCode ^ mosaic.hashCode ^ cost.hashCode;

  @override
  bool operator ==(final other) =>
      other is Offer &&
      runtimeType == other.runtimeType &&
      type == other.type &&
      mosaic == other.mosaic &&
      cost == other.cost;

  @override
  int compareTo(final Offer other) => type.compareTo(other.type);

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $type,')
      ..writeln('\t"mosaic": $mosaic')
      ..writeln('\t"cost": $cost')
      ..write('}');
    return sb.toString();
  }
}

class _SellOffer extends OfferType {
  factory _SellOffer() => const _SellOffer._();

  const _SellOffer._() : super(0);

  @override
  int get hashCode => 'SellOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is _SellOffer && value == other.value;

  @override
  String toString() => 'sell';
}

class _BuyOffer extends OfferType {
  factory _BuyOffer() => const _BuyOffer._();

  const _BuyOffer._() : super(1);

  @override
  int get hashCode => 'SellOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is _SellOffer && value == other.value;

  @override
  String toString() => 'sell';
}

class UserExchangeInfo {
  UserExchangeInfo({this.owner, this.offers});

  PublicAccount owner;

  Map<OfferType, Map<MosaicId, OfferInfo>> offers;

  @override
  String toString() => 'owner: $owner, offers: $offers';
}

class OfferInfo {
  OfferType type;
  PublicAccount owner;
  Mosaic mosaic;
  Uint64 priceNumerator;
  Uint64 priceDenominator;
  Uint64 deadline;

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
        throw errorUnknownOfferType;
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
      ..writeln('\t"mosaic": $mosaic')
      ..writeln('\t"priceNumerator": $priceNumerator')
      ..writeln('\t"priceDenominator": $priceDenominator')
      ..writeln('\t"deadline": $deadline')
      ..write('}');
    return sb.toString();
  }
}

class AddOffer extends Offer {
  AddOffer({this.duration, OfferType type, Mosaic mosaic, Uint64 cost})
      : super(type, mosaic, cost);

  Uint64 duration;

//  Offer get offer => super;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $type,')
      ..writeln('\t"assetId": ${mosaic.assetId}')
      ..writeln('\t"amount": ${mosaic.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"duration": $duration')
      ..write('}');
    return sb.toString();
  }
}

class RemoveOffer {
  RemoveOffer({this.type, this.assetId});

  OfferType type;

  Id assetId;

  @override
  String toString() => 'type: $type, assetId: $assetId';
}

class ExchangeConfirmation extends Offer {
  ExchangeConfirmation({this.owner, Offer offer})
      : super(offer.type, offer.mosaic, offer.cost);

  PublicAccount owner;

//  Offer get offer => super;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": $type,')
      ..writeln('\t"assetId": ${mosaic.assetId}')
      ..writeln('\t"amount": ${mosaic.amount}')
      ..writeln('\t"cost": $cost')
      ..writeln('\t"owner": $owner')
      ..write('}');
    return sb.toString();
  }
}
