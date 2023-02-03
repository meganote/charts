# Create namespace
cat <<EOF | kubectl apply -f -
kind: Namespace
apiVersion: v1
metadata:
  name: meganote
  labels:
    name: meganote
EOF

# install MINIO
kubectl create -f minio.yaml
helm upgrade --install minio .\minio\ --namespace meganote --values .\minio-config.yaml

# install spark-operator
helm upgrade --install spark-operator .\spark-operator\ --namespace meganote --values .\spark-operator-config.yaml