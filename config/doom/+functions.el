;;; ~/.config/doom/+functions.el

(defmacro aif (&rest forms)
  "Create an anonymous interactive function.
    Mainly for use when binding a key to a non-interactive function."
  `(lambda () (interactive) ,@forms))

(defun enter-mapping (offset movement)
  "Call function and move to position from beginning with offset."
  (let ((p (point)))
    (funcall movement)
    (goto-char (+ p offset))))

(defun jd/enter-newline-below ()
  "Enters a newline below the current line"
  (interactive)
  (enter-mapping 0 #'evil-insert-newline-below))

(defun jd/enter-newline-above ()
  "Enters a newline above the current line"
  (interactive)
  (enter-mapping 1 #'evil-insert-newline-above))

(defun jd/update-projectile ()
    "Set all projects"
    (interactive)
    (projectile-add-known-project "~/scripts")
    (projectile-add-known-project "~/org")
    (projectile-discover-projects-in-search-path))

(defvar jd/theme-selected 0)
(defun jd/theme-dark ()
  "Sets the dark theme"
  (interactive)
  (load-theme 'doom-one t)
  (setq jd/theme-selected 1))

(defun jd/theme-light ()
  "Sets the light theme"
  (interactive)
  (load-theme 'doom-one-light t)
  (setq jd/theme-selected 0))

(defun jd/theme-toggle ()
  "Switch between light and dark theme."
  (interactive)
  (if (= 0 jd/theme-selected)
      (jd/theme-dark)
      (jd/theme-light)
  ))
