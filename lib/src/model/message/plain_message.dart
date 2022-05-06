/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.message;

class PlainMessage extends Message {
  factory PlainMessage({final Uint8List? bytes, final String? payload}) {
    if (payload == null && bytes == null) {
      throw ArgumentError('The message payload must not be null');
    }

    if (bytes != null && bytes.isNotEmpty) {
      return PlainMessage._(bytes);
    }

    if (_hexadecimal.hasMatch(payload!)) {
      return PlainMessage._(Uint8List.fromList(payload.codeUnits));
    }
    return PlainMessage._(Uint8List.fromList(payload.codeUnits));
  }

  PlainMessage._(Uint8List payload) : super(MessageType.unencrypted, payload);

  static final PlainMessage empty = PlainMessage(payload: '');
}
