############################################################################
############################################################################
#
# Containers to Kubernetes - Andrew Pruski
# @dbafromthecold.com
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/containers2kubernetes
# Deploying Applications
#
############################################################################
############################################################################



# navigate to script location
cd /mnt/c/git/containers2kubernetes/k8s_demos/yaml



# view secret yaml
cat secret.yaml



# create secret
kubectl apply -f secret.yaml



# view secret
kubectl get secrets



# describe secret
kubectl describe secret mssql-sa-password



# try and get more info on secret
kubectl get secret mssql-sa-password -o yaml



# decode secret
kubectl get secret mssql-sa-password -o jsonpath='{ .data.MSSQL_SA_PASSWORD }' | base64 --decode && echo ""



# view daemonset yaml
cat daemonset.yaml && echo ""



# deploy daemonset
kubectl apply -f daemonset.yaml



# confirm daemonset
kubectl get daemonset



# view more information on daemonset
kubectl describe daemonset mssql



# view pods in daemonset
kubectl get pods -o wide



# delete daemonset
kubectl delete daemonset mssql-daemonset



# view deployment yaml
cat deployment.yaml && echo ""



# deploy deployment
kubectl apply -f deployment.yaml



# confirm deployment
kubectl get deployment



# view more information on deployment
kubectl describe deployment mssql



# view replicaset events
kubectl describe replicaset mssql



# view pods in deployment
kubectl get pods -o wide



# delete deployment
kubectl delete deployment mssql-deployment



# view statefulset yaml
cat statefulset.yaml && echo ""



# deploy statefulset
kubectl apply -f statefulset.yaml



# confirm statefulset
kubectl get statefulset mssql-statefulset



# view more information on statefulset
kubectl describe statefulset mssql-statefulset



# view pods in statefulset
kubectl get pods -o wide



# delete statefulset
kubectl delete statefulset mssql-statefulset


