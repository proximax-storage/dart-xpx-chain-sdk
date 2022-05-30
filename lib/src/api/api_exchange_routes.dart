/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class ExchangeRoutesApi {
  ExchangeRoutesApi([ApiClient? _apiClient])
      : _apiClient = _apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  /// Return [List<OfferInfo>] with same operation type and mosaic id.
  /// Example: If you want to buy Storage units, you need
  /// to call getExchangeOfferByAssetId(storageMosaicId, sellOffer)
  Future<List<OfferInfo>?> getExchangeOfferByAssetId(
      MosaicId assetId, OfferType offerType) async {
    // create path and map variables
    final String path = '/exchange/{offerType}/${assetId.toHex()}'
        .replaceAll('{format}', 'json')
        .replaceAll('{offerType}', offerType.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 400) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<OfferInfoDTO>')
          .cast<OfferInfoDTO>();

      return OfferInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get [UserExchangeInfo] information
  ///
  /// Returns the UserExchange information.
  Future<UserExchangeInfo?> getAccountExchangeInfo(
      PublicAccount account) async {
    // verify required params are set
    if (account.publicKey == '') {
      throw ApiException(400, 'Missing required param: account');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/exchange'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 400) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'ExchangeDTO');

      return UserExchangeInfo.fromDTO(resp);
    } else {
      return null;
    }
  }
}
