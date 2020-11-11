#!/bin/bash

wget https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl
chmod u+x kubectl && mv kubectl /bin/kubectl
