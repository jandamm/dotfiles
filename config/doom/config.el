;;; .config/doom/config.el -*- lexical-binding: t; -*-

;; Custom functions
(load! "+functions")

;; Custom key bindings
(load! "+bindings")

;; Visual changes
(load! "+interface")

;; `Mode-Config'
(load! "+lang")  ; General language config and minor language config
(load! "+org")   ; Org-mode specific config
(load! "+swift") ; Swift and iOS specific config

(after! company
  ;; Reduce company completion delay
  (setq company-idle-delay 0.1)
  )

(setq
 ;; Set User Info
 user-full-name "Jan Dammshäuser"
 user-mail-address "jan@dammshaeuser.de"

 ;; Set avy (jump to) keys to colemak
 avy-keys '(?a ?r ?s ?t ?d ?h ?n ?e ?i ?o)
 ;; Set paths where projectile searches projects
 projectile-project-search-path
 '(
   "~/Projects/work"
   "~/.config"
   )
 )
