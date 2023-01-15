#!/bin/bash

echo -n "Instalando o Nginx Ingress "
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/ns-and-sa.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/rbac/rbac.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/default-server-secret.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/nginx-config.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/ingress-class.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/crds/k8s.nginx.org_virtualservers.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/crds/k8s.nginx.org_virtualserverroutes.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/crds/k8s.nginx.org_transportservers.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/crds/k8s.nginx.org_policies.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/common/crds/k8s.nginx.org_globalconfigurations.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/deployment/nginx-ingress.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/${NGINX_INGRESS_RELEASE}/deployments/daemon-set/nginx-ingress.yaml > /dev/null 2>&1
echo "[OK]"
