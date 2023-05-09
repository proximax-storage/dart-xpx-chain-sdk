/*
 * Copyright 2023 ProximaX
 * Copyright 2019 NEM
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of xpx_chain_sdk.model.utils;

/*
 * @internal
 * @param transactionBinary - The transaction binary data
 * @returns {Transaction}
 * @constructor
 */
Transaction createTransactionFromPayload(String transactionBinary) {
  // Transaction byte size data
  const sizeLength = 8;
  const signatureLength = 128;
  const publicKeyLength = 64;
  const versionLength = 8;
  const typeLength = 4;
  const feeLength = 16;
  const deadlineLength = 16;

  // Transaction byte data positions
  const signatureOffset = sizeLength;
  const publicKeyOffset = signatureOffset + signatureLength;
  const versionOffset = publicKeyOffset + publicKeyLength;
  const typeOffset = versionOffset + versionLength;
  const feeOffset = typeOffset + typeLength;
  const deadlineOffset = feeOffset + feeLength;
  const transactionOffset = deadlineOffset + deadlineLength;

  // Transaction byte data
  final networkType =
      extractNetwork(transactionBinary.substring(versionOffset, typeOffset));
  final type =
      extractNumberFromHex(transactionBinary.substring(typeOffset, feeOffset));
  final deadline = Uint64.fromHex(
      reverse(transactionBinary.substring(deadlineOffset, transactionOffset)));
  final transactionData = transactionBinary.substring(transactionOffset);

  return createTransaction(type, transactionData, networkType, deadline);
}

/*
 * @internal
 * @param hexValue - Hex representation of the number
 * @returns {number}
 */
int extractValueSizeDelta(String hexValue) => hexToInt(hexReverse(hexValue));

/*
 * @internal
 * @param hex
 * @returns {string}
 */
String hexReverse(String hexString) {
  if (hexString.length % 2 != 0) {
    hexString = '0' + hexString;
  }
  final uint8Array = hex.decode(hexString);
  return uint8ListToHex(reverseUint8List(uint8Array));
}

/*
 * @internal
 * @param innerTransactionBinary - Inner transaction binary data
 * @returns {Array}
 */
List<String> parseInnerTransactionFromBinary(String innerTransactionBinary) {
  List<String> embeddedTransaction = [];
  String innerBinary = innerTransactionBinary;

  while (innerBinary.isNotEmpty) {
    final payloadSize = extractNumberFromHex(innerBinary.substring(0, 8)) * 2;
    final innerTransaction = innerBinary.substring(8, payloadSize);
    embeddedTransaction.add(innerTransaction);
    innerBinary = innerBinary.substring(payloadSize);
  }
  return embeddedTransaction;
}

/*
 * @internal
 * @param messageType - Message Type
 * @param payload - Message Payload
 * @returns {Message}
 */
Message extractMessage(MessageType messageType, String payload) {
  if (messageType == MessageType.unencrypted) {
    return PlainMessage(payload: payload);
  } else if (messageType == MessageType.encrypted) {
    return EncryptedMessage.fromPayload(payload);
  } else {
    throw Exception('Invalid message type');
  }
}

/*
 * @internal
 * @param hexValue - Hex representation of the number
 * @returns {number}
 */
int extractNumberFromHex(String hexValue) =>
    int.parse(uint8ListToHex(reverseUint8List(hex.decode(hexValue))),
        radix: 16);

/*
 * @internal
 * @param hex - Hex input
 * @returns {string}
 */
String decodeHexUtf8(String hex) {
  String str = decodeHexRaw(hex);
  return utf8.decode(str.codeUnits);
}

/*
 * @internal
 * @param hex - Hex input
 * @returns {string}
 */
String decodeHexRaw(String hex) {
  final buffer = StringBuffer();
  for (int i = 0; i < hex.length; i += 2) {
    buffer.writeCharCode(int.parse(hex.substring(i, i + 2), radix: 16));
  }
  return buffer.toString();
}

