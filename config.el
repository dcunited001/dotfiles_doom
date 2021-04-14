;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/config.el

(setq user-full-name "David Conner"
      user-mail-address "number8@fantasyfarm.com")

(setq doom-theme 'doom-one)
;;;fdsafdas

(set-frame-font "Source Code Pro 12" nil t)

(setq window-divider-default-right-width 3)
(setq window-divider-default-bottom-width 3)

(require 'iso-transl)

(setq display-line-numbers-type t)

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\|git\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq explicit-shell-file-name "/bin/zsh")

(setq org-directory "/data/org")

(after! org
  (setq org-log-done 'time
        ;;org-agenda-files (concat (file-name-as-directory org-directory) "agenda.org")
   ))

(setq mouse-wheel-progressive-speed nil)

(map! "<mouse-8>" 'projectile-find-file)
(map! "<mouse-9>" 'projectile-grep)
(map! "C-M-<mouse-8>" '+workspace/switch-left)
(map! "C-M-<mouse-9>" '+workspace/switch-right)
(map! "C-<mouse-8>" '+ivy/switch-workspace-buffer)
(map! "C-<mouse-9>" 'counsel-projectile-switch-project)
(map! "M-<mouse-8>" 'doom/save-session)
(map! "M-<mouse-9>" 'doom/load-session)
(map! "M-S-<mouse-8>" 'winner-undo)
(map! "M-S-<mouse-9>" 'winner-redo)
(map! "S-<mouse-8>" 'previous-buffer)
(map! "S-<mouse-9>" 'next-buffer)

(put 'dockerfile-image-name 'safe-local-variable #'stringp)

;; from HaoZeke/dotdoom
(use-package! highlight-doxygen
  :hook ((c-mode c++-mode) . highlight-doxygen-mode))

;; from HaoZeke/dotdoom
(setq auto-mode-alist (append '(
                                ("\\.C$" . c++-mode)
                                ("\\.cc$" . c++-mode)
                                ("\\.cpp$" . c++-mode)
                                ("\\.inl$" . c++-mode)
                                ("\\.H$" . c++-mode)
                                ("\\.hh$" . c++-mode)
                                ("\\.hpp$" . c++-mode)
                                )
                              auto-mode-alist))
