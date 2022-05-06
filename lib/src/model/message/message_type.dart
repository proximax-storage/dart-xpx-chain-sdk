/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.message;

class MessageType {
  const MessageType(this.value);

  static const String invalidType = 'invalid message type';

  static const MessageType unencrypted = MessageType(0x00);

  static const MessageType encrypted = MessageType(0x01);

  static final List<MessageType> values = <MessageType>[unencrypted, encrypted];

  final int value;

  static MessageType getType(final int? value) {
    for (var i = 0; i < values.length; i++) {
      if (values[i].value == value) {
        return values[i];
      }
    }

    throw ArgumentError(invalidType);
  }

  @override
  String toString() => encoder.convert(this);

  int toJson() => value;
}
