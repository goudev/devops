#!/bin/bash

echo -n "Adicionando repositórios Helm "
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable > /tmp/helm.log 2>&1
if [ $? = 0 ]; then
    helm repo add jetstack https://charts.jetstack.io > /tmp/helm.log 2>&1
    if [ $? = 0 ]; then
        helm repo update > /dev/null 2>&1
        echo "[OK]"
    else
        echo "[ERRO]"
        echo
        echo "Falha ao adicionar o repositório (https://charts.jetstack.io) no Helm."
        echo
        cat /tmp/helm.log
        exit 2;    
    fi
else
    echo "[ERRO]"
    echo
    echo "Falha ao adicionar o repositório (https://releases.rancher.com/server-charts/stable) no Helm."
    echo
    cat /tmp/helm.log
    exit 2;
fi


echo -n "Criando namespace do Rancher "
kubectl get namespaces | grep -i "cattle-system" > /dev/null 2>&1
if [ $? = 0 ]; then
    echo "[Já Existe]"
else
    kubectl create namespace cattle-system > /tmp/rancher.log 2>&1
    if [ $? = 0 ]; then
        echo "[OK]"
    else
        echo "[ERRO]"
        echo
        echo "Falha ao criar o namespace do Rancher."
        echo
        cat /tmp/rancher.log
        exit 2;
    fi
fi


echo -n "Instalando Rancher "
helm install rancher rancher-${RANCHER_VERSION}/rancher --namespace cattle-system --set hostname=${RANCHER_DOMAIN} --set bootstrapPassword=${RANCHER_PASSWORD} --set ingress.tls.source=letsEncrypt --set letsEncrypt.email=${LETSENCRYPT_EMAIL} --set letsEncrypt.ingress.class=nginx > /tmp/rancherinstall.log 2>&1
if [ $? = 0 ]; then
    echo "[OK]"
    kubectl -n cattle-system rollout status deploy/rancher
else
    echo
    echo "[ERRO]"
    echo
    echo "Erro ao instalar o serviço do Rancher."
    echo
    cat /tmp/rancherinstall.log
    exit 2
fi
