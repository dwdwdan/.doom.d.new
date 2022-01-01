(cond ((eq system-type 'windows-nt)
       (setq sync-dir "C:/Users/Daniel Walters/Dropbox")
       ;; Windows-specific code goes here.
       )
      ((eq system-type 'gnu/linux)
       (setq sync-dir "~/Nextcloud")
       ;; Linux-specific code goes here.
       ))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dan Walters"
      user-mail-address "dan.walters5@outlook.com")

(setq doom-font (font-spec :family "Jetbrains Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "Arial" :size 20))

(setq doom-theme 'doom-dracula)

(setq org-directory (concat sync-dir "/Org")
      org-roam-directory (concat sync-dir "/OrgRoam")
      org-ellipsis " ▼"
      org-superstar-headline-bullets-list `("◉" "○")
      org-agenda-span 7
      org-agenda-start-on-weekday 1
      org-agenda-start-day "+0d"
      org-log-into-drawer t
      org-startup-with-latex-preview t)

(advice-add `org-refile :after `org-save-all-org-buffers)

(after! org
        (dolist (face `((org-level-1 . 1.5)
                        (org-level-2 . 1.4)
                        (org-level-3 . 1.3)
                        (org-level-4 . 1.2)
                        (org-level-5 . 1.1)
                        (org-level-6 . 1.1)
                        (org-level-7 . 1.1)
                        (org-level-8 . 1.05)))
        (set-face-attribute (car face) nil :weight `bold :height (cdr face))))

(after! org
        (set-face-attribute `org-document-title nil :height 300)
        (set-face-attribute `org-block nil :foreground nil :background "#353848" :inherit `fixed-pitch)
        (set-face-attribute `org-code nil :inherit `(shadow fixed-pitch))
        (set-face-attribute `org-table nil :background "#353848" :inherit `(shadow fixed-pitch))
        (set-face-attribute `org-verbatim nil :inherit `(shadow fixed-pitch))
        (set-face-attribute `org-special-keyword nil :inherit `(font-lock-comment-face fixed-pitch))
        (set-face-attribute `org-meta-line nil :inherit `(font-lock-comment-face fixed-pitch))
        (set-face-attribute `org-checkbox nil :inherit `fixed-pitch))

(after! org
        (setq org-todo-keywords `((sequence "TODO(t)" "IN PROGRESS(p)" "WAITING(w)" "|" "DONE(d!)" "CANCELLED(c!)")))
        (setq org-refile-targets `((,(concat org-directory "/archive.org") :maxlevel . 2)
                                   (,(concat org-directory "/todo.org") :maxlevel . 1)))
        (setq org-capture-templates `(("t" "Todo" entry (file ,(concat org-directory "/inbox.org")) "* TODO %?\n %U\n %a\n %i" :empty-lines 1))))

(defun dan/org-setup ()
  (variable-pitch-mode 1)
  (org-indent-mode)
  (display-line-numbers-mode 0)
  (org-fragtog-mode))

(add-hook! org-mode (dan/org-setup))

(use-package! visual-fill-column
  :hook (org-mode . dan/org-visual-fill))

(defun dan/org-visual-fill ()
  (setq visual-fill-column-width 125)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(setq browse-url-mailto-function 'browse-url-generic)
(setq browse-url-generic-program "evolution")

(setq display-line-numbers-type `relative)
(setq +latex-viewers `(pdf-tools))
