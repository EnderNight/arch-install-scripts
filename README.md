# Arch Linux Installation Scripts
Personal arch installation scripts, not made to be portable.

## Name scheme
Scripts' names follow this scheme :
> [de].sh

Where [de] stands for Desktop Environement.

Name schemes are used to tell what [de] is going to be installed
using a [de].sh script.

The exception is the script base.sh which is required by all other scripts. This script does not install the base [de] but install a basic arch linux system. Another exception is the script de.sh which install a basic desktop-ready arch linux system (the base.sh is required).

## Usage
These scripts are made to be launched while installing archlinux.
The prefered way is to launch them after being chrooted into your system.
