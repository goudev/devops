#!/bin/bash

# Versão do K3S a ser instalado
K3S_VERSION="v1.24.9+k3s2"
# Define a versão do Nginx Ingress
NGINX_INGRESS_RELEASE="release-3.0"
# Domínio do rancher no qual será utilizado para acessar
RANCHER_DOMAIN="rancher.mydomain.com"
# E-mail necessário para registro do certificado gerado automaticamente
RANCHER_EMAIL_CERTDOMAIN="my-email@domain.com"
# Senha para acesso ao rancher
RANCHER_PASSWORD="my-password"
# Versão a ser instalada do rancher
RANCHER_VERSION="stable"

source scripts/install-k3s.sh
source scripts/install-helm.sh
source scripts/install-cert-manager.sh
source scripts/install-nginx-ingress.sh
source scripts/install-rancher.sh