#! /usr/bin/env bash

shared_module_loaded=${shared_module_loaded:-0}
if [ "x0" == "x${shared_module_loaded}" ]; then
  set -u

  shared_module_loaded=1

  shared_install_location=${shared_install_location:-"/opt/sascha-andres/shell"}
  shared_debug=${shared_debug:-0}
  shared_pipefail=${shared_pipefail:-1}
  shared_exit_immediatly=${shared_exit_immediatly:-1}

  if [ "x1" == "x${shared_debug}" ]; then
    set -x
  fi
  if [ "x1" == "x${shared_exit_immediatly}" ]; then
    set -e
  fi
  if [ "x1" == "x${shared_pipefail}" ]; then
    set -o pipefail
  fi

  declare -a shared_loaded_modules

  function pkg::module_loaded() {
    local value=${1:-}
    shared_loaded_modules=${shared_loaded_modules:-} 
    for module in "${shared_loaded_modules[@]}"; do
      if [ "x${module}" == "x${value}" ]; then
        echo "y"
        return 0
      fi
    done
    echo "n"
    return 0
  }

  function pkg::import() {
    module=${1:-}
    shared_loaded_modules=${shared_loaded_modules:-} 
    if [ $(pkg::module_loaded ${module}) == "n" ]; then
      if [ "x" != "x${module}" ]; then
        if [ -e "${shared_install_location}/${module}.sh" ]; then
          shared_loaded_modules=("${shared_loaded_modules[@]}" "${module}")
          source "${shared_install_location}/${module}.sh"
        else
          echo "!! import of module ${module} failed !!"
        fi
      else
        echo "!! you have to give a module !!"
      fi
    fi
  }
fi