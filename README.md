# dotfiles

## Full installation

- `git clone git@github.com:jandamm/dotfiles.git ~/.dotfiles`
- `# cd ~/.dotfiles && git clone git@github.com:jandamm/dotfiles_private.git ~/.private`
- Make sure Xcode is installed and `sudo xcode-select -p "your Xcode path"` is run
- `cd ~/.dotfiles && ./dotfiles install`

### Use zsh from Homebrew as login shell

- `echo '/usr/local/bin/zsh' >> /etc/shells`
- `chsh -s /usr/local/bin/zsh`

## Updating

`dotfiles update`

## Introduce new files

- `dotfiles add` to add existing files to ~/.dotfiles
- `dotfiles stow` after creating files inside ~/.dotfiles

## Excluding folders

`touch $folder/.nostow`
