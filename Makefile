.PHONY: all macOS homebrew homebrew-packages ruby-packages xcode alcatraz airport macOS-config

all: ruby-packages

macOS: all homebrew xcode alcatraz airport osx-config

homebrew:
	./Brewfile.sh

ruby-packages:
	sudo gem install bundle
	bundle install

xcode:
	xcversion install 6.4
	xcversion install 7.3

alcatraz:
	curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/master/Scripts/install.sh | sh

airport:
	sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

macOS-config:
	./.macOS-config
