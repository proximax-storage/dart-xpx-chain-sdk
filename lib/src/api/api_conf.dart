part of xpx_chain_sdk;

int configNetworkType = 0;

// NewConfig is Config constructor according to 'baseURL' & 'networkType'
class NewConfig {
  NewConfig(this.baseUrl, this.networkType) {
    configNetworkType = networkType;
  }

  int networkType;
  String baseUrl;
}
