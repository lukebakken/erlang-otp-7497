# erlang-otp-7497

https://github.com/erlang/otp/issues/7497

# Reproduction steps

## My test environment

**NOTE:** the code requires the use of the `asdf` version manager, with Erlang `25.3.2.3` and `26.0.2` installed.

* Arch Linux
* `asdf` version manager
* OpenSSL 3.1.1
* Erlang crypto statically linked to OpenSSL 3.1.1
    ```
    KERL_CONFIGURE_OPTIONS="--enable-kernel-poll \
        --enable-silent-rules=no \
        --enable-smp-support \
        --enable-threads \
        --with-microstate-accounting=extra \
        --without-cdv \
        --without-debugger \
        --without-docs \
        --without-et \
        --without-observer \
        --without-odbc \
        --without-wx \
        --with-ssl=$HOME/opt/openssl/3.1.1 --with-ssl-rpath=no --disable-dynamic-ssl-lib"
    ```

## Clone repo

```
git clone https://github.com/lukebakken/erlang-otp-7497.git
cd erlang-otp-7497
```

## Setup

The following will generate server and client x509 certificates using `rabbitmq/tls-gen`, and create `inet-dist-tls.config` with the correct paths to the certificate files:

```
./setup.sh
```

## Start node `a`

This will start a node with shortname `a` and `-proto_dist inet_tls`:

```
./run-node.sh a
```

## Start node `b`

This will start a node with shortname `b` and `-proto_dist inet_tls`. In addition, during startup, `net_kernel:connect_node/1` is used to connect to node `a`, and then a list of connected nodes is displayed:

```
./run-node.sh b
```

The output will contain a list containing node `a`:

```
['a@shostakovich']
```