/*
 * @internal
 * @param versionHex - Transaction version in hex
 * @returns {NetworkType}
 */
NetworkType extractNetwork(String versionHex) {
  final networkType = hexToUint8List(versionHex)[3];
  print(networkType);
  if (networkType == 184) {
    return NetworkType.PUBLIC;
  } else if (networkType == 168) {
    return NetworkType.PUBLIC_TEST;
  } else if (networkType == 96) {
    return NetworkType.MIJIN;
  } else if (networkType == 144) {
    return NetworkType.MIJIN_TEST;
  } else if (networkType == 200) {
    return NetworkType.PRIVATE;
  } else if (networkType == 176) {
    return NetworkType.PRIVATE_TEST;
  }
  throw Exception('Unimplemented network type');
}

/*
 * @internal
 * @param hex
 * @returns {string}
 */
String reverse(String hexString) =>
    uint8ListToHex(reverseUint8List(hex.decode(hexString)));

/*
 * @internal
 * @param type - Transaction type
 * @param transactionData - Details per specific transaction type
 * @param networkType - Network type
 * @param deadline - Deadline
 * @returns {Transaction}
 */
Transaction createTransaction(int type, String transactionData,
    NetworkType networkType, Uint64 deadlineUint64) {
  final deadline = Deadline.fromUInt64DTO(UInt64DTO(
      Int32(deadlineUint64.toIntArray()[0]),
      Int32(deadlineUint64.toIntArray()[1])));
  if (type == TransactionType.addressAlias) {
    final addressAliasAction = transactionData.substring(0, 2);
    final addressAliasNamespaceId = transactionData.substring(2, 18);
    final addressAliasAddress = transactionData.substring(18);
    return AddressAliasTransaction(
        deadline,
        Address.fromEncoded(addressAliasAddress),
        NamespaceId.fromHex(reverse(addressAliasNamespaceId)),
        AliasActionType.aliasLink == extractNumberFromHex(addressAliasAction)
            ? AliasActionType.aliasLink
            : AliasActionType.aliasUnlink,
        networkType);
  } else if (type == TransactionType.mosaicAlias) {
    const mosaicAliasActionLength = 2;

    // read bytes
    final mosaicAliasAction =
        transactionData.substring(0, mosaicAliasActionLength);
    final mosaicAliasNamespaceId =
        transactionData.substring(mosaicAliasActionLength, 18);
    final mosaicAliasMosaicId = transactionData.substring(18);
    return MosaicAliasTransaction(
        deadline,
        MosaicId.fromHex(reverse(mosaicAliasMosaicId)),
        NamespaceId.fromHex(reverse(mosaicAliasNamespaceId)),
        AliasActionType.aliasLink == extractNumberFromHex(mosaicAliasAction)
            ? AliasActionType.aliasLink
            : AliasActionType.aliasUnlink,
        networkType);
  } else if (type == TransactionType.mosaicDefinition) {
    const mosaicDefMosaicNonceLength = 8;
    const mosaicDefMosaicIdLength = 16;
    const mosaicDefPropsNumLength = 2;
    const mosaicDefPropsFlagsLength = 2;
    const mosaicDefDivisibilityLength = 2;
    /*  const mosaicDefDurationIndLength = 2; */

    const mosaicIdOffset = mosaicDefMosaicNonceLength;
    const propsOffset = mosaicIdOffset + mosaicDefMosaicIdLength;
    const flagsOffset = propsOffset + mosaicDefPropsNumLength;
    const divisibilityOffset = flagsOffset + mosaicDefPropsFlagsLength;
    const durationIndOffset = divisibilityOffset + mosaicDefDivisibilityLength;
    /* const durationOffset = durationIndOffset + mosaicDefDurationIndLength; */

    // read bytes
    final mosaicNonce =
        transactionData.substring(0, mosaicDefMosaicNonceLength);
    final mosaicId = transactionData.substring(mosaicIdOffset, propsOffset);
    final flags = extractNumberFromHex(
        transactionData.substring(flagsOffset, divisibilityOffset));
    final divisibility =
        transactionData.substring(divisibilityOffset, durationIndOffset);
    /* final duration = transactionData.substring(durationOffset); */

    final regexArray = RegExp('.{1,2}')
        .allMatches(mosaicNonce)
        .map((match) => match.group(0))
        .toList();

    final nonceArray = regexArray.map((n) => extractNumberFromHex(n!)).toList();

    return MosaicDefinitionTransaction.createWithMosaicId(
        deadline,
        MosaicNonce(Uint8List.fromList(nonceArray)),
        MosaicId.fromHex(reverse(mosaicId)),
        MosaicProperties.create(
            supplyMutable: (flags & 1) == 1,
            transferable: (flags & 2) == 2,
            divisibility: extractNumberFromHex(divisibility)),
        networkType);
  } else if (type == TransactionType.mosaicSupplyChange) {
    final mosaicSupMosaicId = transactionData.substring(0, 16);
    final mosaicSupDirection = transactionData.substring(16, 18);
    final delta = transactionData.substring(18, 34);
    return MosaicSupplyChangeTransaction.create(
        deadline,
        MosaicSupplyType.increase.index ==
                extractNumberFromHex(mosaicSupDirection)
            ? MosaicSupplyType.increase
            : MosaicSupplyType.decrease,
        MosaicId.fromHex(reverse(mosaicSupMosaicId)),
        Uint64.fromHex(reverse(delta)),
        networkType);
  } else if (type == TransactionType.registerNamespace) {
    final namespaceType = extractNumberFromHex(transactionData.substring(0, 2));
    final nameSpaceDurationParentId = transactionData.substring(2, 18);
    /* final nameSpaceId = NamespaceId.createFromEncoded(transactionData.substring(18, 34)); */
    /* final nameSize = transactionData.substring(34, 36); */
    final nameSpaceName = transactionData.substring(36);

    return namespaceType == NamespaceType.root
        ? RegisterNamespaceTransaction.createRoot(
            deadline,
            decodeHexUtf8(nameSpaceName),
            Uint64.fromHex(reverse(nameSpaceDurationParentId)),
            networkType)
        : RegisterNamespaceTransaction.createSub(
            deadline,
            decodeHexUtf8(nameSpaceName),
            Uint64.fromHex(reverse(nameSpaceDurationParentId)).toString(),
            networkType);
  } else if (type == TransactionType.accountPropertyAddress ||
      type == TransactionType.accountPropertyEntityType ||
      type == TransactionType.accountPropertyEntityType) {
    const propertyTypeLength = 2;

    const modificationCountOffset = propertyTypeLength;
    const modificationArrayOffset =
        modificationCountOffset + propertyTypeLength;

    // read bytes
    final propertyType = transactionData.substring(0, propertyTypeLength);
    final modifications = transactionData.substring(
        modificationArrayOffset, transactionData.length);
    final modificationArray = RegExp('.{1,52}')
        .allMatches(modifications)
        .map((m) => m.group(0))
        .toList();
    if (type == TransactionType.accountPropertyAddress) {
      return AccountPropertiesAddressTransaction(
          deadline,
          AccountPropertyType.fromInt(extractNumberFromHex(propertyType)),
          modificationArray
              .map((modification) => AccountPropertiesAddressModification(
                  PropertyModificationType.addProperty ==
                          extractNumberFromHex(modification!.substring(0, 2))
                      ? PropertyModificationType.addProperty
                      : PropertyModificationType.removeProperty,
                  Address.fromEncoded(modification.substring(2))))
              .toList(),
          networkType);
    } else if (type == TransactionType.accountPropertyMosaic) {
      return AccountPropertiesMosaicTransaction(
          deadline,
          AccountPropertyType.fromInt(extractNumberFromHex(propertyType)),
          modificationArray
              .map((modification) => AccountPropertiesMosaicModification(
                  PropertyModificationType.addProperty ==
                          extractNumberFromHex(modification!.substring(0, 2))
                      ? PropertyModificationType.addProperty
                      : PropertyModificationType.removeProperty,
                  MosaicId.fromHex(
                      reverse(modification.substring(2, modification.length)))))
              .toList(),
          networkType);
    } else if (type == TransactionType.accountPropertyEntityType) {
      return AccountPropertiesEntityTypeTransaction(
          deadline,
          AccountPropertyType.fromInt(extractNumberFromHex(propertyType)),
          modificationArray
              .map((modification) => AccountPropertiesEntityTypeModification(
                  PropertyModificationType.addProperty ==
                          extractNumberFromHex(modification!.substring(0, 2))
                      ? PropertyModificationType.addProperty
                      : PropertyModificationType.removeProperty,
                  TransactionType.fromInt(extractNumberFromHex(
                      modification.substring(2, modification.length)))))
              .toList(),
          networkType);
    } else {
      throw Exception('Invalid txn type');
    }
  } else if (type == TransactionType.transfer) {
    // read bytes
    final transferRecipient = transactionData.substring(0, 50);
    final transferMessageSize =
        extractNumberFromHex(transactionData.substring(50, 54));

    final transferMessageAndMosaicSubString = transactionData.substring(56);
    final transferMessageType =
        extractNumberFromHex(transferMessageAndMosaicSubString.substring(0, 2));
    final transferMessage = transferMessageAndMosaicSubString.substring(
        2, (transferMessageSize - 1) * 2 + 2);
    final transferMosaic =
        transferMessageAndMosaicSubString.substring(transferMessageSize * 2);
    final transferMosaicArray = RegExp('.{1,32}')
        .allMatches(transferMosaic)
        .map((m) => m.group(0))
        .toList();
    return TransferTransaction.create(
        deadline,
        Address.fromEncoded(transferRecipient),
        transferMosaicArray
            .map((mosaic) => Mosaic(
                MosaicId.fromHex(reverse(mosaic!.substring(0, 16))),
                Uint64.fromHex(reverse(mosaic.substring(16)))))
            .toList(),
        extractMessage(
            MessageType.getType(transferMessageType), transferMessage),
        networkType);
  } else if (type == TransactionType.modifyMultisig) {
    final minRemovalDelta =
        extractNumberFromHex(transactionData.substring(0, 2));
    final minApprovalDelta =
        extractNumberFromHex(transactionData.substring(2, 4));
    /* final modificationsCount =
        extractNumberFromHex(transactionData.substring(4, 6)); */

    final multiSigModificationSubString = transactionData.substring(6);
    final multiSigModificationArray = RegExp('.{1,66}')
        .allMatches(multiSigModificationSubString)
        .map((match) => match.group(0))
        .toList();

    return ModifyMultisigAccountTransaction.create(
        deadline,
        minApprovalDelta,
        minRemovalDelta,
        multiSigModificationArray
            .map((modification) => MultisigCosignatoryModification(
                  MultisigCosignatoryModificationType.add ==
                          extractNumberFromHex(modification!.substring(0, 2))
                      ? MultisigCosignatoryModificationType.add
                      : MultisigCosignatoryModificationType.remove,
                  PublicAccount.fromPublicKey(
                      modification.substring(2), networkType),
                ))
            .toList(),
        networkType);
  } else if (type == TransactionType.aggregateCompleted) {
    final payloadSize =
        extractNumberFromHex(transactionData.substring(0, 8)) * 2;
    /* final cosignatures = transactionData.substring(payloadSize + 8); */

    final innerTransactionArray = parseInnerTransactionFromBinary(
        transactionData.substring(8, payloadSize + 8));
    /* final consignatureArray = RegExp('.{1,192}')
        .allMatches(cosignatures)
        .map((match) => match.group(0))
        .toList(); */

    return AggregateTransaction.complete(
        deadline,
        innerTransactionArray.map((innerTransaction) {
          final txType =
              extractNumberFromHex(innerTransaction.substring(72, 76));
          final transaction = createTransaction(
            txType,
            innerTransaction.substring(76),
            networkType,
            deadlineUint64,
          );

          transaction.absTransaction().toAggregate =
              PublicAccount.fromPublicKey(
                  innerTransaction.substring(0, 64), networkType);
          return transaction;
        }).toList(),
        networkType);
  } else if (type == TransactionType.aggregateBonded) {
    final bondedPayloadSize =
        extractNumberFromHex(transactionData.substring(0, 8)) * 2;
    /*  final bondedCosignatures = transactionData.substring(bondedPayloadSize + 8); */

    final bondedInnerTransactionArray = parseInnerTransactionFromBinary(
        transactionData.substring(8, bondedPayloadSize + 8));
    /* final consignatureArray = RegExp('.{1,192}')
        .allMatches(bondedCosignatures)
        .map((match) => match.group(0))
        .toList(); */
    return AggregateTransaction.bonded(
        deadline,
        bondedInnerTransactionArray.map((innerTransaction) {
          final txType =
              extractNumberFromHex(innerTransaction.substring(72, 76));
          final transaction = createTransaction(
            txType,
            innerTransaction.substring(76),
            networkType,
            deadlineUint64,
          );

          transaction.absTransaction().toAggregate =
              PublicAccount.fromPublicKey(
                  innerTransaction.substring(0, 64), networkType);
          return transaction;
        }).toList(),
        networkType);
  } else if (type == TransactionType.mosaicMetadataV2) {
    return MosaicMetadataTransaction.createFromPayload(
        deadline,
        MosaicId.fromHex(reverse(transactionData.substring(80, 96))),
        PublicAccount.fromPublicKey(
            transactionData.substring(0, 64), networkType),
        Uint64.fromHex(reverse(transactionData.substring(64, 80))),
        int.parse(reverse(transactionData.substring(100, 104)), radix: 16),
        extractValueSizeDelta(transactionData.substring(96, 100)),
        hexToUint8List(transactionData.substring(104)),
        networkType);
  } else if (type == TransactionType.namespaceMetadataV2) {
    return NamespaceMetadataTransaction.createFromPayload(
        deadline,
        NamespaceId.fromHex(reverse(transactionData.substring(80, 96))),
        PublicAccount.fromPublicKey(
            transactionData.substring(0, 64), networkType),
        Uint64.fromHex(reverse(transactionData.substring(64, 80))),
        int.parse(reverse(transactionData.substring(100, 104)), radix: 16),
        extractValueSizeDelta(transactionData.substring(96, 100)),
        hexToUint8List(transactionData.substring(104)),
        networkType);
  } else if (type == TransactionType.accountMetadataV2) {
    return AccountMetadataTransaction.createFromPayload(
        deadline,
        PublicAccount.fromPublicKey(
            transactionData.substring(0, 64), networkType),
        Uint64.fromHex(reverse(transactionData.substring(64, 80))),
        int.parse(reverse(transactionData.substring(84, 88)), radix: 16),
        extractValueSizeDelta(transactionData.substring(80, 84)),
        hexToUint8List(transactionData.substring(88)),
        networkType);
  } else if (type == TransactionType.addExchangeOffer) {
    final addOffersArray = RegExp('.{66}')
        .allMatches(transactionData.substring(2))
        .map((match) => match.group(0))
        .toList();
    return AddExchangeOfferTransaction(
        deadline,
        addOffersArray.map((o) {
          /* final id = o!.substring(0, 16); */
          final amount = o!.substring(16, 32);
          final cost = o.substring(32, 48);
          final type = extractNumberFromHex(o.substring(48, 50));
          final duration = o.substring(50, 66);

          return AddOffer(
              offer: Offer(
                  OfferType(type),
                  Mosaic(MosaicId.fromHex(reverse(cost)),
                      Uint64.fromHex(reverse(amount))),
                  Uint64.fromHex(reverse(cost))),
              duration: Uint64.fromHex(reverse(duration)));
        }).toList(),
        networkType);
  } else if (type == TransactionType.exchangeOffer) {
    final offersArray = RegExp('.{114}')
        .allMatches(transactionData.substring(2))
        .map((match) => match.group(0))
        .toList();
    return ExchangeOfferTransaction(
        deadline,
        offersArray.map((o) {
          /* final id = o!.substring(0, 16); */
          final amount = o!.substring(16, 32);
          final cost = o.substring(32, 48);
          final type = extractNumberFromHex(o.substring(48, 50));
          final owner = o.substring(50, 114);

          return new ExchangeConfirmation(
              Offer(
                  OfferType(type),
                  Mosaic(MosaicId.fromHex(reverse(cost)),
                      Uint64.fromHex(reverse(amount))),
                  Uint64.fromHex(reverse(cost))),
              owner: owner);
        }).toList(),
        networkType);
  } else if (type == TransactionType.removeExchangeOffer) {
    final removeOffersArray = RegExp('.{18}')
        .allMatches(transactionData.substring(2))
        .map((match) => match.group(0))
        .toList();

    return RemoveExchangeOfferTransaction(
        deadline,
        removeOffersArray.map((o) {
          final id = o!.substring(0, 16);
          final offerType = extractNumberFromHex(o.substring(16, 18));

          return RemoveOffer(
              offerType: OfferType(offerType),
              assetId: MosaicId.fromHex(reverse(id)));
        }).toList(),
        networkType);
  } else {
    throw Exception('Invalid txn type');
  }
}

