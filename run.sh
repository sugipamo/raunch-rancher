#!/bin/bash

# スクリプトを実行するユーザーがroot権限を持っていることを確認
if [[ $EUID -ne 0 ]]; then
   echo "このスクリプトはrootユーザーまたはsudo権限で実行する必要があります。"
   exit 1
fi

# ステップ1: Ubuntuを最新の状態に更新する
echo "Ubuntuを最新の状態に更新しています..."
apt update && apt upgrade -y

# ステップ2: 必要なパッケージをインストールする
echo "curlをインストールしています..."
apt install -y curl

# ステップ3: K3sをインストールする
echo "K3sをインストールしています..."
curl -sL https://get.k3s.io | sh -

# ステップ4: K3sのステータスを確認する
echo "K3sのインストールが完了しました。ステータスを確認しています..."
systemctl status k3s

# ステップ5: kubectlの設定
echo "kubectlの設定を行っています..."
mkdir -p $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
chown $(whoami):$(whoami) $HOME/.kube/config
chmod 600 $HOME/.kube/config

# ステップ6: 環境変数を設定する
echo "環境変数を設定しています..."
echo "export KUBECONFIG=$HOME/.kube/config" >> $HOME/.bashrc
source $HOME/.bashrc

# ステップ7: 動作確認
echo "kubectlの動作確認を行います..."
kubectl get nodes

echo "すべての操作が完了しました！"
