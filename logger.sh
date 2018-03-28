#!/usr/bin/env bash

# debug calls
shared_debug=${shared_debug:-0}

shared_logger_sh_loaded=${shared_logger_sh_loaded:-0}
if [ "x1" == "x${shared_logger_sh_loaded}" ]; then
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
    local content=${1:-}
    write
    write "*** ${content} ***"
    write
  }

  function write() {
    local content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      if [ "x1" == "x${shared_verbose}" ]; then
        echo "${content}"
      fi
    else
      if [ "x1" == "x${shared_verbose}" ]; then
        echo "${content}"
      fi
      echo "${content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function writealways() {
    local content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      echo "${content}"
    else
      echo "${content}"
      echo "${content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function warn() {
    local content=${1:-}
    writealways "?? ${content} ??"
  }

  function error() {
    local content=${1:-}
    (>&2 echo "!! ${content} !!")
  }

  function log() {
    local content=${1:-}
    write "--> ${content}"
  }
fi