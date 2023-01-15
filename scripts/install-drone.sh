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

echo -n "Instalando serviço do Drone"
envsubst < artefatos/drone.yaml > /tmp/drone.yaml
kubectl apply -f /tmp/drone.yaml > /tmp/droneinstall.log 2>&1
rm -f /tmp/drone.yaml
if [ $? = 0 ]; then
    echo "[OK]"
    kubectl -n cicd rollout status deploy/drone
else
    echo "[ERRO]"
    echo
    echo "Erro ao instalar o serviço do Drone"
    echo
    cat /tmp/droneinstall.log
fi