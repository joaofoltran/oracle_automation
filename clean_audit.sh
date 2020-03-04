#!/bin/bash
##################################
# Criador..: Joao Vitor Foltran  #
# Data.....: 17/02/2020          #
# Empresa..: Eiti Solucoes       #
##################################

if [ ! -x "${HOME}/.configs/oracle/variables.sh" ]; then
  echo "Arquivo de funcoes nao encontrado."
  exit 1
fi

. ${HOME}/.configs/oracle/variables.sh

RET="$1"
INSTANCES=($2)
INSTANCES=( $(echo "${INSTANCES}" | sed 's/,/ /g') )

# Limpa para cada instancia informada
for (( i=0; i<${#INSTANCES}; i++ )); do
  INSTANCE="${INSTANCES[$i]}"
  # Finaliza se vazio
  test -v ${INSTANCE} && break
  # Verifica se existe funcao de variaveis
  if [ "$(type -t ${INSTANCE} | wc -l)" -eq "0" ]; then
    echo "${INSTANCE}: Funcao para configurar variaveis nao encontrada."
    exit 2
  fi
  # Chama funcao para configurar variaveis
  ${INSTANCE}
  # Limpeza dos arquivos de audit
  find ${ORACLE_HOME}/rdbms/audit -name "*.aud" -type f -mmin +(($RET*1440)) -exec rm -f {} \;
done
