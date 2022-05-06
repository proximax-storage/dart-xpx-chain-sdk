/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.message;

class Message {
  Message(this.type, this.payload);

  Message.fromDTO(MessageDTO dto) {
    if (_hexadecimal.hasMatch(dto.payload!)) {
      payload = hex.decode(dto.payload!) as Uint8List;
    } else {
      payload = Uint8List.fromList(dto.payload!.codeUnits);
    }
    type = MessageType.getType(dto.type);
  }

  late MessageType type;
  late Uint8List payload;

  String get payloadAsString => utf8.decode(payload);

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['payload'] = payloadAsString;
    return data;
  }
}
