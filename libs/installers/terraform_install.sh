#!/usr/bin 

chmod +x

echo "Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed. "
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

echo "Add the HashiCorp GPG key."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

echo "Add the official HashiCorp Linux repository."
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "Update to add the repository, and install the Terraform CLI."
sudo apt-get update && sudo apt-get install terraform
