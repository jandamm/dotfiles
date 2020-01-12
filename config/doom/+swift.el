;;; ~/.config/doom/+swift.el -*- lexical-binding: t; -*-

;; Open `*.swift' in `swift-mode'
(add-to-list 'auto-mode-alist '("\\.swift\\'" . swift-mode))

;; `LSP-Support'
;;(require 'lsp-sourcekit)
;;(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2019-02-14-a.xctoolchain")
;;(setq lsp-sourcekit-executable (expand-file-name "/usr/local/bin/sourcekit-lsp"))
;;(add-hook 'swift-mode-hook 'lsp)

;; iOS

;; Open `fastlane/*' in `ruby-mode'
(add-to-list 'auto-mode-alist '("/fastlane/\\w+" . ruby-mode))
;; Open `*.strings' in `prog-mode'
(add-to-list 'auto-mode-alist '("\\.strings\\'" . prog-mode))
