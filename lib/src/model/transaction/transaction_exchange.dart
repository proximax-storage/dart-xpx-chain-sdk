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
      type = TransactionType.addExchangeOffer;
      this.networkType = networkType;
      offers = addOffers;
    }
  }

  List<AddOffer> offers;

  int get size => _size();
  AbstractTransaction get abstractTransaction => _abstractTransaction();

  @override
  AbstractTransaction _abstractTransaction() => _absTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_absToString()}\n'
      '\t"offers": $offers,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['mosaic'] = offers;
    return data;
  }

  @override
  int _size() =>
      addExchangeOfferHeaderSize + offers.length * addExchangeOfferSize;

  @override
  Uint8List generateBytes() {
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
