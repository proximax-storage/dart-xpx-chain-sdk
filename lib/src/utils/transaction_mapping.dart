part of xpx_chain_sdk.model.utils;

class TransactionMapping {
  static Transaction createFromPayload(String dataBytes) =>
      CreateTransactionFromPayload(dataBytes);
}
