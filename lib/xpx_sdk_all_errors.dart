library xpx_chain_sdk.error;

/// Mosaic errors
final errNullMosaicId = Exception('mosaicId must not be null');
final errNullId = Exception('Id must not be null');
final errNullSupplyType = Exception('supplyType must not be null');
final errNullMosaics = Exception('mosaics must not be null');
final errNullMosaicAmount = Exception('amount must be not null');

final errNullMosaicProperties = Exception('mosaic properties must not be null');
final errInvalidMosaicProperties = Exception('mosaic Properties is not valid');
final errInvalidOwnerPublicKey = Exception('public owner key is invalid');
final errPropertyId = Exception('unknown Property Id');

/// Namespace errors
final errInvalidNamespaceName = Exception('namespace name is invalid');
final errEmptyNamespaceIds = Exception('list namespace ids must not by empty');

/// Blockchain errors
final errNullOrZeroHeight = Exception('block height should not be null or zero');
final errNullOrZeroLimit = Exception('limit should not be null or zero');

/// Transactions errors
final errNullRecipient = Exception('recipient must not be null');
final errNullDuration = Exception('duration must not be null');
final errNullMessage = Exception('message must not be null, but could be with empty payload');
final errNullInnerTransactions = Exception('innerTransactions must not be null');
final errTransactionSigner = Exception('some of the transaction does not have a signer');
final errEmptyModifications = Exception('modifications must not empty');
final errCosignatureTxHash = Exception('cosignature transaction hash is null');

/// Accounts errors
final errInvalidPublicKey = Exception('not a valid public key');
final errNullSignature = Exception('signature must not be null');
final errInvalidSignature = Exception('signature length is incorrect');
final errInvalidHexadecimal = Exception('must be hexadecimal');

/// Various
final errorInvalidMosaicsOffer = Exception("you can't get more mosaics when in offer");
final errUnknownOfferType = Exception('unknown offer type');
final errUnknownTransactionType = Exception('unknown transaction type');
final errNullConfirmations = Exception('confirmations must not be null');
final errNullAddOffers = Exception('addOffers must not be null');
final errNullRemoveOffers = Exception('removeOffers must not be null');
final errUnknownPropertyType = Exception('not supported PropertyType');
