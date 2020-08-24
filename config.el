;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(add-to-list 'custom-theme-load-path "~/.doom.d/custom-themes/ewal-doom-themes")
(add-to-list 'custom-theme-load-path "~/.doom.d/custom-themes/isaac-matrix.el")

(setq server-socket-dir "~/.emacs.d/server")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(defun set-window-size-fixed ()
  (interactive)
  (setq window-size-fixed t))

(add-hook! tide-mode
  (setq tide-format-options '(:indentSize 2 :tabSize 2))
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

(add-hook! web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-enable-auto-closing t)

  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode)))))

(add-hook! js2-mode
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  (setq js2-basic-offset 2))

(add-hook 'before-save-hook 'whitespace-cleanup)

(map! :v ";" 'comment-or-uncomment-region)

(map! :nm "z m" 'origami-close-all-nodes
      :nm "z r" 'origami-open-all-nodes
      :nm "z o" 'origami-open-node
      :nm "z O" 'origami-open-node-recursively
      :nm "z c" 'origami-close-node
      :nm "z C" 'origami-close-node-recursively
      :nm "z a" 'origami-toggle-node)

(global-set-key (kbd "M-0") 'neotree)

(map! :map neotree-mode-map
      :n "RET" 'neotree-enter-ace-window)

(global-set-key (kbd "<f9>") 'set-frame-name)

(global-set-key (kbd "<f8>") 'flycheck-next-error)
(global-set-key (kbd "<f7>") 'flycheck-previous-error)

(map! :map direx:direx-mode-map
      :n "TAB" 'direx:toggle-item
      :n "SPC o e" 'direx:find-item
      :n "SPC o n" 'direx:find-item-other-window)

(map! :n "SPC p B" 'direx-project:jump-to-project-root)

(map! :n "SPC g h" 'git-gutter:popup-hunk)

(map! :n "SPC j b" 'sp-beginning-of-sexp)

(global-origami-mode)

(setq neo-window-fixed-size nil)
(setq neo-window-width 50)

(setq json-reformat:indent-width 4)

(setq doom-font (font-spec :family "Inconsolata" :size 16))

(setq ewal-use-built-in-always-p nil
      ewal-use-built-in-on-failure-p t
      ewal-force-tty-colors-in-daemon-p t
      ewal-built-in-palette "sexy-material")

(setq evil-auto-balance-windows nil)

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(setq ewal-doom-one-brighter-modeline t)

(setq org-log-into-drawer t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-idle-time 15)

(map! :map org-mode-map
      :n "SPC m c t t" 'org-timer
      :n "SPC m c t s" 'org-timer-start
      :n "SPC m c t c" 'org-timer-set-timer
      :n "SPC m c t S" 'org-timer-stop
      :n "SPC m c t p" 'org-timer-pause-or-continue
      :n "SPC m c t i" 'org-timer-item
      :n "SPC m c u" 'org-clock-update-time-maybe)

(setq select-enable-clipboard t)

(zoom-mode 1)

(set-variable 'zoom-size '(0.618 . 0.618))

(set-face-attribute 'mode-line nil :background "#458588" :foreground "#fbf1c7")
(set-face-attribute 'mode-line-inactive nil :background "#458588" :foreground "#282828")
(set-face-attribute 'doom-modeline-buffer-path nil :foreground "#fbf1c7")
(set-face-attribute 'doom-modeline-project-dir nil :foreground "#fbf1c7")
(set-face-attribute 'doom-modeline-buffer-file nil :foreground "#fbf1c7")
(set-face-attribute 'doom-modeline-info nil :foreground "#fbf1c7")
(set-face-attribute 'doom-modeline-buffer-major-mode nil :foreground "#fbf1c7")

;; I can't figure out how to get Firefox not to create a new instance when I
;; open a URL from Emacs.
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

(load-theme 'doom-gruvbox t)
