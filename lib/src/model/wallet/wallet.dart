/*
 * Copyright 2018 NEM
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of xpx_chain_sdk.wallet;

/*
 * Wallet base model
 */
abstract class Wallet {
  /*
  * The wallet's name
  */
  late final String name;
  /*
  * The wallet's network
  */
  late final NetworkType network;
  /*
  * The wallet's publicAccount
  */
  late final PublicAccount publicAccount;
  /*
  * The wallet's creation date
  */
  late final LocalDateTime creationDate;
  /*
  * Wallet schema number
  */
  late final String schema;
  Wallet(this.name, this.network, this.publicAccount, this.creationDate,
      this.schema);

  /*
     * Abstract open wallet method returning an account from current wallet.
     * @param password - Password to open wallet.
     * @returns {Account}
     */
  Future<Account> open(Password password);
}
