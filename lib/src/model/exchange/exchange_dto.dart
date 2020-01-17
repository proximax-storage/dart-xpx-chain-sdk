part of xpx_chain_sdk.exchange;

class OfferInfoDTO {
  OfferInfoDTO.fromJson(Map<String, dynamic> json) : super() {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    amount = UInt64DTO.fromJson(json['amount']);
    priceDenominator = UInt64DTO.fromJson(json['initialAmount']);
    priceNumerator = UInt64DTO.fromJson(json['initialCost']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    price = json['price'];
    owner = json['owner'];
    type = json['type'];
  }

  UInt64DTO mosaicId;
  UInt64DTO amount;
  UInt64DTO priceNumerator;
  UInt64DTO priceDenominator;
  UInt64DTO deadline;
  String owner;
  int type;
  int price;

  static List<OfferInfoDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => OfferInfoDTO.fromJson(value)).toList();
}

class ExchangeDTO {
  ExchangeDTO.fromJson(Map<String, dynamic> json) {
    json = json['exchange'];
    owner = json['owner'];
    buyOffers = OfferInfoDTO.listFromJson(json['buyOffers']);
    sellOffers = OfferInfoDTO.listFromJson(json['sellOffers']);
  }

  String owner;
  List<OfferInfoDTO> buyOffers;
  List<OfferInfoDTO> sellOffers;
}