/* else if(type == TransactionType.blockchainUpgrade){

 const upgradePeriod = transactionData.substring(0, 16);
            const newBlockchainVersion = transactionData.substring(16, 32);
            return factory.chainUpgrade()
                .upgradePeriod(UInt64.fromHex(reverse(upgradePeriod)))
                .newBlockchainVersion(UInt64.fromHex(reverse(newBlockchainVersion)))
                .build();
    } */
/* else if(type == TransactionType.networkConfigEntityType){
final applyHeightDelta = transactionData.substring(0, 16);
            final networkConfigLength = extractNumberFromHex(transactionData.substring(16, 20));
            final supportedEntityVersionsLength = extractNumberFromHex(transactionData.substring(20, 24));
            final networkConfig = transactionData.substring(24, 24 + networkConfigLength*2);
            final supportedEntityVersions = transactionData.substring(24 + networkConfigLength*2, 24 + networkConfigLength*2 + supportedEntityVersionsLength*2);
            return factory.chainConfig()
                .applyHeightDelta(UInt64.fromHex(reverse(applyHeightDelta)))
                .networkConfig(decodeHexRaw(networkConfig))
                .supportedEntityVersions(decodeHexRaw(supportedEntityVersions))
                .build();
    } */ /* else if(type == TransactionType.secretLock){
final secretLockMosaic = transactionData.substring(0, 32);
            final secretLockDuration = transactionData.substring(32, 48);
            final secretLockHashAlgorithm = extractNumberFromHex(
                transactionData.substring(48, 50));
            final secretLockSecret = transactionData.substring(50, transactionData.length - 50);
            final secretLockRecipient = transactionData.substring(transactionData.length - 50);
            return factory.secretLock()
                .mosaic(new Mosaic(
                    new MosaicId(UInt64.fromHex(reverse(secretLockMosaic.substring(0, 16))).toDTO()),
                    UInt64.fromHex(reverse(secretLockMosaic.substring(16))),
                ))
                .duration(UInt64.fromHex(reverse(secretLockDuration)))
                .hashType(secretLockHashAlgorithm)
                .secret(secretLockSecret)
                .recipient(Address.createFromEncoded(secretLockRecipient))
                .build();
    } */ /* else if(type == TransactionType.secretProof){
final  secretProofHashAlgorithm = extractNumberFromHex(
                transactionData.substring(0, 2));

            final  secretProofSecretLength = 64;
            final  secretProofSecret = transactionData.substring(2, 66);
            final  secretProofRecipient = transactionData.substring(66, 116);
            final  secretProofSize = transactionData.substring(116, 120);
            final  secretProofProof = transactionData.substring(120);

            return factory.secretProof()
                .hashType(secretProofHashAlgorithm)
                .secret(secretProofSecret)
                .recipient(Address.createFromEncoded(secretProofRecipient))
                .proof(secretProofProof)
                .build();
    } */ /* else if(type == TransactionType.lock){
final hashLockMosaic = transactionData.substring(0, 32);
            final hashLockDuration = transactionData.substring(32, 48);
            final hashLockHash = transactionData.substring(48);
LockFundsTransaction.create(deadline, Mosaic(MosaicId.fromUint64(Uint64.fromHex(reverse(hashLockMosaic.substring(0, 16)))), Uint64.fromHex(reverse(hashLockMosaic.substring(16)))),
 Uint64.fromHex(reverse(hashLockDuration)), SignedTransaction(TransactionType.aggregateBonded, payload, hashLockHash), networkType);
          
    } */
