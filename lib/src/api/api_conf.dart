part of nem2_sdk_dart;

// NewConfig is Config constructor according to 'baseURL' & 'networkType'
class NewConfig {
  int networkType;
  String baseUrl;

  NewConfig(this.baseUrl, this.networkType);
}
