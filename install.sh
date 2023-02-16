# install MINIO
kubectl create -f minio.yaml
helm upgrade --install minio-server .\minio\ --namespace minio --create-namespace --values .\minio-config.yaml

# Install spark-operator
helm upgrade --install spark-operator .\spark-operator\ --namespace spark --create-namespace --values .\spark-operator-config.yaml

# Install spark-history-server
helm upgrade --install spark-history-server .\spark-history-server\ --namespace spark --create-namespace --values .\spark-history-server-config.yaml