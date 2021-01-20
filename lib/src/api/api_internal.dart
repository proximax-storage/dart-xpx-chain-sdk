part of xpx_chain_sdk.api;

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};

// port from Java version
Iterable<QueryParam> _convertParametersForCollectionFormat(String collectionFormat, String name, value) {
  final params = <QueryParam>[];

  // preconditions
  if (name == null || name.isEmpty || value == null) {
    return params;
  }

  if (value is! List) {
    params.add(QueryParam(name, _parameterToString(value)));
    return params;
  }

  final List values = value;

  // get the collection format
  // ignore: parameter_assignments
  collectionFormat = (collectionFormat == null || collectionFormat.isEmpty) ? 'csv' : collectionFormat; // default: csv

  if (collectionFormat == 'multi') {
    return values.map((v) => QueryParam(name, _parameterToString(v)));
  }

  final String delimiter = _delimiters[collectionFormat] ?? ',';

  params.add(QueryParam(name, values.map(_parameterToString).join(delimiter)));
  return params;
}

/// Format the given parameter object into string.
String _parameterToString(value) {
  if (value == null) {
    return '';
  } else if (value is DateTime) {
    return value.toUtc().toIso8601String();
  } else {
    return value.toString();
  }
}
