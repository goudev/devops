#!/bin/bash

echo -n "Instalando o K3S "
curl -sfL https://get.k3s.io |  INSTALL_K3S_VERSION=${K3S_VERSION} INSTALL_K3S_EXEC="--disable traefik" sh -s - server > /tmp/k3sinstall 2>&1
if [ ! $? = 0 ]; then
    echo "[ERROR]"
    echo
    echo "Falha na instalação do K3S. Analise os logs em (/tmp/k3sinstall) para maiores informações."
    exit 2;
else
    echo "[OK]"
fi
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
echo -n "Inicializando o Cluster "
time=1
while true; do
    kubectl get nodes | grep -i "control-plane" | grep -i "Ready" > /dev/null 2>&1
    if [ $? = 0 ]; then
        echo "[OK]"
        break;
    else
        if [ $time -lt 60 ]; then
            time=$(($time+1))
            echo -n "."
        else
            echo -n "[TIME-OUT]"
            echo
            echo "Ocorreu timeout na inicialização do cluster."
            echo
            exit 2
        fi
        sleep 1
    fi
done
