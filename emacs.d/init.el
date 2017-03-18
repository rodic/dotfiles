(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Hide startup screen
(setq inhibit-startup-screen t)

;; Start in max size
(toggle-frame-maximized)

;; Start multi term in right window
(multi-term)
(split-window-right)
(other-window 0)

;; Hide menu bar
(menu-bar-mode -1)

;; Increase font size
(set-face-attribute 'default (selected-frame) :height 120)

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
