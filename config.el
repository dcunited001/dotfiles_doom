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
;; (map! "M-S-<mouse-8>" 'doom/save-session) ;; TODO: remap
;; (map! "M-S-<mouse-9>" 'doom/load-session) ;; TODO: remap
(map! "M-<mouse-8>" 'better-jumper-jump-forward)
(map! "M-<mouse-9>" 'better-jumper-jump-backward)
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

(use-package! bufler
  :config (map! ;(:after ...?)
           :map ctl-x-map
           :desc "Bufler List" "C-b" #'bufler-list))
(use-package! burly)

(add-hook 'doom-init-ui-hook
          (lambda () (global-tab-line-mode +1)
            (bufler-mode +1)
            (bufler-tabs-mode +1)))

(after! treemacs
  (setq treemacs-width 24)
  (treemacs-filewatch-mode -1))

(map! :map treemacs-mode-map :after treemacs
      (:prefix "o" :desc "Tags" "t" 'treemacs-toggle-node-prefer-tag-visit))

(after! which-key
    (setq which-key-idle-delay 0.5))

(use-package! dimmer
  :config (setq dimmer-adjustment-mode :background
                dimmer-fraction 0.4)

  (dimmer-configure-company-box)
  (dimmer-configure-magit)
  (dimmer-configure-org)
  (dimmer-configure-hydra)
  (dimmer-configure-which-key)
  (dimmer-configure-posframe))

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

(setq org-edit-src-content-indentation 0)

(add-hook 'clojure-mode-hook 'zprint-mode)
(add-hook 'clojurescript-mode-hook 'zprint-mode)

(setq org-babel-clojure-backend 'cider)

;; TODO: (after! org & julia-vterm?
;;;         ...)
;; (after! org-babel ... )
;; (org-babel-make-language-alias "julia" "julia-vterm")

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

(after! org
  (add-to-list 'org-babel-load-languages
               '((julia-vterm . t)
                 (clojure . t)))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

;;(defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)

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

(use-package! prism
  :hook (emacs-lisp-mode . prism-mode)
  :config (map! :leader :desc "Toggle Prism"
                "tP" (lambda () (interactive) (prism-mode 'toggle)))

  (prism-set-colors :lightens '(0 5 10) :desaturations '(-2.5 0 2.5)
    :colors (-map #'doom-color
                  '(red green orange blue yellow violet)))
  ;; red orange green teal yellow blue dark-blue magenta violet cyan dark cyan
  )

(map! :leader :desc "Toggle Rainbow Mode"
      "tR" (lambda () (interactive) (rainbow-mode 'toggle)))


;; TODO fix to autoload rainbow-mode in doom theme files
;; (setq auto-minor-mode-alist (append '(("theme\\.el$" . rainbow-mode))
                                    ;; auto-minor-mode-alist))
