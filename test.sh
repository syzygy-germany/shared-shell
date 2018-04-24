#! /usr/bin/env bash

shared_install_location=$(pwd)
shared_debug=0

if [ ! -e "$(pwd)/sys-config/config.sh" ]; then
  echo "!! config not found !!"
  exit 1
fi
source "$(pwd)/sys-config/config.sh"

pkg::import logger
pkg::import execute
pkg::import exiting

logger::header "loader"
logger::write "Logger is loaded: $(pkg::module_loaded logger)"

logger::header "header"
logger::log "log"
logger::warn "warn"
logger::error "error"
logger::writealways "writealways"

logger::header "execute"
execute::exec_and_continue_on_ok "echo 'a'"

logger::header "exiting"
exiting::quit 0