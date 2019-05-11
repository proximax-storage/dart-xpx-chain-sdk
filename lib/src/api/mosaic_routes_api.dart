part of xpx_catapult_sdk;

class MosaicRoutesApi {
  final ApiClient apiClient;

  MosaicRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// Get mosaic information
  ///
  /// Gets the mosaic definition for a given mosaicId.
  Future<MosaicInfo> GetMosaic(BigInt mosaicId) async {
    Object postBody = null;

    // verify required params are set
    if (mosaicId == null) {
      throw new ApiException(400, "Missing required param: mosaicId");
    }
    var nsId = bigIntegerToHex(mosaicId);
    // create path and map variables
    String path = "/mosaic/{mosaicId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "mosaicId" + "}", nsId);

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      var resp = apiClient.deserialize(response.body, '_mosaicInfoDTO')
          as _mosaicInfoDTO;
      return new MosaicInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an array of mosaic definition.
  Future<List<_mosaicInfoDTO>> getMosaics(MosaicIds mosaicIds) async {
    Object postBody = mosaicIds;

    // verify required params are set
    if (mosaicIds == null) {
      throw new ApiException(400, "Missing required param: mosaicIds");
    }

    // create path and map variables
    String path = "/mosaic".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<_mosaicInfoDTO>')
              as List)
          .map((item) => item as _mosaicInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get readable names for a set of mosaics
  ///
  /// Returns friendly names for mosaics.
  Future<List<MosaicNameDTO>> getMosaicsName(MosaicIds mosaicIds) async {
    Object postBody = mosaicIds;

    // verify required params are set
    if (mosaicIds == null) {
      throw new ApiException(400, "Missing required param: mosaicIds");
    }

    // create path and map variables
    String path = "/mosaic/names".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<MosaicNameDTO>')
              as List)
          .map((item) => item as MosaicNameDTO)
          .toList();
    } else {
      return null;
    }
  }
}
