for context in ${CLUSTER1} ${CLUSTER2}; do
  helm upgrade -i --kube-context=${context} gloo-operator \
    oci://us-docker.pkg.dev/solo-public/gloo-operator-helm/gloo-operator \
    --version 0.2.3 -n gloo-system --create-namespace \
    --set manager.env.SOLO_ISTIO_LICENSE_KEY=${GLOO_MESH_LICENSE_KEY} \
    --set manager.image.repository=us-docker.pkg.dev/solo-public/gloo-operator/gloo-operator &
done