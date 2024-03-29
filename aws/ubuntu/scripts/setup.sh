#!/bin/bash
set -x

echo ++ Updating ++
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive

echo "++ Installing Tidal Tools for ubuntu user"
su - ubuntu -c "curl https://get.tidal.sh/unix | bash"

echo ++ Installing Tidal Tools ++
curl https://get.tidal.sh/unix | bash

echo ++ Installing PIP ++
sudo apt-get install --yes python3-pip

echo ++ Updating PATH ++
export PATH=/home/ubuntu/.local/bin:$PATH

echo ++ Upgrading PIP ++
python3 -m pip install --upgrade pip

echo ++ Python Version?? ++
python3 --version

echo ++ Installing jq ++
sudo apt-get install --yes jq

echo ++ Installing Machine-Stats ++
python3 -m pip install machine-stats

echo ++ Installing Nmap ++
sudo apt-get install --yes  nmap

echo ++ Installing dns-tools ++
curl --output - https://d2ny8m13pxxvfx.cloudfront.net/dns-tools/dns-tools-linux-x86_64-0.8.10.tar.gz \
  | sudo tar xzvf - -C /usr/local/bin --strip-components=1 --exclude=install_dns_tools.sh
chmod a+w /usr/local/bin/lib/vendor/Gemfile.lock

echo ++ Installing Docker ++

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install the latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
docker --version

echo ++++ DONE ++++