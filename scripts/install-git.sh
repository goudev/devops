#!/bin/bash

export GITEA_SERVER_URL
export LETSENCRYPT_EMAIL

echo -n "Instalando serviço do Gitea"
envsubst < artefatos/gitea.yaml > /tmp/gitea.yaml
rm -f /tmp/gitea.yaml
kubectl apply -f /tmp/gitea.yaml > /tmp/giteainstall.log 2>&1
if [ $? = 0 ]; then
    echo "[OK]"
    kubectl -n git rollout status deploy/gitea
else
    echo "[ERRO]"
    echo
    echo "Erro ao instalar o serviço do Gitea"
    echo
    cat /tmp/giteainstall.log
fi