# NeoVim Plugin/Configuration paths

## after
Loaded after plugins and init.vim.
Use to modify external plugins.
- ftplugin
- plugin

## autoload
Functions that aren't loaded with init.vim
Usage: `some#lazy#function` should be defined in `autoload/some/lazy.vim`

## ftdetect
Short files only to define the filetype.

## ftplugin
Plugin folder (load for language).
Modification for languages. Either `swift.vim` or `swift/some.vim`.

## plugin
Plugin folder (load always)

## syntax
Add syntax definitions
