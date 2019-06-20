part of xpx_chain_sdk;

class _HeightDTO {
  _HeightDTO(this.height);

  _HeightDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    height =  UInt64DTO.fromJson(json['height']);
  }

  UInt64DTO height;

  @override
  String toString() {
    return 'Height[${height.higher}, ${height.lower}]';
  }
}
