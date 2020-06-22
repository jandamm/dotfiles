# dotfiles

## Full installation

- `git clone --recurse-submodules git@github.com:jandamm/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles && ./bin/dotfiles install`

### Use zsh from Homebrew as login shell

- `echo '/usr/local/bin/zsh' >> /etc/shells`
- `chsh -s /usr/local/bin/zsh`

## Adding files

### Existing files (dotfiles not yet in rcm)

- Add file:             `mkrc file`
- Add folder:           `mkrc folder`
- Add symlink folder:   `mkrc -S folder` and add folder to `~/.rcrc` -> `SYMLINK_DIRS`
- Add file without dot: `mkrc -U file`

### New file (not yet in filesystem)

- Add file:             `touch file`
- Add symlink folder:   `mkdir folder` and add folder to `~/.rcrc` -> `SYMLINK_DIRS`

Then propagate the changes with `rcup`

## Excluding folders/files

Add folder/file to `~/.rcrc` -> `EXCLUDES`
