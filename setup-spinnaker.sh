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

# Debain family
sudo apt -y update
sudo apt -y upgrade

# stable.
# https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh

# debian.
# https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh

# installing halyard.
curl -J -L https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh -o $HOME/install-halyard.sh && \
chmod +x  $HOME/install-halyard.sh                                                                                                 && \
sudo bash $HOME/install-halyard.sh                                                                                                 && \
rm  -rf   $HOME/install-halyard.sh

# changing hal folder owner.
sudo chown -R ubuntu:ubuntu $HOME/.hal

# configuring halyard version.
hal config version edit --version 1.17.6 --debug

# configuring spinnaker storage .

# enabling s3 storage.
hal config artifact s3 enable --debug

# configuring s3 storage access.
hal config storage s3 edit --access-key-id Your_Access_Key_Id --secret-access-key Your_Secret_Access_Key --region ap-south-1 --debug

# enabling s3 storage.
hal config storage edit --type s3 --debug

# configuring aws account.
hal config provider aws account add Prod --account-id Your_Account_Id --assume-role SpinnakerAmazonEC2FullAccess --debug

# enabling aws provider.
hal config provider aws enable --debug

# enabling chaos monkey.
hal config features edit --chaos true --debug

# 
hal config security ui  edit --override-base-url http://15.206.171.58:9000 --debug
hal config security api edit --override-base-url http://15.206.171.58:8084 --debug

# applying hal configurations.
# installing spinnaker.
sudo hal deploy apply --debug
sudo systemctl daemon-reload

# 
echo "host: 0.0.0.0" > $HOME/.hal/default/service-settings/gate.yml && \
echo "host: 0.0.0.0" > $HOME/.hal/default/service-settings/deck.yml

# connecting to hal dek.
sudo hal deploy connect
