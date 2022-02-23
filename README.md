# ngs-xacct-demo

# Setups
* [Stage environment instructions](https://github.com/ConnectEverything/ops-info/blob/main/Logbooks/2020-10-create-test-accounts.md)

## Add an NGS Operator (optional), new Accounts, and new Users

> Note: NGS account (production) created earlier to boostrap the ngs, nsc, and env tools used below.

Use the NGS version of tools, keys, and creds:

`cd <projectdir>; source ~/.nsc/env`

Before adds:

```text
$ nsc env
+----------------------------------------------------------------------------------------------------------+
|                                             NSC Environment                                              |
+--------------------+-----+-------------------------------------------------------------------------------+
| Setting            | Set | Effective Value                                                               |
+--------------------+-----+-------------------------------------------------------------------------------+
| $NSC_CWD_ONLY      | No  | If set, default operator/account from cwd only                                |
| $NSC_NO_GIT_IGNORE | No  | If set, no .gitignore files written                                           |
| $NKEYS_PATH        | No  | ~/.nkeys                                                                      |
| $NSC_HOME          | No  | ~/.nsc                                                                        |
| Config             |     | ~/.nsc/nsc.json                                                               |
| $NATS_CA           | No  | If set, root CAs in the referenced file will be used for nats connections     |
|                    |     | If not set, will default to the system trust store                            |
| $NATS_KEY          | No  | If set, the tls key in the referenced file will be used for nats connections  |
| $NATS_CERT         | No  | If set, the tls cert in the referenced file will be used for nats connections |
+--------------------+-----+-------------------------------------------------------------------------------+
| From CWD           |     | No                                                                            |
| Stores Dir         |     | ~/.nsc/nats                                                                   |
| Default Operator   |     | synadia                                                                       |
| Default Account    |     | NGSAcctA                                                                      |
| Root CAs to trust  |     | Default: System Trust Store                                                   |
+--------------------+-----+-------------------------------------------------------------------------------+
```
Accounts and Users in Production NGS (before during Test NGS work):
```text
$ nsc list accounts
+---------------------------------------------------------------------+
|                              Accounts                               |
+----------+----------------------------------------------------------+
| Name     | Public Key                                               |
+----------+----------------------------------------------------------+
| NGSAcctA | AB7QOFQ5Y3G3U7CG2OVZZVCLY4AGTMSPV4ISLEPANOBRCHNLHGVBAUFK |
+----------+----------------------------------------------------------+

$ nsc list users
+---------------------------------------------------------------------+
|                                Users                                |
+----------+----------------------------------------------------------+
| Name     | Public Key                                               |
+----------+----------------------------------------------------------+
| NGSAcctA | UDC4VIHTVVMQVS4X3AQNRRV7RY7WYLIX4QUUHII3S45HQWTJQIMKFX6C |
+----------+----------------------------------------------------------+

$ nsc list operators
+--------------------------------------------------------------------------------------------------+
|                                            Operators                                             |
+---------------------------------------+----------------------------------------------------------+
| Name                                  | Public Key                                               |
+---------------------------------------+----------------------------------------------------------+
| synadia (Synadia Communications Inc.) | ODLC22NIQQ5U4J6ZDTVOFKTEX4F77E7TVM2RHWSG7N266YOVKTRI4EWX |
+---------------------------------------+----------------------------------------------------------+
```

## Test Synadia NGS Setup

> Note: Adding an operator sets it as the new default for further operations.  Same with adding an account.  Use `nsc env`
to select different defaults explicitly.

```text
$ nsc add operator --name test-syn -u https://ngs-api.stage.synadia-ops.com/jwt/v2/operator
[ OK ] imported operator "test-syn"
[ OK ] When running your own nats-server, make sure they run at least version 2.2.0

# For a, b, c test accounts:
$ nsc add account $(id -un)-test-c
[ OK ] generated and stored account key "ABTJUJC5DHOPQHI2WLUDUBTYDDNJKP45J7SWUDPP673TK3X7U5FUGU33"
[ OK ] push jwt to account server:
       [ OK ] pushed account jwt to the account server
       > NGS created a new free billing account for your JWT, todd-test-c [ABTJUJC5DHOP].
       > Use the 'ngs' command to manage your billing plan.
       > If your account JWT is *not* in ~/.nsc, use the -d flag on ngs commands to locate it.
[ OK ] pull jwt from account server
[ OK ] added account "todd-test-c"

# For ash, birch, and cherry users:
$ nsc add user --account $(id -un)-test-b --name test-birch
[ OK ] generated and stored user key "UD4IADK6JAF7AWIOVSPMHSWKPBLEHTOCIJEOR573WASXDON6PQGZCRAF"
[ OK ] generated user creds file `~/.nkeys/creds/test-syn/todd-test-b/test-birch.creds`
[ OK ] added user "test-birch" to account "todd-test-b"

# Create NATS CLI connection contexts for convenience:
nats -s tls://connect.ngs.synadia-test.com --creds ~/.nkeys/creds/test-syn/$(id -un)-test-a/test-ash.creds context save --description "Test-NGS account $(id -un)-test-a user test-ash" test-a
nats -s tls://connect.ngs.synadia-test.com --creds ~/.nkeys/creds/test-syn/$(id -un)-test-b/test-birch.creds context save --description "Test-NGS account $(id -un)-test-b user test-birch" test-b
nats -s tls://connect.ngs.synadia-test.com --creds ~/.nkeys/creds/test-syn/$(id -un)-test-c/test-cherry.creds context save --description "Test-NGS account $(id -un)-test-c user test-cherry" test-c

# Typical pub/sub now works
nats ctx select test-a
nats pub foo hello
```

> Request JetStream enablement from Synadia (manually) for created accounts.

