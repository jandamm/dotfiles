;; -*- no-byte-compile: t; -*-
;;; .config/doom/packages.el

(package! teacode-expand :recipe (:host github
                                 :repo "raguay/TeaCode-Expand"
                                 :files ("tokens" "teacode-expand.el")))
;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
