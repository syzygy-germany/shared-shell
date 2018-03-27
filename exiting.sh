#!/usr/bin/env bash

# debug calls
shared_debug=${shared_debug:-0}

shared_exiting_sh_loaded=${shared_exiting_sh_loaded:-0}
if [ "x0" != "x${shared_exiting_sh_loaded}" ]; then
  if [ "x1" == "x${shared_debug}" ]; then
    echo "--> exiting.sh already included"
  fi
else
  shared_exiting_sh_loaded=1
  
  shared_exec_err_ocurred=${shared_exec_err_ocurred:-0}

  source "${shared_install_location}/logger.sh"

  function quit() {
    __quit_result=${1:-0}
    write
    log "Exiting with result ${__quit_result}"
    exit ${__quit_result}
  }

  function signalled_exit {

    if [ ${shared_exec_err_ocurred} -ne 1 ]; then
      quit ${shared_exec_err_ocurred}
    fi
    exit 0
  }

    function check_and_exit {
    __check_and_exit_result=${1:-1}
    __check_and_exit_message=${2:-"wrong call; defaulting to exit"}
    if [ ${__check_and_exit_result} -gt 0 ]; then
      error "Step failed (${__check_and_exit_message}). See log"
      quit ${__check_and_exit_result}
    fi
  }
fi