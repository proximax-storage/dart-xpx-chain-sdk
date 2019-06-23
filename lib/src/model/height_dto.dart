part of xpx_chain_sdk;

class _HeightDTO {
  _HeightDTO(this.height);

  _HeightDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    height = UInt64DTO.fromJson(json['height']);
  }

  UInt64DTO height;

  @override
  String toString() => 'Height[${height.higher}, ${height.lower}]';
}
