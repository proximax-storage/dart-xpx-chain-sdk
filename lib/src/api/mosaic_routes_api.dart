part of nem2_sdk_dart;



class MosaicRoutesApi {
  final ApiClient apiClient;

  MosaicRoutesApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Get mosaic information
  ///
  /// Gets the mosaic definition for a given mosaicId.
  Future<MosaicInfoDTO> getMosaic(String mosaicId) async {
    Object postBody = null;

    // verify required params are set
    if(mosaicId == null) {
     throw new ApiException(400, "Missing required param: mosaicId");
    }

    // create path and map variables
    String path = "/mosaic/{mosaicId}".replaceAll("{format}","json").replaceAll("{" + "mosaicId" + "}", mosaicId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
          apiClient.deserialize(response.body, 'MosaicInfoDTO') as MosaicInfoDTO ;
    } else {
      return null;
    }
  }
  /// Get mosaics information for an array of mosaics
  ///
  /// Gets an array of mosaic definition.
  Future<List<MosaicInfoDTO>> getMosaics(MosaicIds mosaicIds) async {
    Object postBody = mosaicIds;

    // verify required params are set
    if(mosaicIds == null) {
     throw new ApiException(400, "Missing required param: mosaicIds");
    }

    // create path and map variables
    String path = "/mosaic".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<MosaicInfoDTO>') as List).map((item) => item as MosaicInfoDTO).toList();
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
    if(mosaicIds == null) {
     throw new ApiException(400, "Missing required param: mosaicIds");
    }

    // create path and map variables
    String path = "/mosaic/names".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<MosaicNameDTO>') as List).map((item) => item as MosaicNameDTO).toList();
    } else {
      return null;
    }
  }
}
