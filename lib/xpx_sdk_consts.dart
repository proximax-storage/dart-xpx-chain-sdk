part of xpx_catapult_sdk;

final PrxNamespaceId =
    new UInt64DTO(Int64(2339353534), Int64(2976741373)).toBigInt();

final XpxMosaicId =
    new UInt64DTO(Int64(481110499), Int64(231112638)).toBigInt();

enum NamespaceType { Root, Sub }

enum MosaicSupplyType { Decrease, Increase }

const Decrease = MosaicSupplyType.Decrease,
    Increase = MosaicSupplyType.Increase;
