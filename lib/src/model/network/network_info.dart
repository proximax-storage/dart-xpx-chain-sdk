/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.network;

class NetworkInfo {
  NetworkInfo(this.networkType, this.description);

  NetworkInfo.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    networkType = NetworkType.fromName(json['name']);
    description = json['description'];
  }

  late final NetworkType networkType;
  late final String description;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() =>
      {'networkType': networkType, 'description': description};
}
