part of xpx_chain_sdk;

class AddExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  AddExchangeOfferTransaction(
      Deadline deadline, List<AddOffer> addOffers, int networkType)
      : super._() {
    if (addOffers == null) {
      throw _errNullRecipient;
    } else {
      version = _addExchangeOfferVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16733);
      this.networkType = networkType;
      offers = addOffers;
    }
  }

  List<AddOffer> offers;

  @override
  AbstractTransaction getAbstractTransaction() => _getAbstractTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_abstractTransactionToString()}\n'
      '\t"offers": $offers,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _abstractTransactionToJson();
    data['mosaic'] = offers;
    return data;
  }

  @override
  int _size() =>
      addExchangeOfferHeaderSize + offers.length * addExchangeOfferSize;

  @override
  Uint8List _generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateVector(builder);

    final offersV = addExchangeOfferToArrayToBuffer(builder, offers);

    final txnBuilder = ExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addOffersCount(offers.length)
      ..addOffersOffset(offersV);
    _buildVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();

    return addExchangeOfferTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

int addExchangeOfferToArrayToBuffer(fb.Builder builder, List<AddOffer> offers) {
  final msb = <int>[];
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic.assetId.toArray());
    final maV = builder.writeListUint32(bigIntToArray(offer.mosaic.amount));
    final dV = builder.writeListUint32(bigIntToArray(offer.duration));
    final cV = builder.writeListUint32(bigIntToArray(offer.cost));

    final txnBuilder = AddExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addDurationOffset(dV)
      ..addType(offer.type.value);

    msb.add(txnBuilder.finish());
  }
  return builder.writeList(msb);
}
