#!/bin/bash

## Format partitions
## p1 -> EFI Boot Partition
## p2 -> Root Partition
## p3 -> Home Partition

mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

## Mount partitions

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
mount --mkdir /dev/nvme0n1p3 /mnt/home

## Sort Mirrors

reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

## Pacstrap System

pacstrap -K /mnt base base-devel linux linux-firmware linux-headers nano git amd-ucode networkmanager man-db man-pages firefox steam grub efibootmgr os-prober plasma kde-applications mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau wine-staging ttf-jetbrains-mono-nerd noto-fonts-emoji neofetch feh zenpower3 easyeffects amdgpu_top corectrl lsp-plugins openrazer-driver-dkms mkinitcpio pipewire lib32-pipewire pipewire-docs wireplumber qpwgraph pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack java-21-openjdk

genfstab -U /mnt >> /mnt/etc/fstab

echo "Time to arch-chroot /mnt"
