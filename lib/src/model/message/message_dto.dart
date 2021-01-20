part of xpx_chain_sdk.message;

// Message
class MessageDTO {
  MessageDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    type = json['type'];
    _payload = json['payload'];
  }

  int type;
  String _payload;

  Map<String, dynamic> toJson() => {'type': type, 'tayload': _payload};
}
