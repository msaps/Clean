.PHONY: all osx homebrew homebrew-packages ruby-packages xcode alcatraz airport osx-config swift

all: ruby-packages

osx: all homebrew swift alcatraz airport osx-config

homebrew:
	./Brewfile.sh

ruby-packages:
	sudo gem install bundle
	bundle install

xcode:
	xcode-install install 6.3
	xcode-install install 7.2

swift:
	swiftenv install 2.2-SNAPSHOT-2016-01-11-a
	swiftenv global 2.2-SNAPSHOT-2016-01-11-a

alcatraz:
	curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/master/Scripts/install.sh | sh

airport:
	sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

osx-config:
	./.osx-config
