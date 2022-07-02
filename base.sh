#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/#fr_FR.UTF-8/fr_FR.UTF-8/' /etc/locale.gen
locale-gen
