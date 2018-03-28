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

header "loader"
write "Logger is loaded: $(__module_loaded logger)"

header "header"
log "log"
warn "warn"
error "error"
writealways "writealways"

header "execute"
exec_and_continue_on_ok "echo 'a'"

header "exiting"
quit 0