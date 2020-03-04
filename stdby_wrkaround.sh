#!/bin/bash

. /home/oracle/.configs/oracle/variables.sh

INSTANCE=$1
INSTANCE="$(echo ${INSTANCE} | tr :[lower]: :[upper]:)"

if [ $2 -eq " " ]; then
  ARCHIVE_DIR="/backup/${INSTANCE}/migracao/archive"
else
  ARCHIVE_DIR="$2"
fi

if [ $(type -t ${INSTANCE} | wc -l) -eq 0 ]; then
  echo "Funcao nao encontrada."
  exit 1
fi

${INSTANCE}

echo "##############################"
echo "########### INICIO ###########"
echo "##############################"

sqlplus /nolog << EOF
  connect / as sysdba
  startup nomount
  alter database mount standby database;
  select max(recid) from v\$log_history;
  alter database recover automatic from '${ARCHIVE_DIR}' standby database;
  ALTER DATABASE RECOVER CANCEL;
  prompt
  prompt
  select max(recid) from v\$log_history;
  shutdown immediate;
  exit;
EOF

echo "##############################"
echo "############# FIM ############"
echo "##############################"
