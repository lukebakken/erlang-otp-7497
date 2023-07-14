#!/usr/bin/env bash

set -o errexit
set -o nounset

asdf current

declare -r nodename="${1:-a}"

declare -r script_dir="$(realpath "$(dirname "$BASH_SOURCE")")"

declare -r erl_ssl_path="$(erl -noinput -eval 'io:format("~s~n", [filename:dirname(code:which(inet_tls_dist))])' -s init stop)"

if [[ $nodename == 'a' ]]
then
    erl -pa "$erl_ssl_path" -proto_dist inet_tls -ssl_dist_optfile "$script_dir/inet-dist-tls.config" -sname a -eval 'net_kernel:verbose(2).'
else
    erl -pa "$erl_ssl_path" -proto_dist inet_tls -ssl_dist_optfile "$script_dir/inet-dist-tls.config" -sname b -eval "net_kernel:verbose(2), net_kernel:connect_node(a@$HOSTNAME), erlang:display(nodes())"
fi
