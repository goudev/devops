#!/bin/bash

. .env

if [ ! $? = 0 ]; then
    echo "Verifique o arquivo de variaveis de ambiente. Não foi possível carregalo."
    exit 2;
fi

source scripts/install-k3s.sh
source scripts/install-helm.sh
source scripts/install-cert-manager.sh
source scripts/install-nginx-ingress.sh
source scripts/install-rancher.sh
source scripts/install-git.sh
source scripts/install-drone.sh
source scripts/install-registry.sh