/* else if(type == TransactionType.){

    }
       else if(type == TransactionType.){

    }
       else if(type == TransactionType.){

    }
       else if(type == TransactionType.){

    }
        */

/* switch (type) {
     
        case TransactionType.MODIFY_MOSAIC_LEVY:
            return factory.mosaicModifyLevy()
                .mosaicId(new MosaicId(UInt64.fromHex(reverse(transactionData.substring(0, 16))).toDTO()))
                .mosaicLevy(
                    new MosaicLevy(
                        parseInt(transactionData.substring(16, 18), 16), 
                        Address.createFromEncoded(transactionData.substring(18, 68)), 
                        new MosaicId(
                            UInt64.fromHex(reverse(transactionData.substring(68, 84))).toDTO()
                        ),
                        UInt64.fromHex(reverse(transactionData.substring(84, 100)))
                    )
                )    
                .build();

        case TransactionType.REMOVE_MOSAIC_LEVY:
        
            return factory.mosaicRemoveLevy()
                    .mosaicId(new MosaicId(UInt64.fromHex(reverse(transactionData.substring(0, 16))).toDTO()))
                    .build();
  
        case TransactionType.ADD_HARVESTER:{
            const harvesterKey = transactionData.substring(0, 64);
            const harvesterAcc = PublicAccount.createFromPublicKey(harvesterKey, networkType);
            return factory.addHarvester()
                .harvesterKey(harvesterAcc)
                .build();
        }
        case TransactionType.REMOVE_HARVESTER:{
            const harvesterKey = transactionData.substring(0, 64);
            const harvesterAcc = PublicAccount.createFromPublicKey(harvesterKey, networkType);
            return factory.removeHarvester()
                .harvesterKey(harvesterAcc)
                .build();
        }

        } */

Uint8List reverseUint8List(List<int> bytes) =>
    Uint8List.fromList(bytes.reversed.toList());

int hexToInt(String hex) {
  if (hex.length % 2 != 0) {
    hex = '0' + hex;
  }
  int num = int.parse(hex, radix: 16);
  final maxVal = pow(2, hex.length ~/ 2 * 8).toInt();
  if (num > maxVal ~/ 2 - 1) {
    num = num - maxVal;
  }
  return num;
}

Uint8List hexToUint8List(String hexString) {
  hexString = hexString.replaceAll(' ', ''); // Remove any spaces
  final length = hexString.length;
  final data = Uint8List(length ~/ 2);

  for (var i = 0; i < length; i += 2) {
    final hex = hexString.substring(i, i + 2);
    final byte = int.parse(hex, radix: 16);
    data[i ~/ 2] = byte;
  }

  return data;
}

String uint8ListToHex(Uint8List uint8List) {
  var hexString = '';
  for (var byte in uint8List) {
    hexString += byte.toRadixString(16).padLeft(2, '0');
  }
  return hexString;
}
