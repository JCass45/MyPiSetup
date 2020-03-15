#!/bin/sh

mkdir -p /home/jack/.ssh
# Add my public key to authorized_keys
ssh-add -L > /home/jack/.ssh/authorized_keys

sed -i "s/^PasswordAuthentication yes$/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i "s/^PermitRootLogin prohibit-password$/PermitRootLogin no/" /etc/ssh/sshd_config

sudo service ssh restart
