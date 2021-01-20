part of xpx_chain_sdk.exchange;

int addExchangeOfferToArrayToBuffer(fb.Builder builder, List<AddOffer> offers) {
  final List<int> msb = List(offers.length);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic.assetId.toIntArray());
    final maV = builder.writeListUint32(offer.mosaic.amount.toIntArray());
    final dV = builder.writeListUint32(offer.duration.toIntArray());
    final cV = builder.writeListUint32(offer.cost.toIntArray());

    final txnBuilder = AddExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addDurationOffset(dV)
      ..addType(offer.offerType.value);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb);
}

int exchangeOfferToArrayToBuffer(fb.Builder builder, List<ExchangeConfirmation> offers) {
  final List<int> msb = List(offers.length);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic.assetId.toIntArray());
    final maV = builder.writeListUint32(offer.mosaic.amount.toIntArray());
    final cV = builder.writeListUint32(offer.cost.toIntArray());

    final ob = hexDecodeStringOdd(offer.owner);

    final pV = builder.writeListUint8(ob);

    final txnBuilder = ExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addOwnerOffset(pV)
      ..addType(offer.offerType.value);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb);
}

int removeExchangeOfferToArrayToBuffer(fb.Builder builder, List<RemoveOffer> offers) {
  final List<int> msb = List(offers.length);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.assetId.toIntArray());

    final txnBuilder = RemoveExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addType(offer.offerType.value);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb);
}
