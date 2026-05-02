;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; --- PERFORMANCE & SYSTEM ---
(setq gc-cons-threshold (* 256 1024 1024)
      read-process-output-max (* 4 1024 1024)
      comp-deferred-compilation t
      comp-async-jobs-number 8
      gcmh-idle-delay 5
      gcmh-high-cons-threshold (* 1024 1024 1024)
      vc-handled-backends '(Git)
      ispell-program-name "enchant-2")

;; --- VISUALS & THEME ---
(setq doom-theme 'doom-mono-industrial)
(setq display-line-numbers-type nil)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Inter" :size 15 :weight 'light))

;; Margins
(setq-default left-margin-width 2
              right-margin-width 2
              line-spacing 0.12)

;; Remove fringes/slivers
(fringe-mode 0)

;; Transparency & Frame
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

(add-to-list 'default-frame-alist '(undecorated . t))
(set-frame-parameter (selected-frame) 'alpha '(96 . 97))
(add-to-list 'default-frame-alist '(alpha . (96 . 97)))

;; --- CURSOR & INTERACTION ---
(setq confirm-kill-emacs nil)
(blink-cursor-mode 1)
(setq auto-save-default t)
(setq delete-by-moving-to-trash t)

(setq evil-normal-state-cursor '(box "#7AA89F")
      evil-insert-state-cursor '((bar . 2) "#7AA89F")
      evil-visual-state-cursor '(hollow "#7AA89F"))

;; --- ORG SETUP ---
(setq org-directory "~/Life/org/")
(setq org-roam-directory (file-truename "~/Life/roam/"))
(setq org-agenda-files
      '("~/Life/roam/"
        "~/Life/org/"))

(defun roam/excjournal ()
  "Find roam nodes, excluding journal entries."
  (interactive)
  (org-roam-node-find nil nil
    (lambda (node) (not (member "journal" (org-roam-node-tags node))))))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/Life/roam/"))
  (org-roam-completion-everywhere t)

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n F" . org-roam-node-find)
         ("C-c n f" . roam/excjournal) ;; find all nodes excluding dailies
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n m" . org-roam-ui-mode)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

;; --- CITAR / ZOTERO INTEGRATION
(use-package citar
  :after org
  :custom
  (citar-bibliography '("~/Life/refs.bib"))
  (citar-notes-paths '("~/Life/roam/"))
  (citar-open-always-create-notes nil)
  :bind
  (("C-c n B" . citar-open)
   ("C-c n b" . citar-insert-citation)
   :map org-mode-map
   ("C-c n r" . citar-insert-reference)))

(use-package citar-org-roam
  :after (citar org-roam)
  :config
  (citar-org-roam-mode)
  (setq citar-org-roam-note-title-template "${title}"))

(setq citar-org-roam-capture-template-key "l")

;; --- ORG TEMPLATES ---
(setq org-roam-capture-templates
      '(
        ("f" "Fleeting" plain
         "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags: fleeting\n\n# References\nOriginal Capture\n> ${title}\n\n* Fleeting\n")
         :unnarrowed t)
        ("l" "Literature" plain
         "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags: literature\n:up: \n\n* _See Also_\n")
         :unnarrowed t)
        ("a" "Atomic" plain
         "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags: atomic\n:up: \n\n* _See Also_\n\n* References\n")
         :unnarrowed t)
        ("p" "Project" plain
         "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags: project\n\n* _Tasks_ [/]\n* _Draft_\n")
         :unnarrowed t)))

(setq org-roam-dailies-capture-templates
   '(("d" "default" entry
      "** %<%I:%M %p>: %?"
      :target (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n#+filetags: journal

* _Today did I..._ [/]
  - [ ] Read
  - [ ] Meditate
  - [ ] Workout
  - [ ] Draw

* _Day Plan_ [/]
  - [ ] x
  - [ ] x

* _Gratitude_

* _Journal_"
                                  ("Journal"))
           :empty-lines-before 1
           :unnarrowed t)))

;; Fix #daily on daily tags
(after! org-roam
  (setq org-roam-dailies-directory "."))

;; --- SYSTEM & UI FIXES ---
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "zen-browser"
      x-no-window-manager t
      frame-inhibit-implied-resize t
      focus-follows-mouse nil
      which-key-idle-delay 0.2)

;; --- KEYBINDINGS ---
(map! "C-s" #'save-buffer)
(map! :leader
      :desc "Mode line" "t m" #'global-hide-mode-line-mode
      :desc "Org capture" "X" #'org-capture)
(map! :n "j" #'evil-next-visual-line
      :n "k" #'evil-previous-visual-line)
(map! :after org
      "C-c n t" #'org-timer-set-timer
      "C-c n s" #'org-timer-stop
      "C-c n p" #'org-timer-pause-or-continue)
