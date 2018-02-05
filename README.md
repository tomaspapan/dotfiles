## [Tomas Papan's](http://papan.sk) Dotfiles

### Prerequisites
```
git vim python rsync zsh zsh-completions curl
optional: the_silver_searcher(ag)
```


### Pull the repo into your home directory
```
git clone https://gitlab.papan.sk/morpheus/dotfiles.git
./dotfiles/bootstrap.sh
```

### Install vim dependencies
```
install-vim
```
It will install all the plugins and run the YouCompleteMe install script
with clang support.

### Update
```
reload
```

### `~/.gitconfig.local`

If the `~/.gitconfig.local` file exists, it will be automatically
included after the configurations from [`~/.gitconfig`](git/gitconfig), thus, allowing
its content to overwrite or add to the existing `git` configurations.

**Note:** Use `~/.gitconfig.local` to store sensitive information such
as the `git` user credentials, e.g.:

```sh
[user]
  name = Tomas Papan
  email = tomas@example.com
```

### Openbox

My default WM in Linux is Openbox + tint2 + urxvt
Fonts: Roboto, Dejavu, Noto

### License
Public domain
