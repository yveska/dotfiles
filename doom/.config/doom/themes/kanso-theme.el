;; kanso-theme.el --- live with zen -*- lexical-binding: t; no-byte-compile: t; -*-

;; Package-Requires: ((emacs "29"))

;;; Commentary:
;; Kanso Zen theme for Emacs, ported from kitty/nvim config.

;;; Code:

(deftheme kanso)
(let* ((class '((class color) (min-colors 89)))
       ;; Kansō Palette Mapping
       (base00 "#090E13") ; background
       (base01 "#0d0c0c") ; black
       (base02 "#393B44") ; selection
       (base03 "#A4A7A4") ; comments / bright black
       (base04 "#C5C9C7") ; foreground / cursor
       (base05 "#C8C093") ; white
       (base06 "#C5C9C7") ; bright white
       (base07 "#8ea4a2") ; cyan
       (base08 "#7AA89F") ; bright cyan
       (base09 "#8ba4b0") ; blue
       (base0A "#c4746e") ; red
       (base0B "#7FB4CA") ; bright blue
       (base0C "#a292a3") ; magenta
       (base0D "#8a9a7b") ; green
       (base0E "#938AA9") ; bright magenta
       (base0F "#c4b28a") ; yellow

       ;; Logical Assignments
       (bg1 base00)
       (bg2 base01)
       (bg3 base02)
       (bg4 base03)
       (fg1 base04)
       (fg2 base05)
       (fg3 base06)
       (builtin   base09)
       (number    base0F)
       (keyword   base09)
       (const     base0D) ; Using the green for constants
       (pre       base09)
       (comment   base03)
       (func      base0B) ; Functions in soft blue
       (str       base0E) ; Strings in soft purple
       (type      base07)
       (var       base04)
       (oper      base08)
       (selection base02)
       (warning   base0A)
       (warning2  base0F)
       (unspec    (when (>= emacs-major-version 29) 'unspecified)))

  (custom-theme-set-faces
   'kanso
   ;;; emacs <built-in>
   `(default ((,class (:background ,bg1 :foreground ,fg1))))
   `(region ((,class (:background ,selection))))
   `(highlight ((,class (:foreground ,fg3 :background ,bg3))))
   `(hl-line ((,class (:background ,bg2))))
   `(fringe ((,class (:background ,bg1 :foreground ,fg3))))
   `(cursor ((,class (:background ,fg3))))
   `(isearch ((,class (:weight bold :background ,warning :foreground ,bg1))))
   `(isearch-fail ((,class (:weight bold :foreground ,warning :background ,bg3))))
   `(minibuffer-prompt ((,class (:foreground ,keyword :inherit fixed-pitch-serif))))
   `(tooltip ((,class (:background ,bg2 :foreground ,fg1))))
   `(match ((,class (:foreground ,base0F :weight bold))))
   `(italic ((,class (:italic t))))
   `(bold ((,class (:weight bold))))
   `(vertical-border ((,class (:foreground ,bg3))))
   `(link ((,class (:foreground ,base09 :underline t))))
   `(error ((,class (:foreground ,base0A))))
   `(success ((,class (:foreground ,base0D))))
   `(warning ((,class (:foreground ,base0F))))
   `(line-number ((t (:foreground ,comment))))
   `(line-number-current-line ((t (:foreground ,fg1 :weight bold))))

    ;;; font-lock-*
   `(font-lock-builtin-face ((,class (:foreground ,builtin))))
   `(font-lock-comment-face ((,class (:foreground ,comment :slant italic))))
   `(font-lock-constant-face ((,class (:foreground ,const))))
   `(font-lock-function-name-face ((,class (:foreground ,func :weight bold))))
   `(font-lock-keyword-face ((,class :foreground ,keyword)))
   `(font-lock-type-face ((,class (:foreground ,type))))
   `(font-lock-variable-name-face ((,class (:foreground ,var :slant italic))))
   `(font-lock-number-face ((,class (:foreground ,number))))
   `(font-lock-operator-face ((,class (:foreground ,oper))))
   `(font-lock-string-face ((,class (:foreground ,str))))

   ;;; mode-line
   `(mode-line ((,class (:box nil :foreground ,fg1 :background ,bg2))))
   `(mode-line-inactive ((,class (:foreground ,comment :background ,bg1))))

   ;;; org-mode
   `(org-document-title ((,class (:foreground ,base0B :weight bold :height 1.2))))
   `(org-level-1 ((,class (:foreground ,base0B :weight bold))))
   `(org-level-2 ((,class (:foreground ,base0D :weight bold))))
   `(org-level-3 ((,class (:foreground ,base09 :weight bold))))
   `(org-block ((,class (:background ,bg2))))
   `(org-date ((,class (:foreground ,comment))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'kanso)
