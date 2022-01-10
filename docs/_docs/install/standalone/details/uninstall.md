---
title: "Uninstall Cleanup"
nav_text: Uninstall
category: standalone-details
order: 4
---

Some packager managers will not clean up the installed files completely. The apt-get and yum package manager generally cleans up everything. Homebrew doesn't seem to clean up currently though.

To fully clean up and uninstall kubes. First, run the package manger uninstall command and then clean up with:

    rm -rf /opt/kubes

Then remove the kubes wrappers in `/usr/local/bin`. You can remove them with this command:

    grep -l /opt/kubes /usr/local/bin/* | xargs rm -f
