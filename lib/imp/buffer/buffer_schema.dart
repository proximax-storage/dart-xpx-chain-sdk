part of xpx_catapult_sdk.buffer;

const ByteSize = 1, ShortSize = 2, IntSize = 4;

abstract class schemaAttribute {
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition);
}

class schema {
  List<schemaAttribute> schemaDefinition;

  schema(this.schemaDefinition);

  Uint8List serialize(Uint8List buffer) {
    Uint8List resultBytes;

    var i = 0;
    for (var schemaDefinition in this.schemaDefinition) {
      var v = schemaDefinition.serialize(buffer, 4 + (i * 2), buffer[0]);
      resultBytes = _addUint8List(resultBytes, v);
      ++i;
    }
    return resultBytes;
  }
}

abstract class abstractSchemaAttribute {
  String name;
  abstractSchemaAttribute(this.name);

  Uint8List findParam(
      int innerObjectPosition, int position, Uint8List buffer, int size) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    if (offset == 0) {
      return Uint8List(0);
    }

    final v = buffer
        .getRange(
            offset + innerObjectPosition, offset + innerObjectPosition + size).toList();

    var nb = Uint8List(v.length);
    for (int i = 0; i < v.length; i++) nb[i] = v[i];
    return nb;
  }

  Uint8List findVector(
      int innerObjectPosition, int position, Uint8List buffer, int size) {
    final offset = this.offset(innerObjectPosition, position, buffer);

    final offsetLong = offset + innerObjectPosition;
    final vecStart = this.vector(offsetLong, buffer);
    final vecLength = this.vectorLength(offsetLong, buffer) * size;

    if (offset == 0) {
      return Uint8List(0);
    }

    final v = buffer.getRange(vecStart, vecStart + vecLength).toList();

    var nb = Uint8List(v.length);
    for (int i = 0; i < v.length; i++) nb[i] = v[i];
    return nb;
  }

  int offset(int innerObjectPosition, int position, Uint8List buffer) {

    var vtable = innerObjectPosition - this.readUint32(innerObjectPosition, buffer);
    if (position < this.readUint16(vtable, buffer)) {
      return this.readUint16(vtable + position, buffer);
    }

    return 0;
  }

  int readUint16(int offset, Uint8List buffer) {
    var b = buffer.getRange(offset, 2 + offset).toList();
    return (b[0]) | (b[1]) << 8;
  }

  int readUint32(int offset, Uint8List buffer) {

    var b = buffer.getRange(offset, offset+4).toList();
    return (b[0]) | (b[1]) << 8 | (b[2]) << 16 | (b[3]) << 24;
  }

  int vector(int offset, Uint8List buffer) {
    return offset + this.readUint32(offset, buffer) + 4;
  }

  int vectorLength(int offset, Uint8List buffer) {
    return this.readUint32(offset + this.readUint32(offset, buffer), buffer);
  }

  int findObjectStartPosition(
      int innerObjectPosition, int position, Uint8List buffer) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    return this.indirect(offset+innerObjectPosition, buffer);
  }

  int findArrayLength(int innerObjectPosition, int position, Uint8List buffer) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    if (offset == 0) {
      return 0;
    }
    return this.vectorLength(innerObjectPosition + offset, buffer);
  }

  int findObjectArrayElementStartPosition(int innerObjectPosition, int position,
      Uint8List buffer, int startPosition) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    final vector = this.vector(innerObjectPosition + offset, buffer);

    return this.indirect(vector + startPosition * 4, buffer);
  }

  int indirect(int offset, Uint8List buffer) {
    return offset + this.readUint32(offset, buffer);
  }
}

class arrayAttribute extends abstractSchemaAttribute implements schemaAttribute {
  int size;

  arrayAttribute(String name, int size) : super(name) {
    this.size = size;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    return this.findVector(innerObjectPosition, position, buffer, this.size);
  }
}

class scalarAttribute extends abstractSchemaAttribute implements schemaAttribute {
  int size;

  scalarAttribute(String name, int size) : super(name) {
    this.size = size;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    return this.findParam(innerObjectPosition, position, buffer, this.size);
  }
}

class tableArrayAttribute extends abstractSchemaAttribute implements schemaAttribute {
  List<schemaAttribute> schema;

  tableArrayAttribute(String name, List<schemaAttribute> schema) : super(name) {
    this.schema = schema;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    List<int> resultBytes= [];

    var arrayLength = this.findArrayLength(innerObjectPosition, position, buffer);
    for (int i = 0; i < arrayLength; i++) {
      var startArrayPosition = this.findObjectArrayElementStartPosition(innerObjectPosition, position, buffer, i);
      int j = 0;
      for (var element in this.schema) {
        var tmp = element.serialize(buffer, 4 + j * 2, startArrayPosition);

        if (tmp.length == 1){
          resultBytes = [tmp.elementAt(0)];
        }else{
          resultBytes.addAll(tmp);
        }
        ++j;
      }
    }
    var byteList = new Uint8List(resultBytes.length);
    for (int i = 0; i < resultBytes.length; i++) byteList[i] = resultBytes[i];

    return byteList;
  }
}

class tableAttribute extends abstractSchemaAttribute implements schemaAttribute {
  List<schemaAttribute> schema;

  tableAttribute(String name, List<schemaAttribute> schema) : super(name) {
    this.schema = schema;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    List<int> resultBytes = [];
    var tableStartPosition =
        this.findObjectStartPosition(innerObjectPosition, position, buffer);
    int j = 0;
    for (var element in this.schema) {
      var tmp = element.serialize(buffer, 4 + j * 2, tableStartPosition);
      ++j;
      if (tmp.length == 1){
        resultBytes = [tmp.elementAt(0)];
      }else{
        resultBytes.addAll(tmp);
      }
    }

    var byteList = new Uint8List(resultBytes.length);
    for (int i = 0; i < resultBytes.length; i++) byteList[i] = resultBytes[i];

    return byteList;
  }
}

arrayAttribute _newArrayAttribute(String name, int size) {
  return new arrayAttribute(name, size);
}

scalarAttribute _newScalarAttribute(String name, int size) {
  return new scalarAttribute(name, size);
}

tableArrayAttribute _newTableArrayAttribute(String name, List<schemaAttribute> schema) {
  return new tableArrayAttribute(name, schema);
}

tableAttribute _newTableAttribute(String name, List<schemaAttribute> schema) {
  return new tableAttribute(name, schema);
}

Uint8List _addUint8List(Uint8List a, Uint8List b) {
  if (a == null){
    return b;
  }
  Uint8List hash = Uint8List(b.length + a.length);
  for (int i = 0; i < a.length; i++) hash[i] = a[i];
  for (int i = 0; i < b.length; i++) hash[i + a.length] = b[i];
  return hash;
}