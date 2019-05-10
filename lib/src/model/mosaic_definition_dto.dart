part of xpx_catapult_sdk;

class _mosaicDefinitionDTO {
  UInt64DTO mosaicId = null;

  UInt64DTO supply = null;

  UInt64DTO height = null;

  String owner = null;

  int revision = null;

  List<UInt64DTO> properties = null;

  Object levy = null;

  _mosaicDefinitionDTO();

  @override
  String toString() {
    return '{MosaicId=$mosaicId, Supply=$supply, Height=$height, Owner=$owner, Revision=$revision, Properties=$properties}';
  }

  _mosaicDefinitionDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    } else {
      properties = new List(json['properties'].length);
    }

    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    supply = new UInt64DTO.fromJson(json['supply']);
    height = new UInt64DTO.fromJson(json['height']);
    owner = json['owner'];
    revision = json['revision'];
    for (int i = 0; i < 3; i++)
      properties[i] = (UInt64DTO.fromJson(json['properties'][i]));
  }
}
