part of nem2_sdk_dart;

class _HeightDTO {
  UInt64DTO height = null;

  _HeightDTO(this.height);

  @override
  String toString() {
    return 'Height[${height.h}, ${height.l}]';
  }

  _HeightDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    height = new UInt64DTO.fromJson(json['height']);
  }
}
