library xpx_chain_sdk.test.conf;

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

final TestingAccount =
    Account.fromPrivateKey('26b64cb10f005e5988a36744ca19e20d835ccc7c105aaa5f3b212da593180930', NetworkType.MIJIN_TEST);

final MultisigAccount =
    Account.fromPrivateKey('5edebfdbeb32e9146d05ffd232c8af2cf9f396caf9954289daa0362d097fff3b', NetworkType.MIJIN_TEST);

final CosignatoryAccount =
    Account.fromPrivateKey('2a2b1f5d366a5dd5dc56c3c757cf4fe6c66e2787087692cf329d7a49a594658b', NetworkType.MIJIN_TEST);

final Cosignatory2Account =
    Account.fromPrivateKey('b8afae6f4ad13a1b8aad047b488e0738a437c7389d4ff30c359ac068910c1d59', NetworkType.MIJIN_TEST);

final Cosignatory3Account =
    Account.fromPrivateKey('111602be4d36f92dd60ca6a3c68478988578f26f6a02f8c72089839515ab603e', NetworkType.MIJIN_TEST);

final Customer1Account =
    Account.fromPrivateKey('c2b069398cc135645fa0959708ad2504f3dcfdb12a8b95c015ecbd16e29aeb77', NetworkType.PUBLIC_TEST);

final Executor1Account =
    Account.fromPrivateKey('0e02cce89fb87546f21b0b594461dcbea8b0a33743095870c3a1cd914e38be62', NetworkType.PUBLIC_TEST);

final Verifier1Account =
    Account.fromPrivateKey('c8a449299d45b26e4679b5fdd8e39a73fccd74f77444a8bf68d2893a93d29770', NetworkType.PUBLIC_TEST);
