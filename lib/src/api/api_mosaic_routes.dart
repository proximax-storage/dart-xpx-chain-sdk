part of xpx_chain_sdk;

class MosaicRoutesApi {

  MosaicRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get mosaic information
  ///
  /// Gets a [MosaicInfo] definition for a given mosaicId.
  Future<MosaicInfo> GetMosaic(MosaicId mosaicId) async {
    Object postBody;

    // verify required params are set
    if (mosaicId == null) {
      throw new ApiException(400, "Missing required param: mosaicId");
    }
    var nsId = mosaicId.toHex();
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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      var resp = apiClient.deserialize(response.body, '_MosaicInfoDTO')
          as _MosaicInfoDTO;
      return new MosaicInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an List of [MosaicInfo].
  Future<List<MosaicInfo>> GetMosaics(MosaicIds mosaicIds) async {
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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (apiClient.deserialize(response.body, 'List<_MosaicInfoDTO>') as List)
              .map((dynamic item) => item as _MosaicInfoDTO)
              .toList();
      return MosaicInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get readable names for a set of mosaics
  ///
  /// Returns a [MosaicName] friendly names for mosaics.
  Future<List<MosaicName>> GetMosaicsName(MosaicIds mosaicIds) async {
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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp = (apiClient.deserialize(response.body, 'List<_MosaicNameDTO>')
              as List)
          .map((dynamic item) => item as _MosaicNameDTO)
          .toList();
      return MosaicName.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
