docker pull registry.aliyuncs.com/google_containers/nginx-ingress-controller:v1.8.1@sha256:e5c4824e7375fcf2a393e1c03c293b69759af37a9ca6abdb91b13d78a93da8bd
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v20230407@sha256:543c40fd093964bc9ab509d3e791f9989963021f1e9e4c9c7b6700b02bfb227b

# Install ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --cleanup-on-fail --install --debug ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace --values .\nginx-ingress.yaml


helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/


# install MINIO
kubectl create -f minio.yaml
helm upgrade --install minio-server .\minio\ --namespace minio --create-namespace --values .\minio-config.yaml

# Install spark-operator
helm upgrade --install spark-operator .\spark-operator\ --namespace spark --create-namespace --values .\spark-operator-config.yaml

# Install spark-history-server
helm upgrade --install spark-history-server .\spark-history-server\ --namespace spark --create-namespace --values .\spark-history-server-config.yaml