#!/usr/bin/env bash

set -e;

echo CURRENT_DIR=`pwd`;

cd ~

echo "Installing packages..."
sudo pacman --noconfirm -S \
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

# vim and gvim are in conflict
pacman -R --noconfirm vim
pacman --noconfirm gvim

if [ -z `command -v yay` ]; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi

cd;

function yeet() {
  yay -Sy --noconfirm --answerclean 'N' --answerdiff 'N' --answeredit 'N' "$@"
}

yeet jq
yeet feh
yeet i3-wm
yeet rofi
yeet polybar
yeet compton
yeet redshift
yeet ttf-ms-fonts
yeet ttf-liberation
yeet ttf-symbola
yeet noto-fonts-sc
yeet noto-fonts-tc
yeet otf-ipafont
yeet ttf-iosevka
yeet ephifonts
yeet tlp
yeet xscreensaver

if [ ! -z `command -v n` ]; then
  echo 'Setting up node/npm/n...'
  sudo npm install --global n

  n 10

  npm install --global nodemon
  npm install --global http-server
  npm install --global lerna
fi

echo 'Cloning dot-files repo'

cd ~

rm .bashrc;
rm .bash_logout;

eval $(ssh-agent) && ssh-add

git init
git remote add origin https://github.com/reischapa/dot-files.git
git pull origin master
git submodule update --init --recursive

echo "Setting git config..."
touch .gitignore_global

git config --global core.excludesfile ~/.gitignore_global
git config --global user.name "João Chapa"
git config --global user.email "reischapa@gmail.com"

echo "Enabling ufw..."
sudo ufw enable

if [ ! -f /etc/systemd/system/lock-on-suspend.service ]; then
  echo "Installing lock on suspend service..."

  cd "$CURRENT_DIR"
  
  sudo cp -v lock-on-suspend.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable lock-on-suspend.service
  sudo systemctl start lock-on-suspend.service

  cd ~
fi

echo "Enabling suspend on lid down..."
if [ -z `cat /etc/systemd/logind.conf | grep -e '^HandleLidSwitch=suspend'` ]; then
  sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=suspend/g' /etc/systemd/logind.conf
fi

