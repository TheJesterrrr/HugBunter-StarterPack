#!/bin/bash 

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y golang

go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc

