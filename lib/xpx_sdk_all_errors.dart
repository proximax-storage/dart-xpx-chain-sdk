part of xpx_chain_sdk;

/// Catapult REST API errors
final errResourceNotFound =  Exception("resource is not found");
final errArgumentNotValid =  Exception("argument is not valid");
final errInvalidRequest =  Exception("request is not valid");
final errInternalError =  Exception("response is null");
final errNotAcceptedResponseStatusCode =
     Exception("not accepted response status code");

/// Mosaic errors
final errEmptyMosaicIds =  Exception("list mosaics ids must not by empty");
final errNullMosaicId =  Exception("mosaicId must not be null");
final errNullId =  Exception("Id must not be null");
final errNullSupplyType =  Exception("supplyType must not be null");
final errNullMosaics =  Exception("mosaics must not be null");
final errNullBigInt =  Exception("The bigInt must not be null");
final errNullMosaicAmount =  Exception("amount must be not null");
final errInvalidMosaicName =  Exception("mosaic name is invalid");
final errNullMosaicProperties =
     Exception("mosaic properties must not be null");
final errInvalidMosaicProperties =
     Exception("mosaic Properties is not valid");
final errInvalidOwnerPublicKey =  Exception("public owner key is invalid");

/// Namespace errors
final errInvalidNamespaceName =  Exception("namespace name is invalid");
final errNamespaceTooManyPart =  Exception("too many parts");
final errNullNamespaceId =  Exception("namespaceId is null or zero");
final errEmptyNamespaceIds =
     Exception("list namespace ids must not by empty");

/// Blockchain errors
final errNullOrZeroHeight =
     Exception("block height should not be null or zero");
final errNullOrZeroLimit =  Exception("limit should not be null or zero");
final errEmptyAddressesIds =
     Exception("list of addresses should not be empty");
final errNullAddress =  Exception("address is null");
final errBlankAddress =  Exception("address is blank");
final errNullAccount =  Exception("account should not be null");
final errInvalidAddress =  Exception("wrong address");

/// Transactions errors
final errNullRecipient =  Exception("recipient must not be null");
final errNullDuration =  Exception("duration must not be null");
final errNullMessage =
     Exception("message must not be null, but could be with empty payload");
final errNullInnerTransactions =
     Exception("innerTransactions must not be null");
final errTransactionSigner =
     Exception("some of the transaction does not have a signer");

/// Accounts errors
final errInvalidPublicKey =  Exception("not a valid public key");
final errNullSignature =  Exception("signature must not be null");
final errInvalidSignature =  Exception("signature length is incorrect");
final errInvalidHexadecimal =  Exception("must be hexadecimal");
