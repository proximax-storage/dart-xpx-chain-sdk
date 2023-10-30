part of xpx_chain_sdk.model.transaction;

class TransactionWithPagination {
  final List<Transaction> transactions;
  final Pagination? pagination;

  TransactionWithPagination(this.transactions, this.pagination);

  factory TransactionWithPagination.fromDto(
          List<Transaction> transactions, Map<String, dynamic>? json) =>
      TransactionWithPagination(
        transactions,
        json == null ? null : Pagination.fromJson(json),
      );
}

class Pagination {
  final int totalEntries;
  final int pageNumber;
  final int pageSize;
  final int totalPages;

  Pagination(
      this.totalEntries, this.pageNumber, this.pageSize, this.totalPages);

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
      json['totalEntries'],
      json['pageNumber'],
      json['pageSize'],
      json['totalPages']);
}
