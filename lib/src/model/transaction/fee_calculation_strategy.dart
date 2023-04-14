part of xpx_chain_sdk.model.transaction;

enum FeeCalculationStrategy {
  zeroFeeCalculationStrategy,
  lowFeeCalculationStrategy,
  middleFeeCalculationStrategy,
  highFeeCalculationStrategy
}

extension FeeCalculationStrategyExtension on FeeCalculationStrategy {
  int get value {
    switch (this) {
      case FeeCalculationStrategy.zeroFeeCalculationStrategy:
        return 0;
      case FeeCalculationStrategy.lowFeeCalculationStrategy:
        return 15000;
      case FeeCalculationStrategy.middleFeeCalculationStrategy:
        return 150000;
      case FeeCalculationStrategy.highFeeCalculationStrategy:
        return 1500000;
      default:
        throw Exception('Unknown fee calculation strategy.');
    }
  }
}

const FeeCalculationStrategy defaultFeeCalculationStrategy =
    FeeCalculationStrategy.middleFeeCalculationStrategy;

Uint64 calculateFee(int transactionByteSize,
        [FeeCalculationStrategy feeCalculationStratgy =
            defaultFeeCalculationStrategy])
    // return UInt64.fromUint(Math.min(DefaultMaxFee, transactionByteSize * feeCalculationStratgy));
    =>
    Uint64(transactionByteSize * feeCalculationStratgy.value);
