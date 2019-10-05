#!/usr/bin/env bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Setting git config..."
git config --global user.name "João Chapa"
git config --global user.email "reischapa@gmail.com"

echo "Installing packages..."
sudo pacman -S \
  git \
  autojump \
  nodejs \
  npm \
  openssh \
  links \
  modemmanager \
  thunar \
  kdiff3 \
  blueman \
  xorg-server \
  xorg-xinput \
  xorg-xinit \
  xorg-xbacklight \
  xorg-xev \
  xf86-video-intel \
  xf86-video-vesa \
  xf86-input-keyboard \
  pulseaudio \
  pulsemixer \
  gparted \
  lxterminal \
  htop \
  fzf \
  ufw \
  jdk-openjdk

echo "enabling ufw..."
sudo ufw enable

echo "jq"
yay jq

echo "feh" 
yay feh

echo "i3"
yay i3-wm

echo "rofi" 
yay rofi

echo "polybar"
yay polybar

echo "compton" 
yay compton

echo "redshift" 
yay redshift

echo "vim (gvim)" 
yay gvim

echo "fonts" 
yay ttf-ms-fonts
yay ttf-liberation
yay ttf-symbola
yay noto-fonts-sc
yay noto-fonts-tc
yay otf-ipafont
yay ttf-iosevka
yay ephifonts

echo "firefox"
yay firefox-nightly

echo "tlp" 
yay tlp

echo "xscreensaver"
yay xscreensaver

echo "intellij"
yay intellij-idea-ultimate-edition

sudo npm install --global n

n 10

npm install --global nodemon
npm install --global http-server
npm install --global lerna
