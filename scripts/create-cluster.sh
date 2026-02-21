#!/usr/bin/env bash
set -e

echo "Creating k3d cluster..."
k3d cluster create --config k3d/cluster-config.yaml
