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
; (setq confirm-kill-emacs nil)
(blink-cursor-mode 1)
(setq auto-save-default t)
(setq delete-by-moving-to-trash t)

(setq evil-normal-state-cursor '(box "#7AA89F")
      evil-insert-state-cursor '((bar . 2) "#7AA89F")
      evil-visual-state-cursor '(hollow "#7AA89F"))

;; --- ORG SETUP ---
(setq org-directory "~/Life/org/")
(setq org-roam-directory (file-truename "~/Life/roam/"))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/Life/roam/"))
  (org-roam-completion-everywhere t)

  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      "** %<%I:%M %p>: %?"
      :target (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n

* Today did I... [/]
  - [ ] Read
  - [ ] Meditate
  - [ ] Workout
  - [ ] Draw

* Day Plan [/]
  - [ ] x
  - [ ] x

* Gratitude

* Journal"
                                  ("Journal"))
           :empty-lines-before 1
           :unnarrowed t)))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
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
  (citar-notes-paths '("~/Life/roam/references"))
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

(setq citar-org-roam-capture-template-key "nj")

;; --- ORG TEMPLATES ---
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :if-new (file+head "main/${slug}.org" "#+title: ${title}\n") :unnarrowed t)
        ("n" "notes")
        ("na" "article" plain "%?"
         :if-new (file+head "notes/references/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n") :unnarrowed t)
        ("nv" "video" plain "%?"
         :if-new (file+head "notes/references${slug}.org" "#+title: ${title}\n#+filetags: :video:\n") :unnarrowed t)
        ("nm" "movie" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :movie:\n") :unnarrowed t)
        ("nu" "uni" plain "%?"
         :if-new (file+head "uni/${slug}.org" "#+title: ${title}\n#+filetags: :uni:\n") :unnarrowed t)
        ("nj" "journal" plain "%?"
         :if-new (file+head "~/Life/roam/notes/references/${slug}.org" "#+title: ${title}\n#+filetags: :reference:\n") :unnarrowed t)
        ("nb" "book" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :book:\n#+author:\n") :unnarrowed t)))

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
