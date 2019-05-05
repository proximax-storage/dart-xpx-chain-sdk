part of nem2_sdk_dart;

/// Catapult REST API errors
final ErrResourceNotFound = new Exception("resource is not found");
final ErrArgumentNotValid = new Exception("argument is not valid");
final ErrInvalidRequest = new Exception("request is not valid");
final ErrInternalError = new Exception("response is nil");
final ErrNotAcceptedResponseStatusCode = new Exception("not accepted response status code");

/// Mosaic errors
final ErrEmptyMosaicIds = new Exception("list mosaics ids must not by empty");
final ErrNilMosaicId = new Exception("mosaicId must not be nil");
final ErrNilMosaicAmount = new Exception("amount must be not nil");
final ErrInvalidMosaicName = new Exception("mosaic name is invalid");
final ErrNilMosaicProperties = new Exception("mosaic properties must not be nil");

/// Namespace errors
final ErrInvalidNamespaceName = new Exception("namespace name is invalid");
final ErrNamespaceTooManyPart = new Exception("too many parts");
final ErrNilNamespaceId = new Exception("namespaceId is nil or zero");
final ErrEmptyNamespaceIds = new Exception("list namespace ids must not by empty");

/// Blockchain errors
final ErrNilOrZeroHeight =
    new Exception("block height should not be nil or zero");
final ErrNilOrZeroLimit = new Exception("limit should not be nil or zero");

final ErrEmptyAddressesIds = new Exception("list of addresses should not be empty");
final ErrNilAddress = new Exception("address is nil");
final ErrBlankAddress = new Exception("address is blank");
final ErrNilAccount = new Exception("account should not be nil");
final ErrInvalidAddress = new Exception("wrong address");
