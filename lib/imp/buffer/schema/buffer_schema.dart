part of xpx_chain_sdk.buffer;

const byteSize = 1, shortSize = 2, intSize = 4;

abstract class SchemaAttribute {
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition);
}

class Schema {
  List<SchemaAttribute> schemaDefinition;

  Schema(this.schemaDefinition);

  Uint8List serialize(Uint8List buffer) {
    List<int> resultBytes = [];

    var i = 0;
    for (var schemaDefinition in this.schemaDefinition) {
      var v = schemaDefinition.serialize(buffer, 4 + (i * 2), buffer[0]);
      if (v.isNotEmpty) {
        resultBytes.addAll(v);
      }
      ++i;
    }
    return new Uint8List.fromList(resultBytes);
  }
}

abstract class AbstractSchemaAttribute {
  String name;
  AbstractSchemaAttribute(this.name);

  Uint8List findParam(
      int innerObjectPosition, int position, Uint8List buffer, int size) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    if (offset == 0) {
      return Uint8List(0);
    }

    final v = buffer
        .getRange(
            offset + innerObjectPosition, offset + innerObjectPosition + size)
        .toList();

    return new Uint8List.fromList(v);
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

    return new Uint8List.fromList(v);
  }

  int offset(int innerObjectPosition, int position, Uint8List buffer) {
    var f = this.readUint32(innerObjectPosition, buffer);
    var vtable = fromBigInt(BigInt.from(innerObjectPosition - f)).elementAt(0);
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
    var b = buffer.getRange(offset, offset + 4).toList();
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
    return this.indirect(offset + innerObjectPosition, buffer);
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

class ArrayAttribute extends AbstractSchemaAttribute
    implements SchemaAttribute {
  int size;

  ArrayAttribute(String name, int size) : super(name) {
    this.size = size;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    return this.findVector(innerObjectPosition, position, buffer, this.size);
  }
}

class ScalarAttribute extends AbstractSchemaAttribute
    implements SchemaAttribute {
  int size;

  ScalarAttribute(String name, int size) : super(name) {
    this.size = size;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    return this.findParam(innerObjectPosition, position, buffer, this.size);
  }
}

class TableArrayAttribute extends AbstractSchemaAttribute
    implements SchemaAttribute {
  List<SchemaAttribute> schema;

  TableArrayAttribute(String name, List<SchemaAttribute> schema) : super(name) {
    this.schema = schema;
  }

  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    List<int> resultBytes = [];

    var arrayLength =
        this.findArrayLength(innerObjectPosition, position, buffer);
    for (int i = 0; i < arrayLength; i++) {
      var startArrayPosition = this.findObjectArrayElementStartPosition(
          innerObjectPosition, position, buffer, i);
      int j = 0;
      for (var element in this.schema) {
        var tmp = element.serialize(buffer, 4 + j * 2, startArrayPosition);

        if (tmp.length == 1) {
          resultBytes = [tmp.elementAt(0)];
        } else {
          resultBytes.addAll(tmp);
        }
        ++j;
      }
    }

    return new Uint8List.fromList(resultBytes);
  }
}

class TableAttribute extends AbstractSchemaAttribute
    implements SchemaAttribute {
  List<SchemaAttribute> schema;

  TableAttribute(String name, List<SchemaAttribute> schema) : super(name) {
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
      if (tmp.length == 1) {
        resultBytes = [tmp.elementAt(0)];
      } else {
        resultBytes.addAll(tmp);
      }
    }

    return new Uint8List.fromList(resultBytes);
  }
}

ArrayAttribute _newArrayAttribute(String name, int size) {
  return new ArrayAttribute(name, size);
}

ScalarAttribute _newScalarAttribute(String name, int size) {
  return new ScalarAttribute(name, size);
}

TableArrayAttribute _newTableArrayAttribute(
    String name, List<SchemaAttribute> schema) {
  return new TableArrayAttribute(name, schema);
}

TableAttribute _newTableAttribute(String name, List<SchemaAttribute> schema) {
  return new TableAttribute(name, schema);
}
