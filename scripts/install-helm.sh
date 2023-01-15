#!/bin/bash

echo -n "Instalando Helm "
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash > /tmp/helm-install.log 2>&1
if [ $? = 0 ]; then
    echo "[OK]"
else
    echo "[ERRO]"
    echo
    echo "Falha na instalação do Helm."
    echo
    cat /tmp/helm-install.log
    exit 2;
fi
