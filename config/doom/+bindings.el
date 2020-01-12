;;; ~/.config/doom/+bindings.el -*- lexical-binding: t; -*-

(map!
 ;; Colemak for germans
 (:map key-translation-map
   "M-a" (kbd "ä")
   "M-o" (kbd "ö")
   "M-u" (kbd "ü")
   "M-e" (kbd "€")
   "M-s" (kbd "ß")
   [(meta shift a)] (kbd "Ä")
   [(meta shift o)] (kbd "Ö")
   [(meta shift u)] (kbd "Ü"))

 ;; Emacs Cursor movement
 :i "C-f" (kbd "<right>")
 :i "C-n" (kbd "<down>")
 :i "C-p" (kbd "<up>")
 :i "C-b" (kbd "<left>")
 ;; :i "C-a" 'evil-beginning-of-visual-line ; already implemented
 ;; :i "C-e" 'evil-end-of-visual-line ; already implemented

 ;; Map centaur tabs to g t
 :n "g t" #'centaur-tabs-forward
 :n "g T" #'centaur-tabs-backward
 ;; Remap workspaces from g t to g TAB
 :n "g TAB" #'+workspace/switch-right
 :n "g <backtab>" #'+workspace/switch-left

 ;; Nicer ESC in Emacs:
 ;; - Keyboard Maestro maps ESC to C-g
 ;; - C-g is mapped evil-escape
 ;; - C-g isn't working by default in company
 "C-g" #'evil-escape
 (:after company
   (:map company-active-map
     "C-g" #'evil-escape))

 ;; U to Redo
 :n "U" #'undo-tree-redo

 ;; Enter to New Line
 :n "RET" #'jd/enter-newline-below
 :n [(shift return)] 'jd/enter-newline-above

 ;; Move selected line
 ;; :n "C-M-[" (aif (move-text-up))
 ;; :n "C-M-]" (aif (move-text-down))

 ;; Evil-Surround
 ;; TODO What should surround do? There's also evil-snipe.
 ;; (:map evil-surround-mode-map
 ;; :v "S" #'evil-surround-region)

 ;; TeaCode
 :i "C-M-e" #'teacode-expand

 ;; Key bindings for org mode
 (:after org
   (:map org-mode-map
     :n "M-j" #'org-metadown
     :n "M-k" #'org-metaup))

 ;; Change theme with SPC t t
 (:leader
   (:prefix-map ("t" . "toggle")
     :desc "Toggle themes" "t" #'jd/theme-toggle)
   (:prefix-map ("p" . "project")
     :desc "Update project list" "U" #'jd/update-projectile))
 )
