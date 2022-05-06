/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

enum MosaicLevyType { levyNone, levyAbsoluteFee, levyPercentileFee }

extension MosaicLevyTypeIntExt on int {
  MosaicLevyType get toLevyType {
    if (this == 1) {
      return MosaicLevyType.levyAbsoluteFee;
    } else if (this == 2) {
      return MosaicLevyType.levyPercentileFee;
    } else {
      return MosaicLevyType.levyNone;
    }
  }
}

extension MosaicLevyTypeExt on MosaicLevyType {
  int get toInt => index;
}
