# install ingress-nginx
helm upgrade --cleanup-on-fail --install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace --set controller.image.digest="",controller.admissionWebhooks.patch.image.digest=""

# Install kubernetes-dashboard
helm upgrade --cleanup-on-fail --install kubernetes-dashboard ./kubernetes-dashboard -n kubernetes-dashboard --create-namespace --values ./kubernetes-dashboard-config.yaml
kubectl create -f dashboard.yaml
kubectl -n kubernetes-dashboard create token dashboard-admin --duration 0

helm upgrade --cleanup-on-fail --install ingress-nginx ./ingress-nginx-4.5.2.tgz --namespace ingress-nginx --create-namespace -f ingress-nginx-config.yaml

# install MINIO
kubectl create -f minio.yaml
helm upgrade --install minio-server .\minio\ --namespace minio --create-namespace --values .\minio-config.yaml

# Install spark-operator
helm upgrade --install spark-operator .\spark-operator\ --namespace spark --create-namespace --values .\spark-operator-config.yaml

# Install spark-history-server
helm upgrade --install spark-history-server .\spark-history-server\ --namespace spark --create-namespace --values .\spark-history-server-config.yaml

# Install Jupyter
kubectl create -f juypter.yaml
helm upgrade --install jupyterhub .\jupyterhub\ --namespace jupyter --create-namespace jupyter --values .\jupyterhub-config-1.2.0.yaml