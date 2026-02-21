#!/usr/bin/env bash
set -e

kubectl create namespace argocd || true

# --server-side moves the field management to the server, so the large CRD manifest is never stored in the annotation. Needed for large manifests
kubectl apply -n argocd --server-side \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD..."
kubectl wait --for=condition=available deployment/argocd-server \
  -n argocd --timeout=300s
