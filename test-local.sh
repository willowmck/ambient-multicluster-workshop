#!/bin/bash

if [ -z "$GLOO_MESH_LICENSE_KEY" ]; then
  echo "GLOO_MESH_LICENSE_KEY is not set. Please set it before running the script."
  exit 1
fi

if [ -z "$CLUSTER1" ]; then
  echo "Creating local cluster1 using Colima..."
  colima start --profile cluster1 --cpu 6 --memory 8 --kubernetes
  export CLUSTER1=cluster1
fi

if [ -z "$CLUSTER2" ]; then
  echo "Creating local cluster2 using Colima..."
  colima start --profile cluster2 --cpu 4 --memory 8 --kubernetes
  export CLUSTER2=cluster2
fi

steps=("env-prep" "install-istio" "deploy-bookinfo")

CWD=$(pwd)

for step in $steps; do
    echo "Running tests in step: $step"
    cd $CWD/steps/$step
    chainsaw test
    cd $CWD
done

echo "Tests completed."