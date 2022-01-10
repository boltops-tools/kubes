---
title: "Install: Ubuntu/Debian"
nav_text: Ubuntu
category: standalone
order: 3
---

This page shows you how to install kubes on Ubuntu and Debian based linux systems that use the apt package manager.

## Ubuntu/Debian: apt-get install

Configure repo

    sudo su
    echo "deb https://apt.boltops.com stable main" > /etc/apt/sources.list.d/boltops.list
    curl -s https://apt.boltops.com/boltops-key.public | apt-key add -

Install

    apt-get update
    apt-get install -y kubes

Upgrade

    apt-get install -y kubes

Remove

    apt-get remove -y kubes

{% include install/wrapper.md %}

## Deb Install

You can also download the deb package and install it directly. Here are the commands:

Install

    wget https://apt.boltops.com/packages/kubes/kubes-latest.deb
    dpkg -i kubes-latest.deb

You can check [kubes-latest.deb.metadata.json](https://apt.boltops.com/packages/kubes/kubes-latest.deb.metadata.json) to verify the package checksum. Here's the checksum command.

    sha256sum kubes-latest.deb

Uninstall

    dpkg -r kubes-latest.deb
