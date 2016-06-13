;; We live in an international world
(prefer-coding-system 'utf-8)

;; Disable menu and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; I prefer tabs smaller tabs
(setq tab-width 2)

;; The title of each window (emacs frame) should start 
;; with emacs
;;
;; http://www.emacswiki.org/emacs/FrameTitle
(setq frame-title-format '"emacs - %b")

;; Set my prefered c indentation style
(setq c-default-style "bsd"
      c-basic-offset 2)

;; Answer yes/no with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Please do not show version information at startup
(setq inhibit-startup-message t)

;; Where to put backups
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

;; Make a function that moves to beginning of line
;; Visual Studio Style, that is
;;
;;  - move to the first non-white character if we are not on there now
;;  - otherwise, move to the first column
;; 
(defun dev-studio-beginning-of-line (arg)
  "Moves to beginning of line VS style"
  (interactive "p")
  (if (and (looking-at "^") (= arg 1)) 
      (skip-chars-forward " \t") 
    (move-beginning-of-line arg)
    )
  )

;; Rebind \C-a and home to above command
(global-set-key "\C-a" 'dev-studio-beginning-of-line)
(global-set-key [home] 'dev-studio-beginning-of-line)

;; In Python I prefer 4 spaces as indentation
(add-hook 'python-mode-hook
	  (lambda()
	    (set-variable 'py-indent-offset 4)
	    )
	  )

(setq w32-get-true-file-attributes nil)

;; http://tex.stackexchange.com/questions/21200/auctex-and-xetex
;; Setup AUX tex
(setq TeX-engine 'xetex)
(setq TeX-PDF-mode t)
;;set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook (lambda()
(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
(setq TeX-command-default "XeLaTeX")
(setq TeX-save-query nil)
(setq TeX-show-compilation t)))


(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(font-lock-mode t)
(setq initial-scratch-message "MJ setup done")
