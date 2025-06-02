for context in ${CLUSTER1} ${CLUSTER2}; do
  kubectl --context=${context} label ns bookinfo istio.io/use-waypoint=auto
  kubectl --context=${context} apply -f ./reviews-v1.yaml 
done