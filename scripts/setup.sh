#!/bin/bash

set -e

mkdir -p /etc/sudoers.d
echo 'vagrant ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
