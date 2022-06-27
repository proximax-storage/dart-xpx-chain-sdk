/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.exchange;

int addExchangeOfferToArrayToBuffer(fb.Builder builder, List<AddOffer> offers) {
  final List<int?> msb = List.filled(offers.length, null, growable: false);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic!.assetId.toIntArray());
    final maV = builder.writeListUint32(offer.mosaic!.amount.toIntArray());
    final dV = builder.writeListUint32(offer.duration!.toIntArray());
    final cV = builder.writeListUint32(offer.cost!.toIntArray());

    final txnBuilder = AddExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addDurationOffset(dV)
      ..addType(offer.offerType!.value!);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb as List<int>);
}

int exchangeOfferToArrayToBuffer(fb.Builder builder, List<ExchangeConfirmation> offers) {
  final List<int?> msb = List.filled(offers.length, null, growable: false);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.mosaic!.assetId.toIntArray());
    final maV = builder.writeListUint32(offer.mosaic!.amount.toIntArray());
    final cV = builder.writeListUint32(offer.cost!.toIntArray());

    final ob = hexDecodeStringOdd(offer.owner!);

    final pV = builder.writeListUint8(ob);

    final txnBuilder = ExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addMosaicAmountOffset(maV)
      ..addCostOffset(cV)
      ..addOwnerOffset(pV)
      ..addType(offer.offerType!.value!);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb as List<int>);
}

int removeExchangeOfferToArrayToBuffer(fb.Builder builder, List<RemoveOffer> offers) {
  final List<int?> msb = List.filled(offers.length, null, growable: false);
  int i = 0;
  for (final offer in offers) {
    final mV = builder.writeListUint32(offer.assetId!.toIntArray());

    final txnBuilder = RemoveExchangeOfferBufferBuilder(builder)
      ..begin()
      ..addMosaicIdOffset(mV)
      ..addType(offer.offerType!.value!);

    msb[i] = txnBuilder.finish();
    i++;
  }
  return builder.writeList(msb as List<int>);
}
