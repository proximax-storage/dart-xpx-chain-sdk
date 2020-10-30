part of xpx_chain_sdk.message;

class Message {
  Message(this.type, this.payload);

  Message.fromDTO(MessageDTO dto) {
    if (dto?._payload == null) {
      return;
    }
    if (_hexadecimal.hasMatch(dto._payload)) {
      payload = hex.decode(dto._payload);
    } else {
      payload = Uint8List.fromList(dto._payload.codeUnits);
    }
    type = MessageType.getType(dto.type);
  }

  MessageType type;
  Uint8List payload;

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

class PlainMessage extends Message {
  factory PlainMessage({final Uint8List bytes, final String payload}) {
    if (payload == null && bytes == null) {
      throw ArgumentError('The message payload must not be null');
    }

    if (bytes != null && bytes.isNotEmpty) {
      return PlainMessage._(bytes);
    }

    if (_hexadecimal.hasMatch(payload)) {
      return PlainMessage._(Uint8List.fromList(payload.codeUnits));
    }
    return PlainMessage._(Uint8List.fromList(payload.codeUnits));
  }

  PlainMessage._(Uint8List payload) : super(MessageType.unencrypted, payload);

  static final PlainMessage empty = PlainMessage(payload: '');
}

class MessageType {
  const MessageType(this.value);

  static const String invalidType = 'invalid message type';

  static const MessageType unencrypted = MessageType(0x00);

  static const MessageType encrypted = MessageType(0x01);

  static final List<MessageType> values = <MessageType>[unencrypted, encrypted];

  final int value;

  static MessageType getType(final int value) {
    for (var i = 0; i < values.length; i++) {
      if (values[i].value == value) {
        return values[i];
      }
    }

    throw ArgumentError(invalidType);
  }

  @override
  String toString() => '$value';

  Map<String, dynamic> toJson() => {'value': value};
}
