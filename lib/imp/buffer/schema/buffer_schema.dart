part of xpx_chain_sdk.buffer.schema;

const _byteSize = 1, _shortSize = 2, _intSize = 4;

// ignore: one_member_abstracts
abstract class SchemaAttribute {
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition);
}

class Schema {
  Schema(this.schemaDefinition);

  List<SchemaAttribute> schemaDefinition;

  Uint8List serialize(Uint8List buffer) {
    final resultBytes = <int>[];
    var i = 0;
    for (final schemaDefinition in schemaDefinition) {
      final v = schemaDefinition.serialize(buffer, 4 + (i * 2), buffer[0]);
      if (v.isNotEmpty) {
        resultBytes.addAll(v);
      }

      ++i;
    }
    return Uint8List.fromList(resultBytes);
  }
}

abstract class AbstractSchemaAttribute {
  AbstractSchemaAttribute(this.name);

  String name;

  Uint8List findParam(int innerObjectPosition, int position, Uint8List buffer, int size) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    if (offset == 0) {
      return Uint8List(0);
    }

    final v = buffer.getRange(offset + innerObjectPosition, offset + innerObjectPosition + size).toList();

    return Uint8List.fromList(v);
  }

  Uint8List findVector(int innerObjectPosition, int position, Uint8List buffer, int size) {
    final offset = this.offset(innerObjectPosition, position, buffer);

    final offsetLong = offset + innerObjectPosition;
    final vecStart = vector(offsetLong, buffer);
    final vecLength = vectorLength(offsetLong, buffer) * size;

    if (offset == 0) {
      return Uint8List(0);
    }

    final v = buffer.getRange(vecStart, vecStart + vecLength).toList();

    return Uint8List.fromList(v);
  }

  int offset(int innerObjectPosition, int position, Uint8List buffer) {
    final vTable = innerObjectPosition - readUint32(innerObjectPosition, buffer);
    return position < readUint16(vTable, buffer) ? readUint16(vTable + position, buffer) : 0;
  }

  int readUint16(int offset, Uint8List buffer) {
    final b = buffer.getRange(offset.toUnsigned(32), 2 + offset.toUnsigned(32)).toList();
    return (b[0]) | (b[1]) << 8;
  }

  int readUint32(int offset, Uint8List buffer) {
    final b = buffer.getRange(offset.toUnsigned(32), offset.toUnsigned(32) + 4).toList();
    return (b[0]) | (b[1]) << 8 | (b[2]) << 16 | (b[3]) << 24;
  }

  int vector(int offset, Uint8List buffer) => offset + readUint32(offset, buffer) + 4;

  int vectorLength(int offset, Uint8List buffer) => readUint32(offset + readUint32(offset, buffer), buffer);

  int findObjectStartPosition(int innerObjectPosition, int position, Uint8List buffer) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    return indirect(offset + innerObjectPosition, buffer);
  }

  int findArrayLength(int innerObjectPosition, int position, Uint8List buffer) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    if (offset == 0) {
      return 0;
    }
    return vectorLength(innerObjectPosition + offset, buffer);
  }

  int findObjectArrayElementStartPosition(int innerObjectPosition, int position, Uint8List buffer, int startPosition) {
    final offset = this.offset(innerObjectPosition, position, buffer);
    final vector = this.vector(innerObjectPosition + offset, buffer);

    return indirect(vector + startPosition * 4, buffer);
  }

  int indirect(int offset, Uint8List buffer) => offset + readUint32(offset, buffer);

  @override
  String toString() => '$name';
}

class ArrayAttribute extends AbstractSchemaAttribute implements SchemaAttribute {
  ArrayAttribute(String name, this.size) : super(name);

  int size;

  @override
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) =>
      findVector(innerObjectPosition, position, buffer, size);

  @override
  String toString() => '$name, $size';
}

class ScalarAttribute extends AbstractSchemaAttribute implements SchemaAttribute {
  ScalarAttribute(String name, this.size) : super(name);

  int size;

  @override
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) =>
      findParam(innerObjectPosition, position, buffer, size);

  @override
  String toString() => '$name, $size';
}

class TableArrayAttribute extends AbstractSchemaAttribute implements SchemaAttribute {
  TableArrayAttribute(String name, this.schema) : super(name);

  List<SchemaAttribute> schema;

  @override
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    final List<int> resultBytes = [];

    final arrayLength = findArrayLength(innerObjectPosition, position, buffer);

    for (int i = 0; i < arrayLength; i++) {
      final startArrayPosition = findObjectArrayElementStartPosition(innerObjectPosition, position, buffer, i);
      int j = 0;
      for (final element in schema) {
        final tmp = element.serialize(buffer, 4 + j * 2, startArrayPosition);

        if (tmp.length == 1) {
          resultBytes.addAll([tmp.elementAt(0)]);
        } else {
          resultBytes.addAll(tmp);
        }
        ++j;
      }
    }

    return Uint8List.fromList(resultBytes);
  }
}

class TableAttribute extends AbstractSchemaAttribute implements SchemaAttribute {
  TableAttribute(String name, this.schema) : super(name);

  List<SchemaAttribute> schema;

  @override
  Uint8List serialize(Uint8List buffer, int position, int innerObjectPosition) {
    final resultBytes = <int>[];
    final tableStartPosition = findObjectStartPosition(innerObjectPosition, position, buffer);

    int j = 0;
    for (final element in schema) {
      final tmp = element.serialize(buffer, 4 + j * 2, tableStartPosition);
      ++j;
      if (tmp.length == 1) {
        resultBytes.addAll([tmp.elementAt(0)]);
      } else {
        resultBytes.addAll(tmp);
      }
    }

    return Uint8List.fromList(resultBytes);
  }
}

ArrayAttribute arrayAttribute(String name, int size) => ArrayAttribute(name, size);

ScalarAttribute scalarAttribute(String name, int size) => ScalarAttribute(name, size);

TableArrayAttribute tableArrayAttribute(String name, List<SchemaAttribute> schema) => TableArrayAttribute(name, schema);

TableAttribute tableAttribute(String name, List<SchemaAttribute> schema) => TableAttribute(name, schema);

List<SchemaAttribute> commonSchema() => [
      scalarAttribute('size', _intSize),
      arrayAttribute('signature', _byteSize),
      arrayAttribute('signer', _byteSize),
      scalarAttribute('version', _intSize),
      scalarAttribute('type', _shortSize),
      arrayAttribute('maxFee', _intSize),
      arrayAttribute('deadline', _intSize),
    ];
