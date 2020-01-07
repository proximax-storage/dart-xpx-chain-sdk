part of xpx_chain_sdk;

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
  BigInt cost;

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

class SellOffer extends OfferType {
  factory SellOffer(final int value) {
    ArgumentError.checkNotNull(value);
    return const SellOffer._();
  }

  const SellOffer._() : super(0);

  @override
  int get hashCode => 'SellOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is SellOffer && value == other.value;

  @override
  String toString() => 'sell';
}

class BuyOffer extends OfferType {
  factory BuyOffer(final int value) {
    ArgumentError.checkNotNull(value);
    return const BuyOffer._();
  }

  const BuyOffer._() : super(1);

  @override
  int get hashCode => 'SellOffer'.hashCode ^ value.hashCode;

  @override
  bool operator ==(final other) => other is SellOffer && value == other.value;

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
  BigInt priceNumerator;
  BigInt priceDenominator;
  BigInt deadline;

  BigInt cost(BigInt amount) {
    if (mosaic.amount < amount) {
      throw _errorInvalidMosaicsOffer;
    }

    switch (type.runtimeType) {
      case SellOffer:
        return BigInt.from((priceNumerator * amount).toInt().ceilToDouble() /
            priceDenominator.toDouble());
      case BuyOffer:
        return BigInt.from((priceNumerator * amount).toInt().floorToDouble() /
            priceDenominator.toDouble());
      default:
        throw _errorUnknownOfferType;
    }
  }

  ExchangeConfirmation confirmOffer(BigInt amount) {
    try {
      final BigInt _cost = cost(amount);

      final Offer _offer = Offer(type, Mosaic._(mosaic.assetId, amount), _cost);

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
  AddOffer({this.duration, OfferType type, Mosaic mosaic, BigInt cost})
      : super(type, mosaic, cost);

  BigInt duration;

  Offer get offer => super;

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

  Offer get offer => super;

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
