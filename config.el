;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/config.el
(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

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

(setq doom-theme 'doom-one)

;; (setq doom-theme 'doom-acario-dark
;;   doom-acario-dark-brighter-comments nil
;;   doom-acario-dark-brighter-modeline t
;;   doom-acario-dark-comment-bg nil
;;   doom-acario-dark-padded-modeline 4)

(set-frame-font "Source Code Pro 12" nil t)

(setq +ligatures-extras-in-modes
      '(not special-mode comint-mode eshell-mode term-mode vterm-mode python-mode))

(setq window-divider-default-right-width 1)
(setq window-divider-default-bottom-width 1)

(after! treemacs
  (setq treemacs-width 24)
  (treemacs-filewatch-mode -1))

(map! :map treemacs-mode-map :after treemacs
      (:prefix "o" :desc "Tags" "t" 'treemacs-toggle-node-prefer-tag-visit))

(after! which-key
    (setq which-key-idle-delay 0.5))

(setq display-line-numbers-type nil)

(use-package! centered-cursor-mode ;: defer t
  :config (map! :leader :desc "Toggle Centered Cursor"
                "t-" (λ! () (interactive) (centered-cursor-mode 'toggle))))

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\|git\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq explicit-shell-file-name "/bin/zsh")

(put 'dockerfile-image-name 'safe-local-variable #'stringp)

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

(use-package! google-translate :demand t
  :init (require 'google-translate)
  :functions (my-google-translate-at-point google-translate--search-tkk)
  :custom (google-translate-backend-method 'curl)
  :config
  (defun google-translate--search-tkk ()
    "Search TKK."
    (list 430675 2721866130))
  (defun my-google-translate-at-point ()
    "reverse translate if prefix"
    (interactive)
    (if current-prefix-arg
        (google-translate-at-point)
      (google-translate-at-point-reverse)))
  :bind
  ;;("C-T". my-google-translate-at-point)
)

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
