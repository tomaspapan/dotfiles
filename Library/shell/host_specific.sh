
if [ "$OS" '==' "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    export GIT_EDITOR='mvim -v'
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    alias ls='ls -GFh'
    alias vim='mvim -v'
    alias vi='mvim -v'
    alias lsmod='kextstat'
    alias yass='VBoxManage startvm yass > /dev/null 2>&1; wait_for_host.sh yass 30 && ssh yass'
    alias dnsflush='sudo killall -HUP mDNSResponder'
    # System
    alias stackhighlightyes='defaults write com.apple.dock mouse-over-hilte-stack -boolean yes ; killall Dock'
    alias stackhighlightno='defaults write com.apple.dock mouse-over-hilte-stack -boolean no ; killall Dock'
    alias showallfilesyes='defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder'
    alias showallfilesno='defaults write com.apple.finder AppleShowAllFiles FALSE ; killall Finder'
    alias autoswooshyes='defaults write com.apple.Dock workspaces-auto-swoosh -bool YES ; killall Dock'
    alias autoswooshno='defaults write com.apple.Dock workspaces-auto-swoosh -bool NO ; killall Dock'
    alias nodesktopicons='defaults write com.apple.finder CreateDesktop -bool false'
    # MD5
    alias md5sum='md5 -r'
    # Applications
    alias iosdev='open /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'
    alias androiddev='/Applications/Android\ Studio.app/sdk/tools/emulator -avd basic'
    alias installapp='brew cask install'
    alias va='vagrant'
    alias server='open "http://localhost:8000" && python3 -m http.server'
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

if [ `hostname -s` '==' "r2d2" ];
then
        export TERM='xterm-256color'
fi

if [ `hostname -s` '==' "ul001174" ];
then
        export TERM='xterm-256color'
fi

