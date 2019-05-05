part of xpx_catapult_sdk ;

class Mosaic {
  BigInt id = null;

  BigInt amount = null;

  Mosaic();

  @override
  String toString() {
    return '\n\t{\n'
        '\t"MosaicId": $id,\n'
        '\t"Amount": $amount\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount};
  }

  Mosaic.fromDTO(_mosaicDTO v) {
    id = v.id.toBigInt();
    amount = v.amount.toBigInt();
  }
}
