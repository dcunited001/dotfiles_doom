;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/config.el

(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

(setq doom-theme 'doom-acario-dark
      doom-acario-dark-brighter-comments nil
      doom-acario-dark-brighter-modeline t
      doom-acario-dark-comment-bg nil
      doom-acario-dark-padded-modeline 4)

(set-frame-font "Source Code Pro 12" nil t)

(setq +ligatures-extras-in-modes
      '(not special-mode comint-mode eshell-mode term-mode vterm-mode python-mode))

(setq window-divider-default-right-width 3)
(setq window-divider-default-bottom-width 3)

(after! treemacs
  (setq treemacs-width 24)
  (treemacs-filewatch-mode -1))

(map! :map treemacs-mode-map :after treemacs
      (:prefix "o" :desc "Tags" "t" 'treemacs-toggle-node-prefer-tag-visit))

(setq display-line-numbers-type nil)

(after! which-key
    (setq which-key-idle-delay 0.5))

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\|git\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq explicit-shell-file-name "/bin/zsh")

;; (after! org
;;   (map!

;;    ))

(after! org
  (remove-hook 'after-save-hook #'+literate|recompile-maybe))

(setq org-directory "/data/org")

(after! org
  (setq org-log-done 'time
        org-support-shift-select t
        ;;org-agenda-files (concat (file-name-as-directory org-directory) "agenda.org")
        ;; TODO include content from Adam James
        ))

;; Fixes problems with dead keys
(require 'iso-transl)

(setq mouse-wheel-progressive-speed nil)

(map! "<mouse-8>" 'projectile-find-file)
(map! "<mouse-9>" 'projectile-grep)
(map! "C-M-<mouse-8>" '+workspace/switch-left)
(map! "C-M-<mouse-9>" '+workspace/switch-right)
(map! "C-<mouse-8>" '+ivy/switch-buffer)
(map! "C-<mouse-9>" '+ivy/switch-workspace-buffer)
(map! "M-<mouse-8>" 'doom/save-session) ;; TODO: remap
(map! "M-<mouse-9>" 'doom/load-session) ;; TODO: remap
(map! "M-S-<mouse-8>" 'winner-undo) ;; TODO: remap
(map! "M-S-<mouse-9>" 'winner-redo) ;; TODO: remap
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
