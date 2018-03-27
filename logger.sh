#!/usr/bin/env bash

# debug calls
shared_debug=${shared_debug:-0}

shared_logger_sh_loaded=${shared_logger_sh_loaded:-0}
if [ "x0" != "x${shared_logger_sh_loaded}" ]; then
  if [ "x1" == "x${shared_debug}" ]; then
    log "logger.sh already included"
  fi
else
  shared_logger_sh_loaded=1
  
  if [ ! -e /etc/sascha-andres/shared-shell/config ]; then
    echo "!! config not found !!"
    exit 1
  fi
  source /etc/sascha-andres/shared-shell/config

  shared_logger_tag=${shared_logger_tag:-}
  shared_verbose=${shared_verbose:-1}

  function header() {
    __header_content=${1:-}
    write
    write "*** ${__header_content} ***"
    write
  }

  function write() {
    __write_content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      if [ "x1" == "x${shared_verbose}" ]; then
        echo "${__write_content}"
      fi
    else
      if [ "x1" == "x${shared_verbose}" ]; then
        echo "${__write_content}"
      fi
      echo "${__write_content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function writealways() {
    __writealways_content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      echo "${__writealways_content}"
    else
      echo "${__writealways_content}"
      echo "${__writealways_content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function warn() {
    __warn_content=${1:-}
    writealways "?? ${__warn_content} ??"
  }

  function error() {
    __error_content=${1:-}
    (>&2 echo "!! ${__error_content} !!")
  }

  function log() {
    __log_content=${1:-}
    write "--> ${__log_content}"
  }
fi