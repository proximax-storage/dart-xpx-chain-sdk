part of xpx_chain_sdk.transaction;

class AddExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  AddExchangeOfferTransaction(
      Deadline deadline, List<AddOffer> addOffers, int networkType)
      : super() {
    if (addOffers == null) {
      throw errNullRecipient;
    } else {
      version = addExchangeOfferVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16733);
      this.networkType = networkType;
      offers = addOffers;
    }
  }

  List<AddOffer> offers;

  @override
  AbstractTransaction getAbstractTransaction() => abstractTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${abstractTransactionToString()}\n'
      '\t"offers": $offers,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    data['mosaic'] = offers;
    return data;
  }

  @override
  int size() =>
      addExchangeOfferHeaderSize + offers.length * addExchangeOfferSize;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = generateVector(builder);

    final offersV = addExchangeOfferToArrayToBuffer(builder, offers);

    final txnBuilder = ExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addOffersCount(offers.length)
      ..addOffersOffset(offersV);
    buildVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();

    return addExchangeOfferTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}
