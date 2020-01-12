# dotfiles

## Prerequisites

- [Homebrew](https://brew.sh)
- git

## Full installation

- `git clone git@github.com:jandamm/dotfiles.git ~/.dotfiles`
- `git submodule update --init --recursive`
- `cd ~/.dotfiles && ./bin/dotfile-setup --full`

The parameter full will install all programs with Homebrew.
If Homebrew is not available install all programs from `Brewfile` and run with `--full`

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
