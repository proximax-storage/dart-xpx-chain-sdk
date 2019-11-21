part of xpx_chain_sdk;

class MosaicRoutesApi {
  MosaicRoutesApi([_ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final _ApiClient apiClient;

  /// Get mosaic information
  ///
  /// Gets a [MosaicInfo] definition for a given mosaicId.
  Future<MosaicInfo> getMosaic(MosaicId mosaicId) async {
    // verify required params are set
    if (mosaicId == null) {
      throw ApiException(400, 'Missing required param: mosaicId');
    }
    final nsId = mosaicId.toHex();
    // create path and map variables
    final String path = '/mosaic/{mosaicId}'
        .replaceAll('{format}', 'json')
        .replaceAll('{mosaicId}', nsId);

    final response = await apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = apiClient.deserialize(response.body, '_MosaicInfoDTO');
      return MosaicInfo._fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an List of [MosaicInfo].
  Future<List<MosaicInfo>> getMosaics(MosaicIds mosaicIds) async {
    final Object postBody = mosaicIds;

    // verify required params are set
    if (mosaicIds == null) {
      throw ApiException(400, 'Missing required param: mosaicIds');
    }

    // create path and map variables
    final String path = '/mosaic'.replaceAll('{format}', 'json');

    final response = await apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp =
          // ignore: avoid_as
          (apiClient.deserialize(response.body, 'List<_MosaicInfoDTO>') as List)
              // ignore: avoid_as
              .map((item) => item as _MosaicInfoDTO)
              .toList();
      return MosaicInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get readable names for a set of mosaics
  ///
  /// Returns a [MosaicName] friendly names for mosaics.
  Future<List<MosaicName>> getMosaicsName(List<MosaicId> mosaicIds) async {
    final Object postBody = MosaicIds.fromList(mosaicIds);

    // verify required params are set
    if (mosaicIds == null) {
      throw ApiException(400, 'Missing required param: mosaicIds');
    }

    // create path and map variables
    final String path = '/mosaic/names'.replaceAll('{format}', 'json');

    final response = await apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      // ignore: avoid_as
      final resp =
          // ignore: avoid_as
          (apiClient.deserialize(response.body, 'List<_MosaicNameDTO>') as List)
              // ignore: avoid_as
              .map((item) => item as _MosaicNameDTO)
              .toList();
      return MosaicName.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
