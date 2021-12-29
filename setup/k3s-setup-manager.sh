#!/bin/bash
echo 'update and upgrade server'
sudo apt update -y
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -o Dpkg::Options::="--force-confold" -o Dpkg::Options::="--force-confdef" dist-upgrade -q -y --allow-downgrades --allow-remove-essential --allow-change-held-packages

echo 'install k3s distribution'
sudo curl -sfL https://get.k3s.io | sh -s  -s - --disable=traefik

