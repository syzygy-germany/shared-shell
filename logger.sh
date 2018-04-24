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
    printf "!! config not found !!"
    exit 1
  fi
  source /etc/sascha-andres/shared-shell/config

  shared_logger_tag=${shared_logger_tag:-}
  shared_verbose=${shared_verbose:-1}
  shared_logger_colored=${shared_logger_colored:-1}
  shared_logger_echo_cmd="/bin/echo -e"

  RED='\033[0m'
  GREEN='\033[0m'
  BLUE='\033[0m'
  CYAN='\033[0m'
  ORANGE='\033[0m'
  NC='\033[0m'

  if [ "${shared_logger_colored}" -eq 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    ORANGE='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
  fi

  function logger::header() {
    local content=${1:-}
    logger::write
    logger::write "${CYAN}***${NC} ${content} ${CYAN}***${NC}"
    logger::write
  }

  function logger::write() {
    local content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      if [ "x1" == "x${shared_verbose}" ]; then
        ${shared_logger_echo_cmd} "${content}"
      fi
    else
      if [ "x1" == "x${shared_verbose}" ]; then
        ${shared_logger_echo_cmd} "${content}"
      fi
      ${shared_logger_echo_cmd} "${content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function logger::writealways() {
    local content=${1:-}
    if [ "x" == "x${shared_logger_tag}" ]; then
      ${shared_logger_echo_cmd} "${content}"
    else
      ${shared_logger_echo_cmd} "${content}"
      ${shared_logger_echo_cmd} "${content}" | logger -t "${shared_logger_tag}"
    fi
  }

  function logger::warn() {
    local content=${1:-}
    logger::writealways "${ORANGE}??${NC} ${content} ${ORANGE}??${NC}"
  }

  function logger::error() {
    local content=${1:-}
    (>&2 logger::writealways "${RED}!!${NC} ${content} ${RED}??${NC}")
  }

  function logger::log() {
    local content=${1:-}
    logger::write "${BLUE}-->${NC} ${GREEN}${content}${NC}"
  }
fi