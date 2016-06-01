#!/bin/bash

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "GO GO GO...\n"


# Setting computer/host name
echo 'Enter new hostname of the machine (e.g. macbook-merrick)'
read hostname
echo "Setting new hostname to $hostname..."
scutil --set HostName "$hostname"
compname=$(sudo scutil --get HostName | tr '-' '.')
echo "Setting computer name to $compname"
scutil --set ComputerName "$compname"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"


# SSH keys
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
[[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
[[ -f $pub ]] && cat $pub | pbcopy
open 'https://github.com/account/ssh'


# Xcode CLT
echo 'Installing Xcode-Command-Line-Tools'
xcode-select --install


# Gems
echo 'Installing gems'
sh Gemfile.sh


# Homebrew
echo 'Installing Homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Verifying Homebrew install'
brew doctor

echo 'Installing Homebrew components'
sh Brewfile.sh


# OS X Configuration
echo "Configuring OS X"
source ./.osx-config

# Dot files
echo "Copying Dotfiles"
cp -r ./dotfiles/. ~/

for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "Messages" "SystemUIServer" "Terminal" "TextEdit"
do
  killall "${app}" > /dev/null 2>&1
done
