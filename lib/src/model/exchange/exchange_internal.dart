part of xpx_chain_sdk.exchange;

int addExchangeOfferToArrayToBuffer(fb.Builder builder, List<AddOffer> offers) {
  final List<int> msb = List(offers.length);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic.assetId.toArray());
    final maV = builder.writeListUint32(offer.mosaic.amount.toIntArray());
    final dV = builder.writeListUint32(offer.duration.toIntArray());
    final cV = builder.writeListUint32(offer.cost.toIntArray());

    final txnBuilder = AddExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addDurationOffset(dV)
      ..addType(offer.type.value);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb);
}
