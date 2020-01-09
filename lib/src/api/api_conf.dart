part of xpx_chain_sdk.api;

int configNetworkType = 0;

// Config is Config constructor according to 'baseURL' & 'networkType'
class Config {
  Config(this.baseUrl, this.networkType) {
    configNetworkType = networkType;
  }

  int networkType;
  String baseUrl;
}
