# dotfiles

## Full installation

- `git clone --recurse-submodules git@github.com:jandamm/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles && ./zsh/.local/bin/dotfiles install`

### Use zsh from Homebrew as login shell

- `echo '/usr/local/bin/zsh' >> /etc/shells`
- `chsh -s /usr/local/bin/zsh`

## Updating

`dotfiles update`

## Introduce new files

`dotfiles stow`

## Excluding folders

`touch $folder/.nostow`
