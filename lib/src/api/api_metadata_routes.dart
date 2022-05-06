/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class MetadataRoutesApi {
  MetadataRoutesApi(this._apiClient);

  final _ApiClient _apiClient;

  static const _metadataV2InfoRoute = '/metadata_v2/{compositeHash}';
  static const _metadatasV2InfoRoute = '/metadata_v2';

  /// Gets the metadata(AccountMetadataIndo, MosaicMetadataInfo or NamespaceMetadataInfo) for a given metadataId.
  Future<MetadataEntry?> getMetadataV2Info(String compositeHash) async {
    if (compositeHash.isEmpty) {
      throw ApiException(400, 'compositeHash must not be empty');
    }

    // create path and map variables
    final String path =
        _metadataV2InfoRoute.replaceAll('{compositeHash}', compositeHash);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'MetadataV2InfoDTO');
      return MetadataEntry.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Gets an array of metadata.
  /// Get metadatas(namespace/mosaic/account) for an array of compositeHashes'
  Future<List<MetadataEntry>> getMetadatasV2Info(
      List<String> compositeHashes) async {
    if (compositeHashes.isEmpty) {
      throw ApiException(400, 'compositeHashes must not be empty');
    }

    final Object postBody = {'compositeHashes': compositeHashes};

    const String path = _metadatasV2InfoRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<MetadataV2InfoDTO>')
          .cast<MetadataV2InfoDTO>();
      return MetadataEntry.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Gets the metadata for a given mosaicId.
  Future<List<MetadataEntry>> searchMetadata(
      [MetadataQueryParams? metadataQueryParams]) async {
    const String path = _metadatasV2InfoRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (metadataQueryParams != null) {
      queryParams.addAll(metadataQueryParams.toQueryParams());
    }

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<MetadataV2InfoDTO>')
          .cast<MetadataV2InfoDTO>();
      return MetadataEntry.listFromDTO(resp);
    } else {
      return [];
    }
  }
}
