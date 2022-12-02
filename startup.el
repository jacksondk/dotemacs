;; Required variables
;;   org-directory => eg c:\sync\orgmode

(require 'package)

;; Do not show the 'splash screen'
(setq inhibit-startup-message t
      visible-bell t
      magit-push-current-set-remote-if-missing t
      column-number-mode t
      )

;; getting rid of the "yes or no" prompt and replace it with "y or n"
(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-16le)

(setq-default indent-tabs-mode nil)

;; Setup the spelling checker using the spell.bat file in bin
;; Currently it forwards the request to wsl hunspell
(setq ispell-program-name "c:/bin/spell.bat")
(setq ispell-dictionary "en_US")
(setq ispell-hunspell-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "en_US") nil utf-8)))

;; Use a more modern font - size 11 to make it more readable to my old
;; eyes.
(set-face-attribute 'default nil :font "CaskaydiaCove NF-11")

;;backup directory
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/emacs_backup")))

;; https://www.emacswiki.org/emacs/BrowseUrl#h5o-21
(defun browse-url-edge (url &optional new-window)
  "Open using shell command start"
  (interactive)
  (let (cmd)
    (message url)
    (setq cmd (format "start msedge \"\" \"%s\"" url))
    (message cmd)
    (shell-command cmd)
    )
  )

(setq browse-url-browser-function 'browse-url-edge)

;; Open a devops "link" such as AB#530 - however, it only look for the
;; number below the pointer
(defun open-devops ()
  "Open a AB#??? link as work item in Azure Boards"
  (interactive)
  (let (curWord issueNumber link)
    (with-syntax-table (standard-syntax-table)
      (setq curWord (thing-at-point 'word))
      (message curWord)
      (setq link (concat "https://dev.azure.com/iqinabox/Crown Data/_workitems/edit/" curWord))
      (message link)
      (browse-url-edge link)
      ))
  )

;; No tool bar
(tool-bar-mode -1)
(load-theme 'deeper-blue t)

;; Add a package achieve
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;; Remap C-z to undo - do not need to minimize 
(global-set-key (kbd "C-z") 'undo)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

;; (use-package projectile
;; 	     :ensure t
;; 	     :init
;; 	     (projectile-mode +1)
;; 	     :config
;; 	     (setq projectile-project-search-path '("c:/Work/IQinABox"))
;; 	     :bind (:map projectile-mode-map
;; 			 ("s-p" . projectile-command-map)
;; 			 ("C-c p" . projectile-command-map)))
;; Ivy and friends setup from
;; https://www.reddit.com/r/emacs/comments/910pga/tip_how_to_use_ivy_and_its_utilities_in_your/
(use-package which-key
  :ensure t
  :config (which-key-mode)
  )

(use-package ivy
  :ensure t
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode 1))


(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))

;; Fancy searching in file
(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; Toggle a file tree 
(use-package treemacs
  :ensure t
  :bind (("<f8>" . treemacs))
  )

;; Jump between 'windows' 
(use-package ace-window
  :ensure t
  :bind (
	 ("M-o" . ace-window))
  )

(use-package magit
  :ensure t
  :custom
  ;; Allow magit-list-repositories to find them
  (magit-repository-directories
   '(
     ("c:/work/IQinAbox" . 1)
     )
   )
  )

(use-package rg
  :ensure t
  )

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Set org-agenda-files to a list of one element
(setq org-agenda-files (cons org-directory ()))
(setq org-capture-templates
      '(    
        ("w" "Work Log Entry"
         entry (file+olp+datetree "work-journal.org")
         "* %?"
         :empty-lines 0)
	("p" "Private Journal"
	 entry (file+olp+datetree "private-journal.org")
	 "* %?"
	 :empty-lines 0)
	)
      )
(setq org-log-done 'time)

(global-set-key (kbd "C-c C") 'org-capture)

;; Select a range and presss C-S-s C-S-s to enable multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-s C-S-s" . 'mc/edit-lines))
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(multiple-cursors docker treemacs projectile use-package counsel csharp-mode magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
