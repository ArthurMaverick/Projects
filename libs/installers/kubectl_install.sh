#!/usr/bin

chmod +x

echo "Download the latest release with the command: \n"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


echo "Validate the binary"
echo "Download the kubectl checksum file: "
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "Validate the kubectl binary against the checksum file:"
CHECK = echo "$(<kubectl.sha256) kubectl" | sha256sum --check

if CHECK == "kubectl: OK" {
  echo "Install kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
} else {
    echo "invalid kubectl binary"
}
