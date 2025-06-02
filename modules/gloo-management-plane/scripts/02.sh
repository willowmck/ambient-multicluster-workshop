helm repo add gloo-platform https://storage.googleapis.com/gloo-platform/helm-charts
helm repo update

helm upgrade -i gloo-platform-crds gloo-platform/gloo-platform-crds -n gloo-mesh --create-namespace --version=2.8.0 --kube-context=$CLUSTER1
helm upgrade -i gloo-platform gloo-platform/gloo-platform -n gloo-mesh --version 2.8.0 --kube-context=$CLUSTER1 --values mgmt-values.yaml \
  --set licensing.glooMeshLicenseKey=$GLOO_MESH_LICENSE_KEY