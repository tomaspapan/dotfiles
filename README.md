# [Tomas Papan's](http://papan.sk) Dotfiles

## Install

### Pull the repo into your home directory

``` bash
cd ~
rm ~/.bashrc
git init
git remote add origin https://gitlab.papan.sk/morpheus/dotfiles.git
git pull origin master  --force
git branch --set-upstream master origin/master
```

### Tell your system to load the custom configurations

```
source ~/.bashrc
vim_setup.sh
```


## Things I use

## OSX

``` bash
# Install XCode Command Line Tools (manual, after this restart computer)
xcode-select --install

# Install dotfiles (see intstructions above)

# Homebrew (manual, after this open new terminal)
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Homebrew Modules (after this open new terminal)
brew install bash git git-extras python ruby wget hub

# Homebrew Binaries
brew tap phinze/cask
brew install brew-cask
brew tap caskroom/versions
brew cask install alfred google-chrome google-chrome-canary google-hangouts google-drive firefox firefox-aurora github dropbox skype screenflow
```


## License

Public domain
