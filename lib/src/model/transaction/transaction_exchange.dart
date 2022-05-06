/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class AddExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  AddExchangeOfferTransaction(
      Deadline deadline, List<AddOffer> addOffers, NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.addExchangeOffer,
            addExchangeOfferVersion, maxFee) {
    if (addOffers.isEmpty) {
      throw errNullAddOffers;
    } else {
      offers = addOffers;
    }
  }

  AddExchangeOfferTransaction.fromDTO(AddExchangeOfferTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    offers = AddOffer.listFromDto(dto.transaction!.offers);
  }

  List<AddOffer>? offers;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    val['offers'] = offers;
    return val;
  }

  @override
  int size() =>
      addExchangeOfferHeaderSize + offers!.length * addExchangeOfferSize;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateCommonVector(builder);

    final offersV = addExchangeOfferToArrayToBuffer(builder, offers!);

    final txnBuilder = $buffer.ExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addOffersCount(offers!.length)
      ..addOffersOffset(offersV);
    _buildCommonVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();
    builder.finish(codedTransfer);
    return addExchangeOfferTransactionSchema().serialize(builder.buffer);
  }
}

class ExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  ExchangeOfferTransaction(Deadline deadline,
      List<ExchangeConfirmation> confirmations, NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.exchangeOffer,
            exchangeOfferVersion, maxFee) {
    if (confirmations.isEmpty) {
      throw errNullConfirmations;
    } else {
      this.confirmations = confirmations;
    }
  }

  ExchangeOfferTransaction.fromDTO(ExchangeOfferTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    confirmations = ExchangeConfirmation.listFromDto(dto.transaction!.offers);
  }

  List<ExchangeConfirmation>? confirmations;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    val['confirmations'] = confirmations;
    return val;
  }

  @override
  int size() =>
      exchangeOfferHeaderSize + confirmations!.length * exchangeOfferSize;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateCommonVector(builder);

    final offersV = exchangeOfferToArrayToBuffer(builder, confirmations!);

    final txnBuilder = $buffer.ExchangeOfferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addOffersCount(confirmations!.length)
      ..addOffersOffset(offersV);
    _buildCommonVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();
    builder.finish(codedTransfer);
    return exchangeOfferTransactionSchema().serialize(builder.buffer);
  }
}

class RemoveExchangeOfferTransaction extends AbstractTransaction
    implements Transaction {
  RemoveExchangeOfferTransaction(
      Deadline deadline, List<RemoveOffer> removeOffer, NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.removeExchangeOffer,
            removeExchangeOfferVersion, maxFee) {
    if (removeOffer.isEmpty) {
      throw errNullRemoveOffers;
    } else {
      offers = removeOffer;
    }
  }

  RemoveExchangeOfferTransaction.fromDTO(
      RemoveExchangeOfferTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    offers = RemoveOffer.listFromDto(dto.transaction!.offers);
  }

  List<RemoveOffer>? offers;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  AbstractTransaction absTransaction() => _absTransaction();

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
  int size() =>
      removeExchangeOfferHeaderSize + offers!.length * removeExchangeOfferSize;

  @override
  TransactionType entityType() => type;

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final vectors = _generateCommonVector(builder);

    final offersV = removeExchangeOfferToArrayToBuffer(builder, offers!);

    final txnBuilder =
        $buffer.RemoveExchangeOfferTransactionBufferBuilder(builder)
          ..begin()
          ..addSize(size())
          ..addOffersCount(offers!.length)
          ..addOffersOffset(offersV);
    _buildCommonVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();
    builder.finish(codedTransfer);
    return removeExchangeOfferTransactionSchema().serialize(builder.buffer);
  }
}
