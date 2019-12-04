part of xpx_chain_sdk;

class Message {
  Message(this.type, this.payload);

  Message._fromDTO(_MessageDTO value) {
    if (value?._payload == null) {
      return;
    }
    if (_hexadecimal.hasMatch(value._payload)) {
      payload = hex.decode(value._payload);
    } else {
      payload = Uint8List.fromList(value._payload.codeUnits);
    }
    type = MessageType.getType(value._type);
  }

  MessageType type;
  Uint8List payload;

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['payload'] = utf8.decode(payload);
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
}
