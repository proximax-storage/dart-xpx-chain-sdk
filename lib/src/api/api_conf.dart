part of xpx_chain_sdk;

int ConfigNetworkType = 0;

// NewConfig is Config constructor according to 'baseURL' & 'networkType'
class NewConfig {

  NewConfig(this.baseUrl, this.networkType) {
    ConfigNetworkType = this.networkType;
  }

  int networkType;
  String baseUrl;
}
