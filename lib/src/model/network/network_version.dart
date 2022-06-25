/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.network;

class NetworkVersion {
  NetworkVersion._(this.startedHeight, this.blockChainVersion);

  String startedHeight;
  String blockChainVersion;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'startedHeight': startedHeight, 'blockChainVersion': blockChainVersion};
}
