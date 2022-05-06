/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

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
