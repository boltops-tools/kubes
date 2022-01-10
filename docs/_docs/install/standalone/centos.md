---
title: "Install: CentOS/RedHat/Fedora"
nav_text: CentOS
category: standalone
order: 2
---

This page shows you how to install kubes on CentOS, RedHat, Fedora and other Linux systems that use the yum-based package manager.

## CentOS/RedHat/Fedora

Configure repo

    sudo su
    curl -so /etc/yum.repos.d/boltops.repo https://yum.boltops.com/boltops.repo
    rpm --import https://yum.boltops.com/boltops-key.public

Install

    yum install -y kubes

Upgrade

    yum makecache
    yum update -y kubes

Uninstall

    yum remove -y kubes

{% include install/wrapper.md %}

## Fedora Notes

For Fedora, you may also need the libxcrypt-compat package.

    dnf install libxcrypt-compat -y

Or you'll get this error:

    $ kubes -h
    /opt/kubes/embedded/bin/ruby: error while loading shared libraries: libcrypt.so.1: cannot open shared object file: No such file or directory
    $

Fedora is a bleeding edge distro and is quicker about upgrading their system. The `libcrypt.so` has been removed. The libxcrypt-compat package installs it back.

## Amazon Linux 2 Notes

The standalone installer does not support Amazon Linux 1.  Please use Amazon Linux 2 instead.

## Rpm Install

You can also download the rpm package and install it directly. Here are the commands:

    wget https://yum.boltops.com/packages/kubes/kubes-latest.rpm
    sudo su
    rpm -ivh kubes-latest.rpm
    kubes -h

To upgrade an existing install also use the `-U` flag.

    rpm -Uivh kubes-latest.rpm

You can check [kubes-latest.rpm.metadata.json](https://yum.boltops.com/packages/kubes/kubes-latest.rpm.metadata.json) to verify the package checksum. Here's the checksum command.

    sha256sum kubes-latest.rpm

To uninstall

    rpm -e kubes-latest.rpm
