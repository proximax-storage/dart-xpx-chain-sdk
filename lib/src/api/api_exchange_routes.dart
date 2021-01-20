part of xpx_chain_sdk.api;

class ExchangeRoutesApi {
  ExchangeRoutesApi([_ApiClient _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  /// Return [List<OfferInfo>] with same operation type and mosaic id.
  /// Example: If you want to buy Storage units, you need
  /// to call getExchangeOfferByAssetId(storageMosaicId, sellOffer)
  Future<List<OfferInfo>> getExchangeOfferByAssetId(MosaicId assetId, OfferType offerType) async {
    // verify required params are set
    if (assetId == null) {
      throw ApiException(400, 'Missing required param: assetId');
    }

    // create path and map variables
    final String path = '/exchange/{offerType}/${assetId.toHex()}'
        .replaceAll('{format}', 'json')
        .replaceAll('{offerType}', offerType.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<OfferInfoDTO>').cast<OfferInfoDTO>();

      return OfferInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get [UserExchangeInfo] information
  ///
  /// Returns the UserExchange information.
  Future<UserExchangeInfo> getAccountExchangeInfo(PublicAccount account) async {
    // verify required params are set
    if (account.publicKey == '') {
      throw ApiException(400, 'Missing required param: account');
    }

    // create path and map variables
    final String path =
        '/account/{publicKey}/exchange'.replaceAll('{format}', 'json').replaceAll('{publicKey}', account.publicKey);

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'ExchangeDTO');

      return UserExchangeInfo.fromDTO(resp);
    } else {
      return null;
    }
  }
}
