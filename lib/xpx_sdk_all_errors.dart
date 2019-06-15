part of xpx_chain_sdk;

/// Catapult REST API errors
final errResourceNotFound = new Exception("resource is not found");
final errArgumentNotValid = new Exception("argument is not valid");
final errInvalidRequest = new Exception("request is not valid");
final errInternalError = new Exception("response is null");
final errNotAcceptedResponseStatusCode =
    new Exception("not accepted response status code");

/// Mosaic errors
final errEmptyMosaicIds = new Exception("list mosaics ids must not by empty");
final errNullMosaicId = new Exception("mosaicId must not be null");
final errNullId = new Exception("Id must not be null");
final errNullSupplyType = new Exception("supplyType must not be null");
final errNullMosaics = new Exception("mosaics must not be null");
final errNullBigInt = new Exception("The bigInt must not be null");
final errNullMosaicAmount = new Exception("amount must be not null");
final errInvalidMosaicName = new Exception("mosaic name is invalid");
final errNullMosaicProperties =
    new Exception("mosaic properties must not be null");
final errInvalidMosaicProperties =
    new Exception("mosaic Properties is not valid");
final errInvalidOwnerPublicKey = new Exception("public owner key is invalid");

/// Namespace errors
final errInvalidNamespaceName = new Exception("namespace name is invalid");
final errNamespaceTooManyPart = new Exception("too many parts");
final errNullNamespaceId = new Exception("namespaceId is null or zero");
final errEmptyNamespaceIds =
    new Exception("list namespace ids must not by empty");

/// Blockchain errors
final errNullOrZeroHeight =
    new Exception("block height should not be null or zero");
final errNullOrZeroLimit = new Exception("limit should not be null or zero");
final errEmptyAddressesIds =
    new Exception("list of addresses should not be empty");
final errNullAddress = new Exception("address is null");
final errBlankAddress = new Exception("address is blank");
final errNullAccount = new Exception("account should not be null");
final errInvalidAddress = new Exception("wrong address");

/// Transactions errors
final errNullRecipient = new Exception("recipient must not be null");
final errNullDuration = new Exception("duration must not be null");
final errNullMessage =
    new Exception("message must not be null, but could be with empty payload");
final errNullInnerTransactions = new Exception("innerTransactions must not be null");
final errTransactionSigner = new Exception("some of the transaction does not have a signer");

/// Accounts errors
final errInvalidPublicKey = new Exception("not a valid public key");
final errNullSignature = new Exception("signature must not be null");
final errInvalidSignature = new Exception("signature length is incorrect");
final errInvalidHexadecimal = new Exception("must be hexadecimal");

