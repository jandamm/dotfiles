;;; ~/.config/doom/+interface.el -*- lexical-binding: t; -*-

;; Set Theme
(jd/theme-dark)

(setq
 ;; Set font and fontsize
 doom-font (font-spec :family "Hack" :size 14)
 ;; Reduce delay until next key hint popup is shown
 which-key-idle-delay 0.1

 ;; Configure Tabbar
 centaur-tabs-bar-height 20
 centaur-tabs-set-modified-marker t ; Use modifier marker
 centaur-tabs-modified-marker "•" ; Set modifier marker symbol
 centaur-tabs-set-icons nil ; No Filetype icons
 centaur-tabs-set-close-button nil ; No close button
 centaur-tabs-cycle-scope 'tabs ; Cycle through all visible tabs (not through all tabs including workspaces)
 )

;; Nicer font smoothing
(when IS-MAC
  (setq ns-use-thin-smoothing t))

;; Modify Modeline
(after! doom-modeline
  (setq
   doom-modeline-icon t ; Show Icons
   doom-modeline-major-mode-icon t ; Show Major Mode Icon (like emacs symbol)
   doom-modeline-buffer-state-icon t
   doom-modeline-persp-name t ; Show Workspace name
   doom-modeline-persp-name-icon t ; Show Icon next to Workspace name

   evil-normal-state-tag   " Normal  "
   evil-insert-state-tag   " Insert  "
   evil-replace-state-tag  " Replace "
   evil-motion-state-tag   " Motion  "
   evil-visual-state-tag   " Visual  "
   evil-operator-state-tag " Operator"

   evil-insert-state-message ""
   evil-visual-char-message ""
   evil-visual-block-message "V-BLOCK"
   evil-visual-line-message "V-LINE"
   )

  (custom-set-faces!
   `(doom-modeline-evil-normal-state :foreground ,(doom-color 'blue) :weight extra-bold)
   `(doom-modeline-evil-insert-state :foreground ,(doom-color 'green) :weight extra-bold)
   `(doom-modeline-evil-replace-state :foreground ,(doom-color 'red) :weight extra-bold)
   `(doom-modeline-evil-motion-state :foreground ,(doom-color 'blue) :weight extra-bold)
   `(doom-modeline-evil-visual-state :foreground ,(doom-color 'orange) :weight extra-bold)
   `(doom-modeline-evil-operator-state :foreground ,(doom-color 'white) :weight extra-bold)
   )

  ;; Customize Modeline (see `modeline/config.el' for default)
  (doom-modeline-def-modeline 'main
    '(bar modals window-number matches buffer-info remote-host buffer-position selection-info)
    '(objed-state misc-info persp-name irc mu4e github debug input-method buffer-encoding lsp major-mode process vcs checker))
  )
