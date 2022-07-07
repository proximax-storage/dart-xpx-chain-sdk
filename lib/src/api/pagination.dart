/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

/// totalEntries : 6
/// pageNumber : 1
/// pageSize : 20
/// totalPages : 1

Pagination paginationFromJson(String str) => Pagination.fromJson(json.decode(str));

String paginationToJson(Pagination data) => json.encode(data.toJson());

class Pagination {
  Pagination({required this.totalEntries, required this.pageNumber, required this.pageSize, required this.totalPages});

  factory Pagination.fromJson(json) {
    final totalEntries = json['totalEntries'];
    final pageNumber = json['pageNumber'];
    final pageSize = json['pageSize'];
    final totalPages = json['totalPages'];
    return Pagination(totalEntries: totalEntries, pageNumber: pageNumber, pageSize: pageSize, totalPages: totalPages);
  }

  final int totalEntries;
  final int pageNumber;
  final int pageSize;
  final int totalPages;

  Pagination copyWith({
    int? totalEntries,
    int? pageNumber,
    int? pageSize,
    int? totalPages,
  }) =>
      Pagination(
        totalEntries: totalEntries ?? this.totalEntries,
        pageNumber: pageNumber ?? this.pageNumber,
        pageSize: pageSize ?? this.pageSize,
        totalPages: totalPages ?? this.totalPages,
      );

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalEntries'] = totalEntries;
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
