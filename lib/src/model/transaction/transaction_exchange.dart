part of xpx_chain_sdk.transaction;

class AddExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  AddExchangeOfferTransaction(
      Deadline deadline, List<AddOffer> addOffers, int networkType)
      : super() {
    if (addOffers == null) {
      throw errNullAddOffers;
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
    data['offers'] = offers;
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

class ExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  ExchangeOfferTransaction(Deadline deadline,
      List<ExchangeConfirmation> confirmations, int networkType)
      : super() {
    if (confirmations == null) {
      throw errNullConfirmations;
    } else {
      version = exchangeOfferVersion;
      this.deadline = deadline;
      type = TransactionType.exchangeOffer;
      this.networkType = networkType;
      this.confirmations = confirmations;
    }
  }

  List<ExchangeConfirmation> confirmations;

  int get size => _size();

  AbstractTransaction get abstractTransaction => _abstractTransaction();

  @override
  AbstractTransaction _abstractTransaction() => _absTransaction();

  @override
  String toString() => '{\n'
      '\t"abstractTransaction": ${_absToString()}\n'
      '\t"confirmations": $confirmations,\n'
      '}\n';

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['confirmations'] = confirmations;
    return data;
  }

  @override
  int _size() =>
      exchangeOfferHeaderSize + confirmations.length * exchangeOfferSize;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateVector(builder);

    final offersV = exchangeOfferToArrayToBuffer(builder, confirmations);

    final txnBuilder = ExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addOffersCount(confirmations.length)
      ..addOffersOffset(offersV);
    _buildVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();

    return exchangeOfferTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}

class RemoveExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  RemoveExchangeOfferTransaction(
      Deadline deadline, List<RemoveOffer> removeOffer, int networkType)
      : super() {
    if (removeOffer == null) {
      throw errNullRemoveOffers;
    } else {
      version = removeExchangeOfferVersion;
      this.deadline = deadline;
      type = TransactionType.removeExchangeOffer;
      this.networkType = networkType;
      offers = removeOffer;
    }
  }

  List<RemoveOffer> offers;

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
    data['offers'] = offers;
    return data;
  }

  @override
  int _size() =>
      removeExchangeOfferHeaderSize + offers.length * removeExchangeOfferSize;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateVector(builder);

    final offersV = removeExchangeOfferToArrayToBuffer(builder, offers);

    final txnBuilder = RemoveExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addOffersCount(offers.length)
      ..addOffersOffset(offersV);
    _buildVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();

    return removeExchangeOfferTransactionSchema()
        .serialize(builder.finish(codedTransfer));
  }
}
