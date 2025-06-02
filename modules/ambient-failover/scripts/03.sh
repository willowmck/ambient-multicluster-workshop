kubectl --context $CLUSTER1 -n bookinfo label service details solo.io/service-scope=global-only 
kubectl --context $CLUSTER2  -n bookinfo label service details solo.io/service-scope=global-only 