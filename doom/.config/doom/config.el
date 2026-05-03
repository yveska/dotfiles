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

(custom-set-faces!
  '(org-level-1 :height 1.03 :weight bold)
  '(org-level-2 :height 1.02 :weight bold)
  '(org-level-3 :height 1.01 :weight bold)
  '(org-checkbox :height 1.1 :foreground "#738294" :weight bold)
  '(org-tag :height 0.8 :foreground "#57575f" :weight light))

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

(add-hook 'window-setup-hook #'global-hide-mode-line-mode)

;; --- CURSOR & INTERACTION ---
(setq confirm-kill-emacs nil)
(blink-cursor-mode 0)
(setq auto-save-default t)
(setq delete-by-moving-to-trash t)

(setq evil-normal-state-cursor '(box "#738294")
      evil-insert-state-cursor '((bar . 2) "#8ba48d")
      evil-visual-state-cursor '(hollow "#a48b8b"))

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

* Journal"
                                  ("Journal"))
           :empty-lines-before 1
           :unnarrowed t)))

;; Fix #daily on daily tags
(after! org-roam
  (setq org-roam-dailies-directory "."))

;; Jinx
(use-package! jinx
  :hook (doom-first-input . global-jinx-mode)
  :config
  (setq jinx-languages "en_US")

  (map! :leader
        (:prefix-map ("s" . "search/spell") ;; Nesting under the existing 's' prefix
         :desc "Jinx correct"           "j" #'jinx-correct
         :desc "Jinx correct all"       "J" #'jinx-correct-all
         :desc "Jinx languages"         "l" #'jinx-languages))
  (map! "M-$"   #'jinx-correct
        "C-M-$" #'jinx-languages))

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
