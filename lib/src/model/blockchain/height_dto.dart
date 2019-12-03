part of xpx_chain_sdk;

class _HeightDTO {
  _HeightDTO(this._height);

  _HeightDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _height = UInt64DTO.fromJson(json['height']);
  }

  UInt64DTO _height;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = _height;
    return data;
  }
}
