#!/bin/bash

if [ -z "$GLOO_MESH_LICENSE_KEY" ]; then
  echo "GLOO_MESH_LICENSE_KEY is not set. Please set it before running the script."
  exit 1
fi

if [ -z "$CLUSTER1" ]; then
  echo "Creating local cluster1 using Colima..."
  colima start --profile cluster1 --cpu 6 --memory 8 --kubernetes
  export CLUSTER1=colima-cluster1
fi

if [ -z "$CLUSTER2" ]; then
  echo "Creating local cluster2 using Colima..."
  colima start --profile cluster2 --cpu 4 --memory 8 --kubernetes
  export CLUSTER2=colima-cluster2
fi

modules=('env-prep' 'deploy-bookinfo' 'install-istio' 'expose-productpage')

CWD=$(pwd)

# Set PATH for istioctl
PATH=${HOME}/.istioctl/bin:$PATH

for module in ${modules[@]}; do
    echo "Running scripts in module: $module"
    cd $CWD/modules/$module/scripts
    for script in `ls *.sh`; do
        echo "Running script: $script"
        eval bash ./$script
    done
    echo "Running chainsaw test for module: $module"
    chainsaw test
    cd $CWD
done

echo "Tests completed."