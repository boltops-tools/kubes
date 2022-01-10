---
title: "Install: Mac OSX"
nav_text: MacOSX
category: standalone
order: 1
---

This page shows you how to install kubes on Mac OSX.

Here's a "Mac OSX Homebrew Install" Video:

## Homebrew

You can install kubes via homebrew.

Install

    brew tap boltops-tools/software
    brew install kubes

Upgrade

    brew update
    brew install kubes

Uninstall

    brew uninstall kubes

Cleanup

    rm -rf /opt/kubes
    grep -l /opt/kubes /usr/local/bin/* | xargs rm -f

{% include install/wrapper.md %}

## DMG

You can also download the dmg and install with the Mac OSX GUI installer.

Download link: [kubes DMG](https://tap.boltops.com/packages/kubes/kubes-latest.dmg)

You can check [kubes-latest.dmg.metadata.json](https://tap.boltops.com/packages/kubes/kubes-latest.dmg.metadata.json) to verify the package checksum. Here's the checksum command.

    shasum -a 256 kubes-latest.dmg
