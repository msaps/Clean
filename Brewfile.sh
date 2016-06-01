#! /bin/bash
brew install caskroom/cask/brew-cask;

function install_brew() {
	brew install $1;
}

function install_cask() {
  echo 'Installing Cask ' + $1
	brew cask install $1;
}

# Components
install_brew git;

# Apps
install_cask charles;
install_cask google-chrome;
install_cask slack;
install_cask paw;
install_cask sourcetree;
install_cask github;
install_cask atom;
install_cask spotify;
install_cask p4merge;
install_cask macdown;
