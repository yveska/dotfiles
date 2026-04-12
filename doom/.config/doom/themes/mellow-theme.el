;;; mellow-theme.el --- dark and mellow -*- lexical-binding: t; no-byte-compile: t; -*-

;; Package-Requires: ((emacs "29"))

;;; Commentary:
;; Mellow theme for Emacs, ported from mellow.nvim.

;;; Code:

(deftheme mellow)
(let* ((class '((class color) (min-colors 89)))
       ;; Mellow Palette Mapping
       (base00 "#161617") ; background
       (base01 "#1b1b1d") ; inactive_tab_background
       (base02 "#3C3B3E") ; selection_background
       (base03 "#57575f") ; inactive_tab_foreground
       (base04 "#c9c7cd") ; foreground
       (base05 "#c1c0d4") ; color7
       (base06 "#e3e2e5") ; cursor / selection_foreground
       (base07 "#ea83a5") ; color6 (cyan)
       (base08 "#f591b2") ; color14 (bright cyan)
       (base09 "#aca1cf") ; color4 (blue)
       (base0A "#f5a191") ; color1 (red)
       (base0B "#b9aeda") ; color12 (bright blue)
       (base0C "#e29eca") ; color5 (magenta)
       (base0D "#90b99f") ; color2 (green)
       (base0E "#ecaad6") ; color13 (bright magenta)
       (base0F "#e6b99d") ; color3 (yellow)

       ;; Logical Assignments
       (bg1 base00)
       (bg2 base01)
       (bg3 "#353539") ; color8 / active_tab_background
       (bg4 base03)
       (fg1 base04)
       (fg2 base05)
       (fg3 base06)
       (builtin   base0C) ; magenta
       (number    base0F) ; yellow/orange
       (keyword   base0C) ; magenta
       (const     base0F) ; yellow/orange
       (comment   base03) ; inactive text
       (func      base09) ; blue
       (str       base0D) ; green
       (type      "#f0c5a9") ; color11
       (var       base04) ; foreground
       (oper      base04)
       (selection base02)
       (warning   base0F)
       (error     base0A))

  (custom-theme-set-faces
   'mellow
   ;;; emacs <built-in>
   `(default ((,class (:background ,bg1 :foreground ,fg1))))
   `(region ((,class (:background ,selection :foreground ,fg3))))
   `(highlight ((,class (:foreground ,fg3 :background ,bg3))))
   `(hl-line ((,class (:background ,bg2))))
   `(fringe ((,class (:background ,bg1 :foreground ,bg4))))
   `(cursor ((,class (:background ,base06))))
   `(isearch ((,class (:weight bold :background ,base0B :foreground ,bg1))))
   `(isearch-fail ((,class (:weight bold :foreground ,error :background ,bg2))))
   `(minibuffer-prompt ((,class (:foreground ,func :inherit fixed-pitch-serif))))
   `(tooltip ((,class (:background ,bg2 :foreground ,fg1))))
   `(match ((,class (:foreground ,base0F :weight bold))))
   `(italic ((,class (:italic t))))
   `(bold ((,class (:weight bold))))
   `(vertical-border ((,class (:foreground ,bg3))))
   `(link ((,class (:foreground ,func :underline t))))
   `(error ((,class (:foreground ,error))))
   `(success ((,class (:foreground ,base0D))))
   `(warning ((,class (:foreground ,warning))))
   `(line-number ((t (:foreground ,comment))))
   `(line-number-current-line ((t (:foreground ,fg2 :weight bold))))

    ;;; font-lock-*
   `(font-lock-builtin-face ((,class (:foreground ,builtin))))
   `(font-lock-comment-face ((,class (:foreground ,comment :slant italic))))
   `(font-lock-constant-face ((,class (:foreground ,const))))
   `(font-lock-function-name-face ((,class (:foreground ,func))))
   `(font-lock-keyword-face ((,class :foreground ,keyword)))
   `(font-lock-type-face ((,class (:foreground ,type))))
   `(font-lock-variable-name-face ((,class (:foreground ,var))))
   `(font-lock-number-face ((,class (:foreground ,number))))
   `(font-lock-operator-face ((,class (:foreground ,oper))))
   `(font-lock-string-face ((,class (:foreground ,str))))

   ;;; mode-line
   `(mode-line ((,class (:box nil :foreground ,fg1 :background ,bg3))))
   `(mode-line-inactive ((,class (:foreground ,comment :background ,bg2))))

   ;;; org-mode
   `(org-document-title ((,class (:foreground ,func :weight bold :height 1.2))))
   `(org-level-1 ((,class (:foreground ,func :weight bold))))
   `(org-level-2 ((,class (:foreground ,base0B :weight bold))))
   `(org-level-3 ((,class (:foreground ,base07 :weight bold))))
   `(org-level-4 ((,class (:foreground ,base0D :weight bold))))
   `(org-level-5 ((,class (:foreground ,base0A :weight bold))))
   `(org-block ((,class (:background ,bg2))))
   `(org-date ((,class (:foreground ,comment))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mellow)

;;; mellow-theme.el ends here
