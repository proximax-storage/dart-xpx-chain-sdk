import 'package:time_machine/time_machine.dart';
import 'package:xpx_chain_sdk/src/model/wallet/password.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

abstract class Wallet {
  String name;
  NetworkType network;
  PublicAccount publicAccount;
  LocalDateTime creationDate;
  String schema;
  Wallet(this.name, this.network, this.publicAccount, this.creationDate,
      this.schema);

  Future<Account> open(Password password);
}
