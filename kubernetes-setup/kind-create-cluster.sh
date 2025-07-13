#!/bin/bash

CLUSTER_NAME="k8s-learning"

echo "🔧 Creating Kubernetes cluster with kind..."
kind create cluster --name "$CLUSTER_NAME" --config kind-cluster-config.yaml

echo "✅ Cluster '$CLUSTER_NAME' created!"
kubectl cluster-info
