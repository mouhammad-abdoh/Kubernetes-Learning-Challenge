#!/bin/bash

CLUSTER_NAME="k8s-learning"

echo "🗑️ Deleting cluster '$CLUSTER_NAME'..."
kind delete cluster --name "$CLUSTER_NAME"

echo "✅ Cluster '$CLUSTER_NAME' deleted."
