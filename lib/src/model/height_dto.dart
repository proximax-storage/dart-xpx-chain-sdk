part of xpx_catapult_sdk ;

class _HeightDTO {
  UInt64DTO height = null;

  _HeightDTO(this.height);

  @override
  String toString() {
    return 'Height[${height.higher}, ${height.lower}]';
  }

  _HeightDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    height = new UInt64DTO.fromJson(json['height']);
  }
}
