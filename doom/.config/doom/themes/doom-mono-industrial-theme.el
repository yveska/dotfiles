;;; doom-mono-industrial-theme.el --- Grayscale Industrial with Muted Org Accents -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

(defgroup doom-mono-industrial-theme nil
  "Options for the `doom-mono-industrial' theme."
  :group 'doom-themes)

(defcustom doom-mono-industrial-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line."
  :group 'doom-mono-industrial-theme
  :type '(choice integer boolean))

(def-doom-theme doom-mono-industrial
  "A high-contrast monochrome theme with industrial accents for Org mode."
  :family 'doom-mono-industrial
  :background-mode 'dark

  ;; 1. COLOR VARIABLES BLOCK
  ((bg         '("#101214" "black"       "black"  ))
   (fg         '("#c9c7cd" "#bfbfbf"     "brightwhite"  ))

   (base0      '("#08080a" "black"       "black"        ))
   (base1      '("#1a1d21" "#1e1e1e"     "brightblack"  ))
   (base2      '("#2a2a2d" "#2e2e2e"     "brightblack"  ))
   (base3      '("#353539" "#262626"     "brightblack"  ))
   (base4      '("#4a4a4a" "#3f3f3f"     "brightblack"  ))
   (base5      '("#57575f" "#525252"     "brightblack"  ))
   (base6      '("#8b919a" "#6b6b6b"     "brightblack"  ))
   (base7      '("#cac9dd" "#979797"     "brightblack"  ))
   (base8      '("#f0efeb" "#dfdfdf"     "white"        ))

   (bg-alt     base1)
   (fg-alt     base5)

   (grey       base4)
   (red        '("#4a4a4a" "red" "red"))
   (orange     '("#8b919a" "orange" "orange"))
   (green      '("#a0a0a0" "green" "green"))
   (teal       '("#8b919a" "brightgreen" "brightgreen"))
   (yellow     '("#c1c0d4" "yellow" "yellow"))
   (blue       '("#57575f" "blue" "blue"))
   (dark-blue  '("#353539" "blue" "blue"))
   (magenta    '("#4a4a4a" "magenta" "magenta"))
   (violet     '("#57575f" "magenta" "magenta"))
   (cyan       '("#cac9dd" "cyan" "cyan"))
   (dark-cyan  '("#8b919a" "cyan" "cyan"))

   ;; Industrial Accents
   (blue-accent    '("#738294" "#738294" "blue"))
   (green-accent   '("#8ba48d" "#8ba48d" "green"))
   (rose-accent    '("#a48b8b" "#a48b8b" "magenta"))
   (gold-accent    '("#b09f87" "#b09f87" "yellow"))

   ;; Mandatory Universal Syntax Classes
   (highlight      base7)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      base4)
   (builtin        cyan)
   (comments       base5)
   (doc-comments   (doom-lighten base5 0.2))
   (constants      violet)
   (functions      base8)
   (keywords       base7)
   (methods        cyan)
   (operators      fg)
   (type           base6)
   (strings        green)
   (variables      fg)
   (numbers        orange)
   (region         base2)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    base6)
   (vc-added       green-accent)
   (vc-deleted     rose-accent)

   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              base1)
   (modeline-bg-alt          base0)
   (modeline-bg-inactive     bg)
   (modeline-bg-inactive-alt base0)

   (-modeline-pad
    (when doom-mono-industrial-padded-modeline
      (if (integerp doom-mono-industrial-padded-modeline) doom-mono-industrial-padded-modeline 4))))

  ;; 2. FACE OVERRIDES BLOCK
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground base8)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))

   ;; Org-mode Heading Hierarchy (Colors only, default Doom weights/sizes)
   (org-level-1 :foreground base8)
   (org-level-2 :foreground blue-accent)
   (org-level-3 :foreground green-accent)
   (org-level-4 :foreground rose-accent)
   (org-level-5 :foreground gold-accent)
   (org-level-6 :foreground base6)
   (org-level-7 :foreground base5)
   (org-level-8 :foreground base4)

   ;; Org structural elements
   (org-todo  :foreground rose-accent :weight 'bold)
   (org-done  :foreground green-accent :strike-through t)
   (org-headline-done :foreground base5 :strike-through nil)
   (org-link  :foreground blue-accent :underline t)
   (org-table :foreground base7 :background base1)

   ;; UI Overrides
   (ivy-current-match :background base4 :distant-foreground base0 :weight 'normal)
   (markdown-header-face :inherit 'bold :foreground base8)
   ((markdown-code-face &override) :background base1)))
