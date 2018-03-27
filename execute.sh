#!/usr/bin/env bash

# debug calls
shared_debug=${shared_debug:-0}

shared_execute_sh_loaded=${shared_execute_sh_loaded:-0}
if [ "x0" != "x${shared_execute_sh_loaded}" ]; then
  if [ "x1" == "x${shared_debug}" ]; then
    echo "--> execute.sh already included"
  fi
else
  shared_execute_sh_loaded=1
  if [ ! -e /etc/sascha-andres/shared-shell/config ]; then
    echo "!! config not found !!"
    exit 1
  fi
  source /etc/sascha-andres/shared-shell/config

  shared_exec_err_ocurred=${shared_exec_err_ocurred:-0}

  source "${shared_install_location}/logger.sh"
  source "${shared_install_location}/exiting.sh"

  function check_and_error {
    __check_and_error_result=${1:-1}
    __check_and_error_message=${2:-"wrong call; defaulting to error"}
    if [ ${__check_and_error_result} -ne 0 ]; then
      shared_exec_err_ocurred=${__check_and_error_result}
      error "Step failed (${__check_and_error_message}). See log"
    fi
  }

  function exec_and_continue_on_ok() {
    __exec_and_continue_on_ok_call=${1:-"/bin/false"}
    log "Executing [${__exec_and_continue_on_ok_call}] in [$(pwd)]"
    eval ${__exec_and_continue_on_ok_call}
    result=$?
    check_and_exit $result ${__exec_and_continue_on_ok_call}
  }

fi