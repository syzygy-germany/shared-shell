#! /usr/bin/env bash

shared_install_location=$(pwd)
shared_debug=0

if [ ! -e /etc/sascha-andres/shared-shell/config ]; then
  echo "!! config not found !!"
  exit 1
fi
source /etc/sascha-andres/shared-shell/config
source "${shared_install_location}/logger.sh"
source "${shared_install_location}/execute.sh"
source "${shared_install_location}/exiting.sh"

header "header"
log "log"
warn "warn"
error "error"
writealways "writealways"

header "execute"
exec_and_continue_on_ok "echo 'a'"

header "exiting"
quit 0