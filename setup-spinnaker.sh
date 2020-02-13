#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 06 February 2020,
# Description : Spinnaker Setup.

# updating package repo.
# upgrading packages.

<< COMMENT
# RedHat family.
sudo yum -y update
sudo yum -y upgrade
COMMENT

# Debain family.s
sudo apt -y update
sudo apt -y upgrade

# stable.
# https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh

# debian.
# https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh

# installing halyard.
curl -J -L https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh -o $HOME/install-halyard.sh && \
chmod +x  $HOME/install-halyard.sh                                                                                                 && \
sudo bash $HOME/install-halyard.sh                                                                                                 && \
rm  -rf   $HOME/install-halyard.sh

# configuring halyard version.
hal config version edit --version 1.17.6

# configuring spinnaker storage .

# enabling s3 storage.
hal config artifact s3 enable

# configuring s3 storage access.
hal config storage s3 edit --access-key-id AKIAIJVKSQHI7YZQYVYA --secret-access-key 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 --region ap-south-1

# enabling s3 storage.
hal config storage edit --type s3

# configuring aws account.
hal config provider aws account add Prod --account-id 576448550026 --assume-role SpinnakerAmazonEC2FullAccess

# enabling aws provider.
hal config provider aws enable

# apache2 ports config file.
# sudo vi /etc/apache2/ports.conf

# changing hal folder owner.
sudo chown -R ubuntu:ubuntu $HOME/.hal

hal config security ui  edit --override-base-url http://18.191.233.147:9000
hal config security api edit --override-base-url http://18.191.233.147:8084

# enabling chaos monkey.
hal config features edit --chaos true

# applying hal configurations.
# installing spinnaker.
sudo hal deploy apply
sudo systemctl daemon-reload

# 
echo "host: 0.0.0.0" > $HOME/.hal/default/service-settings/gate.yml && \
echo "host: 0.0.0.0" > $HOME/.hal/default/service-settings/deck.yml

# connecting to hal dek.
sudo hal deploy connect
