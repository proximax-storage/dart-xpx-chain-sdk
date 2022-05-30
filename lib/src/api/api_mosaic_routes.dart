/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class MosaicRoutesApi {
  MosaicRoutesApi([ApiClient? apiClient])
      : _apiClient = apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  static const _mosaicRoute = '/mosaic/{mosaicId}';
  static const _mosaicsRoute = '/mosaic';
  static const _mosaicsNameRoute = '/mosaic/names';
  static const _mosaicRichListRoute = '/mosaic/{mosaicId}/richlist';
  static const _getMosaicLevyRoute = '/mosaic/{mosaicId}/levy';

  /// Get mosaic information
  ///
  /// Gets a [MosaicInfo] definition for a given mosaicId.
  Future<MosaicInfo?> getMosaic(MosaicId mosaicId) async {
    final String path =
        _mosaicRoute.replaceAll('{mosaicId}', mosaicId.toHex()!);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'MosaicInfoDTO');
      return MosaicInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an List of [MosaicInfo].
  Future<List<MosaicInfo>> getMosaics(List<MosaicId> mosaicIds) async {
    if (mosaicIds.isEmpty) {
      throw ApiException(400, 'mosaicIds must not be empty');
    }

    final Object postBody = {
      'mosaicIds': mosaicIds.map((id) => id.toHex()).toList()
    };

    const String path = _mosaicsRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<MosaicInfoDTO>')
          .cast<MosaicInfoDTO>();
      return MosaicInfo.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Get readable names for a set of mosaics
  ///
  /// Returns a [MosaicName] friendly names for mosaics.
  Future<List<MosaicName>> getMosaicsName(List<MosaicId> mosaicIds) async {
    if (mosaicIds.isEmpty) {
      throw ApiException(400, 'mosaicIds must not be empty');
    }

    final Object postBody = {
      'mosaicIds': mosaicIds.map((id) => id.toHex()).toList()
    };

    const String path = _mosaicsNameRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List<MosaicNameDTO> resp = _apiClient
          .deserialize(response.data, 'List<MosaicNameDTO>')
          .cast<MosaicNameDTO>();
      return MosaicName.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Get mosaic information
  /// param: mosaicId The mosaic identifier.
  /// param: page The page of list (starts at 0).
  /// param: pageSize The count of items on a page (max 100, default 25).
  /// Returns owners of a given mosaic sorted on descending order based on amount. (REST only)
  Future<List<MosaicRichList>> getMosaicRichList(MosaicId mosaicId,
      {PageQueryParams? pageQueryParams}) async {
    final String path =
        _mosaicRichListRoute.replaceAll('{mosaicId}', mosaicId.toHex()!);

    // query params
    final List<QueryParam> queryParams = [];
    if (pageQueryParams != null) {
      queryParams.addAll(pageQueryParams.toQueryParams());
    }

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<MosaicRichListDTO>')
          .cast<MosaicRichListDTO>();

      return MosaicRichList.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Get mosaic levy information for a mosaic.
  Future<MosaicLevy?> getMosaicLevy(MosaicId mosaicId) async {
    final String path =
        _getMosaicLevyRoute.replaceAll('{mosaicId}', mosaicId.toHex()!);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'MosaicLevyDTO');

      return MosaicLevy.fromDTO(resp);
    } else {
      return null;
    }
  }
}
