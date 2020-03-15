#!/bin/sh

if [ -z $(ls /home | grep jack) ]; then
    useradd jack -m --user-group
fi

usermod --groups sudo,docker --password $(openssl passwd -1 password) --shell /bin/bash jack

if [ -z $(ls /home | grep vagrant) ]; then
    usermod --expiredate 1 vagrant
fi
