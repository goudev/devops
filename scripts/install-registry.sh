#!/bin/bash

export GITEA_SERVER_URL
export LETSENCRYPT_EMAIL
export DRONE_ADMIN
export DRONE_GIT_PASSWORD
export DRONE_GIT_USERNAME
export DRONE_RPC_SECRET
export DRONE_SERVER_HOST
export DRONE_SERVER_PROTO
export DRONE_USER_CREATE
export REGISTRY_URL

echo -n "Instalando serviço de Registry"
envsubst < artefatos/registry.yaml > /tmp/registry.yaml
delete -f /tmp/registry.yaml
kubectl apply -f /tmp/registry.yaml > /tmp/droneinstall.log 2>&1
if [ $? = 0 ]; then
    echo "[OK]"
    kubectl -n registry rollout status deploy/registry
else
    echo "[ERRO]"
    echo
    echo "Erro ao instalar o serviço do registry"
    echo
    cat /tmp/droneinstall.log
fi