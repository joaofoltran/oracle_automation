#!/bin/bash

############################################################
# Creator: João Vítor Foltran
# Functions for ORACLE user to set environment variables.
############################################################

DEFAULT(){
  export USER_BIN=/home/${USER}/bin
  export ORACLE_BASE="/u01/app/oracle"
  export PATH=${PATH}:${ORACLE_HOME}/bin:${ORACLE_HOME}/OPatch:${USER_BIN}
}

INSTANCE1() {
  export ORACLE_HOME="ORACLE_HOME FOR INSTANCE1"
  export ORACLE_SID=INSTANCE1
  DEFAULT
}

INSTANCE2() {
  export ORACLE_HOME="ORACLE_HOME FOR INSTANCE2"
  export ORACLE_SID=INSTANCE2
  DEFAULT
}

menu() {
    while true; do
        clear
        echo "============================================"
        echo ""
        echo " Oracle variables settings"
        echo ""
        echo " 1) INSTANCE1 - Homolog Database"
        echo " 2) INSTANCE2 - Production Database"
        echo ""
        echo "============================================"
        read -p " Choose: " ANSWER
        echo "============================================"

        case ${ANSWER} in
            1) INSTANCE1; break                   ;;
            2) INSTANCE2; break                   ;;
            *) echo "Option not found." | exit 1 ;;
        esac
    done
}

