;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; My Config <3
;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))



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


;;  (org-roam-dailies-capture-templates
;;   '(("d" "default" entry "* %<%I:%M %p>: %?"
;;       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

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
         :if-new (file+head "notes/${slug}.org" "#+title: ${title}\n#+filetags: :movie:\n") :unnarrowed t)
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

;; --- KEYBINDINGS ---
(map! "C-s" #'save-buffer)
(map! :leader
      :desc "Mode line" "t m" #'global-hide-mode-line-mode
      :desc "Org capture" "X" #'org-capture)
(map! :n "j" #'evil-next-visual-line
      :n "k" #'evil-previous-visual-line)
