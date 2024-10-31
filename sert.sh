#!/bin/bash

# 環境設定
# k3sのインストール
curl -sfL https://get.k3s.io | sh -

chown $USER /etc/rancher/k3s/k3s.yaml
chmod 600 /etc/rancher/k3s/k3s.yaml
sudo chown $USER /etc/rancher/k3s/k3s.yaml
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# k3sのサービス確認
k3s kubectl get nodes

# KUBECONFIGの設定
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Helmの設定
# Helmのインストール
snap install helm --classic

# Helmリポジトリの追加
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# Helmリポジトリの更新
helm repo update

kubectl delete namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.1/cert-manager.yaml

# ノードとポッドの確認
kubectl get nodes
kubectl get pods --namespace cert-manager

