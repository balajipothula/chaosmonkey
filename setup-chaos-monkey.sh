#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 06 February 2020,
# Description : Chaos Monkey Setup.

# updating package repo.
# upgrading packages.

<< COMMENT
# RedHat family.
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install git
COMMENT

# Debain family.
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git

# installing go lang.
curl -J -L https://dl.google.com/go/go1.13.7.linux-amd64.tar.gz -o $HOME/go.tar.gz && \
tar -xzf $HOME/go.tar.gz -C $HOME                                                  && \
rm  -rf  $HOME/go.tar.gz                                                           && \
mkdir    $HOME/chaosmonkey                                                         && \
export GOROOT=$HOME/go                                                             && \
export GOPATH=$HOME/chaosmonkey                                                    && \
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH                                          && \
echo "export GOROOT=$HOME/go"                    >> $HOME/.bash_profile            && \
echo "export GOPATH=$HOME/chaosmonkey"           >> $HOME/.bash_profile            && \
source $HOME/.bash_profile                                                         && \
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> $HOME/.bash_profile            && \
source $HOME/.bash_profile                                                         && \
echo "export GOROOT=$HOME/go"                    >> $HOME/.bashrc                  && \
echo "export GOPATH=$HOME/chaosmonkey"           >> $HOME/.bashrc                  && \
source $HOME/.bashrc                                                               && \
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> $HOME/.bashrc                  && \
source $HOME/.bashrc

exec bash

# installing chaos monkey.
go get github.com/netflix/chaosmonkey/cmd/chaosmonkey
