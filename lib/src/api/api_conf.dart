part of xpx_catapult_sdk ;

// NewConfig is Config constructor according to 'baseURL' & 'networkType'
class NewConfig {
  int networkType;
  String baseUrl;

  NewConfig(this.baseUrl, this.networkType);
}
