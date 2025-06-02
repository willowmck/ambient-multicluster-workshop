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

modules=("env-prep" "install-istio" "deploy-bookinfo")

CWD=$(pwd)

for module in $modules; do
    echo "Running tests in module: $module"
    cd $CWD/modules/$module
    chainsaw test
    cd $CWD
done

echo "Tests completed."