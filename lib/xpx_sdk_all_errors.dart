library xpx_chain_sdk.error;

/// Mosaic errors
final errNullMosaicId = ArgumentError('mosaicId must not be null');
final errNullId = ArgumentError('Id must not be null');
final errNullSupplyType = ArgumentError('supplyType must not be null');
final errNullMosaics = ArgumentError('mosaics must not be null');
final errNullMosaicAmount = ArgumentError('amount must be not null');

final errNullMosaicProperties = ArgumentError('mosaic properties must not be null');
final errInvalidMosaicProperties = Exception('mosaic Properties is not valid');
final errInvalidOwnerPublicKey = ArgumentError('public owner key is invalid');
final errPropertyId = Exception('unknown Property Id');

/// Namespace errors
final errInvalidNamespaceName = ArgumentError('namespace name is invalid');
final errEmptyNamespaceIds = ArgumentError('list namespace ids must not by empty');

/// Blockchain errors
final errNullOrZeroHeight =
ArgumentError('block height should not be null or zero');
final errNullOrZeroLimit = ArgumentError('limit should not be null or zero');

/// Transactions errors
final errNullRecipient = ArgumentError('recipient must not be null');
final errNullDuration = ArgumentError('duration must not be null');
final errNullMessage =
ArgumentError('message must not be null, but could be with empty payload');
final errNullInnerTransactions =
ArgumentError('innerTransactions must not be null');
final errTransactionSigner =
    Exception('some of the transaction does not have a signer');
final errEmptyModifications = ArgumentError('modifications must not empty');
final errCosignatureTxHash = ArgumentError('cosignature transaction hash is null');

/// Accounts errors
final errInvalidPublicKey = ArgumentError('not a valid public key');
final errNullSignature = ArgumentError('signature must not be null');
final errInvalidSignature = ArgumentError('signature length is incorrect');
final errInvalidHexadecimal = ArgumentError('must be hexadecimal');

/// Various
final errorInvalidMosaicsOffer =
    Exception("you can't get more mosaics when in offer");
final errUnknownOfferType = ArgumentError('unknown offer type');
final errUnknownTransactionType = ArgumentError('unknown transaction type');
final errNullConfirmations = ArgumentError('confirmations must not be null');
final errNullAddOffers = ArgumentError('addOffers must not be null');
final errNullRemoveOffers = ArgumentError('removeOffers must not be null');
final errUnknownPropertyType = ArgumentError('not supported PropertyType');
