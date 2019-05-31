part of xpx_catapult_sdk;

/// Catapult REST API errors
final ErrResourceNotFound = new Exception("resource is not found");
final ErrArgumentNotValid = new Exception("argument is not valid");
final ErrInvalidRequest = new Exception("request is not valid");
final ErrInternalError = new Exception("response is null");
final ErrNotAcceptedResponseStatusCode =
    new Exception("not accepted response status code");

/// Mosaic errors
final ErrEmptyMosaicIds = new Exception("list mosaics ids must not by empty");
final ErrNullMosaicId = new Exception("mosaicId must not be null");
final ErrNullSupplyType = new Exception("supplyType must not be null");
final ErrNullMosaics = new Exception("mosaics must not be null");
final ErrNullMosaicAmount = new Exception("amount must be not null");
final ErrInvalidMosaicName = new Exception("mosaic name is invalid");
final ErrNullMosaicProperties =
    new Exception("mosaic properties must not be null");
final ErrInvalidMosaicProperties =
    new Exception("mosaic Properties is not valid");
final ErrInvalidOwnerPublicKey = new Exception("public owner key is invalid");

/// Namespace errors
final ErrInvalidNamespaceName = new Exception("namespace name is invalid");
final ErrNamespaceTooManyPart = new Exception("too many parts");
final ErrNullNamespaceId = new Exception("namespaceId is null or zero");
final ErrEmptyNamespaceIds =
    new Exception("list namespace ids must not by empty");

/// Blockchain errors
final ErrNullOrZeroHeight =
    new Exception("block height should not be null or zero");
final ErrNullOrZeroLimit = new Exception("limit should not be null or zero");
final ErrEmptyAddressesIds =
    new Exception("list of addresses should not be empty");
final ErrNullAddress = new Exception("address is null");
final ErrBlankAddress = new Exception("address is blank");
final ErrNullAccount = new Exception("account should not be null");
final ErrInvalidAddress = new Exception("wrong address");

/// Transactions errors
final ErrNullRecipient = new Exception("recipient must not be null");
final ErrNullDuration = new Exception("duration must not be null");
final ErrNullMessage =
    new Exception("message must not be null, but could be with empty payload");
