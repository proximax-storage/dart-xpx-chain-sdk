part of xpx_chain_sdk;

/// Mosaic errors
final _errNullMosaicId = Exception('mosaicId must not be null');
final _errNullId = Exception('Id must not be null');
final _errNullSupplyType = Exception('supplyType must not be null');
final _errNullMosaics = Exception('mosaics must not be null');
final _errNullMosaicAmount = Exception('amount must be not null');

final _errNullMosaicProperties =
    Exception('mosaic properties must not be null');
final _errInvalidMosaicProperties = Exception('mosaic Properties is not valid');
final _errInvalidOwnerPublicKey = Exception('public owner key is invalid');

/// Namespace errors
final _errInvalidNamespaceName = Exception('namespace name is invalid');
final _errEmptyNamespaceIds = Exception('list namespace ids must not by empty');

/// Blockchain errors
final _errNullOrZeroHeight =
    Exception('block height should not be null or zero');
final _errNullOrZeroLimit = Exception('limit should not be null or zero');

/// Transactions errors
final _errNullRecipient = Exception('recipient must not be null');
final _errNullDuration = Exception('duration must not be null');
final _errNullMessage =
    Exception('message must not be null, but could be with empty payload');
final _errNullInnerTransactions =
    Exception('innerTransactions must not be null');
final _errTransactionSigner =
    Exception('some of the transaction does not have a signer');

/// Accounts errors
final _errInvalidPublicKey = Exception('not a valid public key');
final _errNullSignature = Exception('signature must not be null');
final _errInvalidSignature = Exception('signature length is incorrect');
final _errInvalidHexadecimal = Exception('must be hexadecimal');
