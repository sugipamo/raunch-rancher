mkdir longhorn
mkdir rancher

docker run -d --name rancher \
  --privileged \
  -p 80:80 \
  -p 443:443 \
  --restart=unless-stopped \
  -v ./rancher:/var/lib/rancher \
  -v ./longhorn:/var/lib/longhorn \
  rancher/rancher:latest
