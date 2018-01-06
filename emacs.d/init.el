;; Cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Exec path from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Hide startup screen
(setq inhibit-startup-screen t)

;; Start in max size
(toggle-frame-maximized)

;; Start multi term in right window
(defvar multi-term-program)
(setq multi-term-program "/bin/zsh")
(multi-term)
(split-window-right)
(other-window 0)

;; Hide menu bar
(menu-bar-mode -1)

;; Increase font size
(set-face-attribute 'default (selected-frame) :height 140)

;; Show line numbers
(defvar linum-format)
(setq linum-format "%3d ")
(global-linum-mode t)

;; Show column numbers
(setq column-number-mode t)

;; Setup indentation
(defvar js-indent-level)
(defvar typescript-indent-level)
(setq js-indent-level 2)
(setq typescript-indent-level 2)

;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Append new line
(setq require-final-newline 'visit-save)
(setq mode-require-final-newline 'visit-save)

;; Cut line or region
(defun cut-line-or-region()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position) (line-beginning-position 2))))

(global-set-key [remap kill-region] 'cut-line-or-region)

;; Copy line or region
(defun copy-line-or-region()
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position) (line-beginning-position 2))))

;; Delete selected region
(delete-selection-mode t)

;; Drag stuff
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Flycheck
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; Ido mode
(ido-mode t)

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Projectile
(projectile-mode)

;; Helm projectile
(require 'helm-projectile)
(helm-projectile-on)

;; Smart parens
(require 'smartparens-config)
(smartparens-mode t)
(show-smartparens-mode t)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(add-hook 'tide-mode-hook 'smartparens-mode)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Solarized theme
(load-theme 'solarized-dark t)

;; Setup tide
(defvar flycheck-check-syntax-automatically)
(defvar company-tooltip-align-annotations)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)

(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Highlight brackets
(show-paren-mode t)

;; Web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun setup-web-mode ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
)
(add-hook 'web-mode-hook  'setup-web-mode)

;; Backups
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)
