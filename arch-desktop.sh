#!/bin/bash
#SERVICES
timedatectl set-timezone Europe/Warsaw
localectl set-locale LANG=pl_PL.UTF-8
hostnamectl set-hostname dragon-attacK
hwclock --systohc

#XORG AUDIO
reflector -c 'United States' -a 3 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy
pacman -S xorg xorg-xinit xorg-server pulseaudio pulseaudio-alsa

#DRIVERS
pacman -S xf86-video-intel
# pacman -S nvidia nvidia-utils nvidia-settings cuda
# pacman -S xf86-video-amdgpu

#FONTS
pacman -S ttf-dejavu gnu-free-fonts terminus-font ttf-ubuntu-font-family