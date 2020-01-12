;;; .config/doom/+org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org")

(after! org
  (setq
   +org-capture-todo-file "Inbox.org" ; Set default todo file
   +org-capture-notes-file "Notes.org" ; Set default notes file
   org-tags-column -100 ; the column to the right to align tags
   org-log-done 'time ; record the time when an element was marked done/checked
   org-agenda-skip-timestamp-if-done t ; Don't show done items in agenda
   org-refile-use-outline-path 'file ; Allow refiling into file (instead of just items)
   org-outline-path-complete-in-steps nil ; Show full paths instead of names only (just needed with refile to 'file)
   org-refile-allow-creating-parent-nodes 'confirm ; Allow creating new nodes while refiling
   )

  ;; Set templates
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file +org-capture-todo-file)
           "* TODO %?\n%i\n%a" :prepend nil :kill-buffer t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a" :prepend t :kill-buffer t)

          ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; {todo,notes,changelog}.org file is found in a parent directory.
          ;; Uses the basename from `+org-capture-todo-file',
          ;; `+org-capture-changelog-file' and `+org-capture-notes-file'.
          ("p" "Templates for projects")
          ("pt" "Project todo" entry  ; {project-root}/todo.org
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t :kill-buffer t)
          ("pn" "Project notes" entry  ; {project-root}/notes.org
           (file+headline +org-capture-project-notes-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t :kill-buffer t)
          ("pc" "Project changelog" entry  ; {project-root}/changelog.org
           (file+headline +org-capture-project-notes-file "Unreleased")
           "* TODO %?\n%i\n%a" :prepend t :kill-buffer t))
        )
  )
