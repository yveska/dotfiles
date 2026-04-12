;;; mono-theme.el --- industrial monochrome -*- lexical-binding: t; no-byte-compile: t; -*-

(deftheme mono
  "A high-contrast industrial monochrome theme with high-distinction Org levels.")

(let* ((class '((class color) (min-colors 89)))
       ;; Core UI Palette
       (bg-main     "#101214") ; background
       (bg-alt      "#1a1d21") ; color0
       (bg-active   "#2a2a2d") ; active_tab_background
       (fg-main     "#c9c7cd") ; foreground
       (fg-bright   "#f0efeb") ; cursor / color14
       (fg-dim      "#57575f") ; inactive_tab_foreground
       (border      "#4a4a4a") ; selection_background / active_border
       
       ;; High-Distinction Heading Palette (Inspired by mono.conf)
       (lvl-1-bone  "#f0efeb") ; color14: Bone White (Starkest)
       (lvl-2-steel "#8b919a") ; color2/12: Steel (Distinct bluish-gray)
       (lvl-3-ash   "#c1c0d4") ; color3: Ash Silver (Neutral metallic)
       (lvl-4-slate "#57575f") ; color4/9: Deep Slate
       (lvl-5-iron  "#353539")) ; color8: Iron (Darkest structural gray)

  (custom-theme-set-faces
   'mono
   ;; --- Core UI ---
   `(default ((,class (:background ,bg-main :foreground ,fg-main))))
   `(region ((,class (:background ,border :foreground ,fg-bright))))
   `(highlight ((,class (:background ,bg-active :foreground ,fg-bright))))
   `(hl-line ((,class (:background ,bg-alt))))
   `(fringe ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(cursor ((,class (:background ,fg-bright))))
   `(vertical-border ((,class (:foreground ,border))))
   `(minibuffer-prompt ((,class (:foreground ,fg-bright :weight bold))))
   
   ;; --- Syntax Highlighting ---
   `(font-lock-builtin-face ((,class (:foreground ,lvl-3-ash))))
   `(font-lock-comment-face ((,class (:foreground ,fg-dim :slant italic))))
   `(font-lock-constant-face ((,class (:foreground ,lvl-4-slate))))
   `(font-lock-function-name-face ((,class (:foreground ,lvl-3-ash))))
   `(font-lock-keyword-face ((,class (:foreground ,fg-bright :weight bold))))
   `(font-lock-string-face ((,class (:foreground ,lvl-4-slate))))
   `(font-lock-type-face ((,class (:foreground ,lvl-3-ash :italic t))))
   `(font-lock-variable-name-face ((,class (:foreground ,fg-main))))
   `(font-lock-number-face ((,class (:foreground ,lvl-4-slate))))
   `(font-lock-operator-face ((,class (:foreground ,fg-bright))))

   ;; --- Mode Line (Segmented look) [cite: 2] ---
   `(mode-line ((,class (:background ,bg-active :foreground ,fg-bright :box (:line-width 1 :color ,border)))))
   `(mode-line-inactive ((,class (:background ,bg-alt :foreground ,fg-dim :box (:line-width 1 :color ,bg-alt)))))

   ;; --- High-Distinction Org & Roam Headings ---
   ;; Bolded for visibility from afar, height locked at 1.0 for structural consistency
   `(org-level-1 ((,class (:foreground ,lvl-1-bone  :weight bold :height 1.0))))
   `(org-level-2 ((,class (:foreground ,lvl-2-steel :weight bold :height 1.0))))
   `(org-level-3 ((,class (:foreground ,lvl-3-ash   :weight bold :height 1.0))))
   `(org-level-4 ((,class (:foreground ,lvl-4-slate :weight bold :height 1.0))))
   `(org-level-5 ((,class (:foreground ,lvl-5-iron  :weight bold :height 1.0))))
   `(org-block ((,class (:background ,bg-alt))))
   `(org-date ((,class (:foreground ,fg-dim))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mono)
