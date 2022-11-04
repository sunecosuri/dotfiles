#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Switch to using brew-installed bash as default shell
if ! grep -F "/bin/fish" /etc/shells; then
  echo "/bin/fish" | sudo tee -a /etc/shells;
  chsh -s "which fish"
fi;

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

#brew install exiv2
brew install git
brew install git-lfs
brew install tree

brew install exa
brew install bat
brew install starship
brew install dog
brew install ripgrep
brew install fd
brew install sd


# Remove outdated versions from the cellar.
brew cleanup
