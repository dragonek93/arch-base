#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc --utc
sed -i '177s/.//' /etc/locale.gen
sed -i '390s/.//' /etc/locale.gen
locale-gen
echo "LANG=pl_PL.UTF-8" >> /etc/locale.conf
echo "KEYMAP=pl" >> /etc/vconsole.conf
echo "FONT=Lat2-Terminus16.psfu.gz" >> /etc/vconsole.conf
echo "FONT_MAP=8859-2" >> /etc/vconsole.conf
echo "dragon-attacK" >> /etc/hostname
echo "127.0.0.1         localhost" >> /etc/hosts
echo "::1               localhost" >> /etc/hosts
echo "127.0.1.1         dragon-attacK.localdomain   dragon-attacK" >> /etc/hosts
echo root:password | chpasswd
useradd -m -g users -G wheel -s /bin/bash dragonek
echo dragonek:password | chpasswd
sed -i '82/.//' /etc/sudoers

#SERVICES
pacman -S base-devel linux-headers networkmanager openssh firewalld reflector tlp
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable firewalld
systemctl enable reflector.timer
systemctl enable tlp

#BOOTLOADER
pacman -S grub efibootmgr os-prober dosfstools intel-ucode
grub-install --target=x86_64-efi --bootloader-id=ARCH_LINUX --efi-directory=/boot/EFI --recheck
echo "GRUB_DISABLE_OS_PROBER" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
