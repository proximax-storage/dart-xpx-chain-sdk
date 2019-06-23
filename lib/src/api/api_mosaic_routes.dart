part of xpx_chain_sdk;

class MosaicRoutesApi {
  MosaicRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get mosaic information
  ///
  /// Gets a [MosaicInfo] definition for a given mosaicId.
  Future<MosaicInfo> getMosaic(MosaicId mosaicId) async {
    Object postBody;

    // verify required params are set
    if (mosaicId == null) {
      throw ApiException(400, 'Missing required param: mosaicId');
    }
    final nsId = mosaicId.toHex();
    // create path and map variables
    final String path = '/mosaic/{mosaicId}'
        .replaceAll('{format}', 'json')
        .replaceAll('{mosaicId}', nsId);

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        postBody = mp;
      }
    } else {}

    final response = await apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = apiClient.deserialize(response.body, '_MosaicInfoDTO');
      return MosaicInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an List of [MosaicInfo].
  Future<List<MosaicInfo>> getMosaics(MosaicIds mosaicIds) async {
    Object postBody = mosaicIds;

    // verify required params are set
    if (mosaicIds == null) {
      throw ApiException(400, 'Missing required param: mosaicIds');
    }

    // create path and map variables
    final String path = '/mosaic'.replaceAll('{format}', 'json');

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        postBody = mp;
      }
    } else {}

    final response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = apiClient
          .deserialize(response.body, 'List<_MosaicInfoDTO>')
          .map((item) => item)
          .toList();
      return MosaicInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get readable names for a set of mosaics
  ///
  /// Returns a [MosaicName] friendly names for mosaics.
  Future<List<MosaicName>> getMosaicsName(MosaicIds mosaicIds) async {
    Object postBody = mosaicIds;

    // verify required params are set
    if (mosaicIds == null) {
      throw ApiException(400, 'Missing required param: mosaicIds');
    }

    // create path and map variables
    final String path = '/mosaic/names'.replaceAll('{format}', 'json');

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        postBody = mp;
      }
    } else {}

    final response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = apiClient
          .deserialize(response.body, 'List<_MosaicNameDTO>')
          .map((item) => item)
          .toList();
      return MosaicName.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
