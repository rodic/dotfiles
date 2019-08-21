(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Exec path from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Hide startup screen
(setq inhibit-startup-screen t)

;; Start in max size
(toggle-frame-maximized)

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

;; Multiterm
(defvar multi-term-program)
(setq multi-term-program "/bin/zsh")

;; Ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c ss") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Drag stuff
(drag-stuff-mode t)
(drag-stuff-define-keys)

;; Append new line
(setq require-final-newline 'visit-save)
(setq mode-require-final-newline 'visit-save)

;; Delete selected region
(delete-selection-mode t)

;; Flycheck
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Projectile
(projectile-mode +1)
(counsel-projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Smart parens
(require 'smartparens-config)
(smartparens-mode t)
(show-smartparens-mode t)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(add-hook 'tide-mode-hook 'smartparens-mode)

;; Theme
(load-theme 'brin t)

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
