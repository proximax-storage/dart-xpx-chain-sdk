part of xpx_chain_sdk.model.transaction;

class TransactionWithPagination {
  final List<Transaction> transactions;
  final Pagination pagination;

  TransactionWithPagination(this.transactions, this.pagination);

  factory TransactionWithPagination.fromDto(
          List<Transaction> transactions, Map<String, dynamic> json) =>
      TransactionWithPagination(
        transactions,
        Pagination.fromJson(json['pagination']),
      );
}

class Pagination {
  final int totalEntries;
  final int pageNumbers;
  final int pageSize;

  Pagination(this.totalEntries, this.pageNumbers, this.pageSize);

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      Pagination(json['totalEntries'], json['pageNumbers'], json['pageSize']);
}
