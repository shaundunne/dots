#
# Application installer (via brew-cask)
#
# qlcolorcode - Quicklook files with syntax highlighting
# qlprettypatch - Quicklook at path files
# qlmarkdown - Quicklook markdown files with formatting
# qlstephen - Quicklook for plain text files with no extension
# quicklook-json - JSON formatted in Quicklook
# 
#
#
#

set -e

# Apps
apps=(
  qlcolorcode
  qlprettypatch
  qlmarkdown
  qlstephen
  quicklook-json
  firefox
  opera
  google-chrome
  alfred
  dropbox
  slack
  seil
  spotify
  vagrant
  flash
  iterm2
  shiori
  sublime-text3
  virtualbox
  sketch
  vlc
  font-m-plus
  skype
  lightpaper
  evernote
  dash
  spectacle
)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew tap phinze/homebrew-cask
  brew install brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
