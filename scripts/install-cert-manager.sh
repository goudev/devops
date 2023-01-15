#!/bin/bash

echo -n "Instalando o cert-manager "
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml > /tmp/certmanager.log 2>&1
if [ $? = 0 ]; then
    helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.7.1 >> /tmp/certmanager.log 2>&1
    if [ $? = 0 ]; then
        time=1
        while true; do
            kubectl -n cert-manager rollout status deploy/cert-manager > /dev/null 2>&1
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
                    echo "Ocorreu timeout na instalação do cert-manager."
                    echo
                    exit 2
                fi
                sleep 1
            fi
        done
    else
        echo "[ERRO]"
        echo
        echo "Falha na instalação do cert-manager."
        echo
        cat /tmp/certmanager.log    
    fi
else
    echo "[ERRO]"
    echo
    echo "Falha ao criar os CRDs do cert-manager."
    echo
    cat /tmp/certmanager.log
    exit 2;
fi
