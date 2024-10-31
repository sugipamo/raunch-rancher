kubectl delete namespace cattle-system
sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml kubectl create namespace cattle-system
sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rancher.local --set bootstrapPassword=admin

kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'

