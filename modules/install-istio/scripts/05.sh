for context in ${CLUSTER1} ${CLUSTER2}; do
  kubectl --context ${context} label namespace bookinfo istio.io/dataplane-mode=ambient
done