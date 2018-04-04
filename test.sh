#! /usr/bin/env bash

shared_install_location=$(pwd)
shared_debug=0

if [ ! -e /etc/sascha-andres/shared-shell/config ]; then
  echo "!! config not found !!"
  exit 1
fi
source /etc/sascha-andres/shared-shell/config

__import logger
__import execute
__import exiting

__header "loader"
__write "Logger is loaded: $(__module_loaded logger)"

__header "header"
__log "log"
__warn "warn"
__error "error"
__writealways "writealways"

__header "execute"
__exec_and_continue_on_ok "echo 'a'"

__header "exiting"
__quit 0