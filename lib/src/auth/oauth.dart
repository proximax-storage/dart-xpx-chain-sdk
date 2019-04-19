part of nem2_sdk_dart;

class OAuth implements Authentication {
  String accessToken;

  OAuth({this.accessToken}) {
  }

  @override
  void applyToParams(List<QueryParam> queryParams, Map<String, String> headerParams) {
    if (accessToken != null) {
      headerParams["Authorization"] = "Bearer " + accessToken;
    }
  }

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }
}
