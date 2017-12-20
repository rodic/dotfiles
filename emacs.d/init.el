(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; include paths from shell
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

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

;; Delete selected region
(delete-selection-mode t)

;; Highlight brackets
(show-paren-mode t)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Init multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

;; Init solarized
(load-theme 'solarized-dark t)

;; Init projectile
(projectile-mode)

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

;; Init rainbow
(rainbow-mode)

;; Flycheck
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; Backups
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)
