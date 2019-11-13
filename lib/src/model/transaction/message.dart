part of xpx_chain_sdk;

class Message {

  Message(this.type, this.payload);

  Message.fromDTO(_MessageDTO value) {
    if (value?._payload == null) {
      return;
    }

    if (_hexadecimal.hasMatch(value._payload)) {
      payload = Uint8List.fromList(value._payload.codeUnits);
    } else {
      payload = Uint8List.fromList(hex.decode(value._payload));
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
    data['payload'] = payload;
    return data;
  }
}

class PlainMessage extends Message {
  factory PlainMessage({final Uint8List bytes, final String payload}) {
    if (payload == null && bytes == null) {
      throw new ArgumentError('The message payload must not be null');
    }

    if (bytes != null && bytes.isNotEmpty) {
      return new PlainMessage._(bytes);
    }

    if (_hexadecimal.hasMatch(payload)) {
      return new PlainMessage._(Uint8List.fromList(payload.codeUnits));
    }

    return new PlainMessage._(Uint8List.fromList(hex.decode(payload)));
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
    for (var type in values) {
      if (type.value == value) {
        return type;
      }
    }

    throw new ArgumentError(invalidType);
  }
}
