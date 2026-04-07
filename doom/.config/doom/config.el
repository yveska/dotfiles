;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; --- PERSONAL INFO ---
(setq user-full-name "Adam Arshad"
      user-mail-address "adamarshad.school@gmail.com")

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
(setq doom-theme 'kanso)
(setq display-line-numbers-type nil)

;; Margins
(setq-default left-margin-width 2
              right-margin-width 2
              line-spacing 0.12)

;; Remove fringes/slivers
(fringe-mode 0)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 17)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font" :size 17)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 17)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font" :size 17))

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

;; --- MODELINE (GROUPED & MINIMAL) ---
(defun my-fix-doom-modeline-error ()
  (setq doom-modeline-buffer-file-name-style 'file-name
        ;; Group 1: Symbols & Words
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon nil
        ;; Remove Clutter (File size, encoding, etc)
        doom-modeline-size nil
        doom-modeline-buffer-encoding nil
        doom-modeline-indent-info nil
        doom-modeline-enable-word-count nil
        ;; Group 2: Numbers (Line:Col)
        doom-modeline-percent-position nil
        ;; Alignment
        doom-modeline-bar-width 0
        doom-modeline-margin-right 2))

(add-hook 'doom-after-init-hook #'my-fix-doom-modeline-error)

(after! doom-modeline
  (setq doom-modeline-height 25)
  (custom-set-faces!
    `(doom-modeline-buffer-file :foreground "#7AA89F" :weight bold)
    `(mode-line :background ,(doom-color 'bg) :foreground ,(doom-color 'fg-alt) :box nil)
    `(mode-line-inactive :background ,(doom-color 'bg) :foreground ,(doom-color 'base5) :box nil)))

;; HIDE MODELINE BY DEFAULT
(add-hook 'after-change-major-mode-hook #'hide-mode-line-mode)

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
    '(("d" "default" entry "* %<%I:%M %p>: %?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n g" . org-roam-graph)
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

;; --- ORG TEMPLATES --- 
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :if-new (file+head "main/${slug}.org" "#+title: ${title}\n") :unnarrowed t)
        ("r" "reflections" plain "%?"
         :if-new (file+head "reflections/${slug}.org" "#+title: ${title}\n") :unnarrowed t)
        ("n" "notes")
        ("na" "article" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n") :unnarrowed t)
        ("nv" "video" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :video:\n") :unnarrowed t)
        ("nm" "movie" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :movie:\n#+director:\n") :unnarrowed t)
        ("nb" "book" plain "%?"
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :book:\n#+author:\n") :unnarrowed t)))

(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; --- SYSTEM & UI FIXES ---
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "zen-browser"
      x-no-window-manager t
      frame-inhibit-implied-resize t
      focus-follows-mouse nil
      which-key-idle-delay 0.2)

;; --- DASHBOARD (DRAINED ASCII) ---
(remove-hook! '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu #'doom-dashboard-widget-footer)
(custom-set-faces! '(doom-dashboard-banner :foreground "#7AA89F" :weight bold))

(defun ascii ()
  (let* ((banner '("
               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
               ⠀⠀⠀⠀⠀⠀⠀⡀⢄⢮⡳⣶⢭⣖⣢⡤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢀⢤⣢⣵⣾⣾⣾⣾⣾⣾⣾⣾⣿⣶⣯⣵⣒⡠⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⣎⣿⣿⣿⣿⣾⡿⠛⠛⠻⣿⣿⣿⣿⣿⣿⡇⣿⣟⣵⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⡇⠼⣿⣿⣿⡟⠀⢠⣤⢸⡊⢻⣿⡿⣿⣿⡇⣿⣿⣷⣝⣕⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⡇⢑⢻⣿⣿⣧⡀⣅⡡⣠⠆⠹⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⢟⢯⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⡇⣸⢉⢿⣯⣿⣿⣶⣧⣤⣰⣾⣿⡟⠽⣋⣈⢿⣿⣿⣿⣿⢸⣷⣝⠮⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⣷⣿⠠⣞⢿⣿⣿⣿⣿⢟⡫⡗⡢⡑⢭⣗⡺⢷⣙⠿⣿⣿⣼⣿⢿⣷⣍⣎⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⢸⣿⣿⣼⡏⠗⢝⢿⣿⡈⢥⣿⠞⡜⡼⣾⣛⢿⣛⣻⣷⣰⠹⣻⣿⣿⣿⣿⣿⣮⡪⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⣸⣿⣿⣾⡇⠄⠁⠋⣊⢟⠬⡻⣯⡵⣣⡻⣟⡦⢾⣿⣋⣇⢉⣿⣿⣿⣿⣿⣿⣿⣿⣿⡪⡢⡀⠀⠀⠀⠀⠀⠀⠀
                ⠠⠰⣹⢔⠹⣿⣿⣫⠁⠀⢰⡌⢿⡎⢜⠝⡿⣟⡫⢗⡫⠏⠙⢫⣵⠘⣄⡘⠿⣿⣿⣿⣿⣿⣿⣿⣾⣮⡢⡀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠄⡚⠘⢿⣯⡅⠀⢸⠇⠄⠀⠀⠉⠲⠔⡱⡻⢿⣽⣁⠢⢼⣶⣿⣿⣷⣬⡉⡹⠿⣿⣿⣿⣿⣿⣯⡪⡢⡀⠀⠀⠀
                ⠀⠀⠠⠀⢀⠄⠎⢿⣷⠀⢸⠇⡄⡆⡌⠁⡂⠀⡘⢠⠱⠨⢛⢿⣶⣬⡉⡹⠻⣿⣷⣢⣄⠙⢿⣿⣿⣿⣿⡿⠞⢞⡆⠀⠀
                ⠀⠀⠀⠀⠈⠈⠒⠊⡻⡇⡄⡒⠤⡀⠁⠃⠁⢠⢀⠁⠀⠀⠂⢉⢊⠝⠿⣶⡤⡘⢿⣿⣷⣝⢦⣙⠿⡛⣉⣼⣾⣿⡇⠀⠀
                ⠀⠀⠀⠀⠀⠘⠠⢬30⠱⠺⢵⡣⢆⡅⢆⡎⠘⠈⠘⢰⠰⠀⠃⠎⡔⠸⢐⠹⢻⢵⡩⣛⢟⢋⣡⣵⣿⡟⢹⢿⣿⡇⠀⠀
                ⠀⠀⠀⠀⠀⠀⠂⠄⡈⢀⠀⠑⢉⢓⠾⡥⢨⠐⡠⣀⠂⠆⡄⡄⡀⠐⢀⠀⡌⡖⢌⠪⣤⢾⣿⣿⣿⣏⣍⢰⣿⢿⡇⢤⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠐⠁⠀⠈⠐⠱⠁⢊⢅⡃⠉⢒⠤⡁⠃⠦⢌⠘⠀⠁⠀⠂⣿⣿⣿⣿⣿⣿⣧⣸⣾⣿⡇⢠⠰
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠄⠄⡀⠂⠅⠌⠕⣰⢈⠒⠵⢢⢎⣐⠀⡃⠄⠀⣿⢷⣿⣿⣿⣟⣯⣷⠿⢻⢱⠂⠈
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠈⠀⢉⢒⠄⡂⡖⡩⢒⠄⠀⣿⡿⣟⣽⣾⡟⡏⠆⠀⠑⠈⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠄⠂⠈⠈⢑⠣⢇⡎⠄⣿⣿⡿⡉⠃⠃⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠁⠁⠀⠎⠛⠉⡀⠉⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
                  "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32))) "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'ascii)

;; --- KEYBINDINGS ---
(map! "C-s" #'save-buffer)
(map! :leader
      :desc "Mode line" "t m" #'global-hide-mode-line-mode
      :desc "Org capture" "X" #'org-capture)
