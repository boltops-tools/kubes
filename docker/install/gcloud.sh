#!/bin/bash -eu

[ -e /opt/google ] && exit

mkdir -p /opt/google

cd /opt/google
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-318.0.0-linux-x86_64.tar.gz
tar zxf google-cloud-sdk*.tar.gz
rm -f google-cloud-sdk*.tar.gz

/opt/google/google-cloud-sdk/install.sh -q

cat << FOE >> ~/.bash_profile

source /opt/google/google-cloud-sdk/completion.bash.inc
source /opt/google/google-cloud-sdk/path.bash.inc
FOE
