/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

// CosignatureSignedTransaction
class CosignatureSignedTransaction {
  CosignatureSignedTransaction(this._parentHash, this.signature, this.signer);

  final String? _parentHash;
  final String signature;
  final String signer;

  String? get hash => _parentHash;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (_parentHash != null) {
      data['parentHash'] = _parentHash;
    }
    data['signature'] = signature;
    data['signer'] = signer;
    return data;
  }
}
