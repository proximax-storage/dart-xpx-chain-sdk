/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class OfferDTO {
  OfferDTO.fromJson(Map<String, dynamic> json) {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    mosaicAmount = UInt64DTO.fromJson(json['mosaicAmount']);
    cost = UInt64DTO.fromJson(json['cost']);
    type = OfferType(json['type']);
  }

  late UInt64DTO mosaicId;
  UInt64DTO? mosaicAmount;
  late UInt64DTO cost;
  OfferType? type;
}

class RemoveOfferDTO {
  RemoveOfferDTO.fromJson(json) {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    offerType = OfferType(json['offerType']);
  }

  late UInt64DTO mosaicId;
  OfferType? offerType;

  static List<RemoveOfferDTO> listFromJson(List<dynamic>? json) =>
      json == null ? [] : json.map(RemoveOfferDTO.fromJson).toList();
}

class AddOfferDTO extends OfferDTO {
  AddOfferDTO.fromJson(json) : super.fromJson(json) {
    duration = UInt64DTO.fromJson(json['duration']);
  }

  late UInt64DTO duration;

  static List<AddOfferDTO> listFromJson(List<dynamic>? json) =>
      json == null ? [] : json.map(AddOfferDTO.fromJson).toList();
}

class ConfirmationOfferDTO extends OfferDTO {
  ConfirmationOfferDTO.fromJson(json) : super.fromJson(json) {
    owner = json['owner'];
  }

  String? owner;

  static List<ConfirmationOfferDTO> listFromJson(List<dynamic>? json) =>
      json == null ? [] : json.map(ConfirmationOfferDTO.fromJson).toList();
}

class OfferInfoDTO {
  OfferInfoDTO.fromJson(json) : super() {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    amount = UInt64DTO.fromJson(json['amount']);
    priceDenominator = UInt64DTO.fromJson(json['initialAmount']);
    priceNumerator = UInt64DTO.fromJson(json['initialCost']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    price = json['price'];
    owner = json['owner'];
    type = json['type'];
  }

  late UInt64DTO mosaicId;
  late UInt64DTO amount;
  late UInt64DTO priceNumerator;
  late UInt64DTO priceDenominator;
  late UInt64DTO deadline;
  String? owner;
  int? type;
  int? price;

  static List<OfferInfoDTO> listFromJson(List<dynamic>? json) =>
      json == null ? [] : json.map(OfferInfoDTO.fromJson).toList();
}

class ExchangeDTO {
  ExchangeDTO.fromJson(Map<String, dynamic> json) {
    json = json['exchange'];
    owner = json['owner'];
    buyOffers = OfferInfoDTO.listFromJson(json['buyOffers']);
    sellOffers = OfferInfoDTO.listFromJson(json['sellOffers']);
  }

  String? owner;
  List<OfferInfoDTO>? buyOffers;
  List<OfferInfoDTO>? sellOffers;
}

class ExchangeOfferTransactionInfoDTO {
  ExchangeOfferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? ExchangeOfferTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  ExchangeOfferTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class ExchangeOfferTransactionDTO extends AbstractTransactionDTO {
  ExchangeOfferTransactionDTO(
      {String? signature, String? signer, int? version, int? type, List<int>? maxFee, List<int>? deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  ExchangeOfferTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    offers = ConfirmationOfferDTO.listFromJson(json['offers']);
  }

  List<ConfirmationOfferDTO>? offers;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['owner'] = offers;
    return data;
  }
}

class AddExchangeOfferTransactionInfoDTO {
  AddExchangeOfferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? AddExchangeOfferTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  AddExchangeOfferTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class AddExchangeOfferTransactionDTO extends AbstractTransactionDTO {
  AddExchangeOfferTransactionDTO(
      {String? signature, String? signer, int? version, int? type, List<int>? maxFee, List<int>? deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  AddExchangeOfferTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    offers = AddOfferDTO.listFromJson(json['offers']);
  }

  List<AddOfferDTO>? offers;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    return data;
  }
}

class RemoveExchangeOfferTransactionInfoDTO {
  RemoveExchangeOfferTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? RemoveExchangeOfferTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO? meta;
  RemoveExchangeOfferTransactionDTO? transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class RemoveExchangeOfferTransactionDTO extends AbstractTransactionDTO {
  RemoveExchangeOfferTransactionDTO(
      {String? signature, String? signer, int? version, int? type, List<int>? maxFee, List<int>? deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  RemoveExchangeOfferTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    offers = RemoveOfferDTO.listFromJson(json['offers']);
  }

  List<RemoveOfferDTO>? offers;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['offers'] = offers;

    return data;
  }
}
