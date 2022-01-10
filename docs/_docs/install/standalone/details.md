---
title: "Standalone Details"
nav_text: Details
category: standalone
order: 9
---

The standalone installer packages are built within a few minutes of the kubes gem release. This page covers more details on how the standalone installation works.

## Isolated: /opt/kubes

The standalone kubes package installs kubes in `/opt/kubes`. This folder contains everything like system libraries, Ruby, and gems needed for kubes to work as a standalone package. Additionally, this also makes it easy to remove kubes.

## Wrapper: /usr/local/bin

The installer creates a wrapper script in `/usr/local/bin`.

    /usr/local/bin/kubes

Most users have `/usr/local/bin` configured in there PATH. So this wrapper should work.
