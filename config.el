;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;; ~/.doom.d/config.el
(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

;; Fixes problems with dead keys
(require 'iso-transl)

;; TODO clojurescript hook
;; TODO this may need to be set before lispy loads....
(setq lispy-compat '(cider edebug))

(setq mouse-wheel-progressive-speed nil)

;; TODO: misc subdir & project-level shortcuts (dired,project)

;; for now, simply back/forward buffer ;; TODO: change =forward= to bufler or emacs-tab bar?
(map! "S-<mouse-8>" 'previous-buffer)
;; TODO something else: (map! "S-<mouse-9>" 'next-buffer)

(map! "<mouse-8>" 'counsel-grep-or-swiper)
(map! "<mouse-9> " 'swiper-all-buffer-p)
;; (map! "C-<mouse-8>" '+ivy/switch-buffer)
;; (map! "C-<mouse-9>" '+ivy/switch-workspace-buffer)
(map! "C-S-<mouse-8>" 'projectile-find-file)
(map! "C-S-<mouse-9>" 'projectile-grep)

;; (map! "C-M-<mouse-8>" '+workspace/switch-right)
;; (map! "C-M-<mouse-9>" '+workspace/switch-right)
;; (map! "M-S-<mouse-8>" 'doom/save-session) ;; TODO: remap
;; (map! "M-S-<mouse-9>" 'doom/load-session) ;; TODO: remap
;; (map! "M-<mouse-8>" 'better-jumper-jump-backward)

;; TODO: something else (map! "M-<mouse-9>" 'better-jumper-jump-backward)

(setq doom-theme 'doom-one
      doom-one-brighter-modeline t)

;; (setq doom-theme 'doom-acario-dark
;;   doom-acario-dark-brighter-comments nil
;;   doom-acario-dark-brighter-modeline t
;;   doom-acario-dark-comment-bg nil
;;   doom-acario-dark-padded-modeline 4)

;; (set-frame-font "Source Code Pro 12" nil t)
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 14)
      doom-font-increment 1)

(unless (find-font doom-font)
  (message "couldn't find 'doom-font. using a default.")
  (setq doom-font (font-spec :family "Source Code Pro" :size 18)))

(unless (find-font doom-unicode-font)
  (message "couldn't find 'doom-unicode-font. using a default.")
  (setq doom-unicode-font (font-spec :family "Source Code Pro" :size 18)))

(setq +ligatures-extras-in-modes
      '(not special-mode comint-mode eshell-mode term-mode vterm-mode python-mode))

(setq window-divider-default-right-width 1)
(setq window-divider-default-bottom-width 1)

(menu-bar-mode +2)

(use-package! auto-highlight-symbol
  ;; should autoload on bind
  :config (map! (:prefix "M-s h" :desc "auto-highlight-mode"
                 "A" (lambda () (interactive) (auto-highlight-symbol-mode 'toggle)))))

(use-package! treemacs-all-the-icons)

(add-hook 'doom-init-ui-hook
          (lambda () (treemacs-load-theme "Default")))

(after! treemacs
  (setq treemacs-width 24)
  (treemacs-filewatch-mode -1))

(map! :map treemacs-mode-map :after treemacs
      (:prefix "o" :desc "Tags" "t" 'treemacs-toggle-node-prefer-tag-visit))

(after! which-key
    (setq which-key-idle-delay 0.5))

(after! doom-modeline
  ;; doom-modeline workspace-name has conflicts with bufler tab-bar
  (setq doom-modeline-workspace-name nil

        doom-modeline-height 24
        ;; doom-modeline-project-detection 'ffip,'projectile,'projectile
        doom-modeline-minor-modes t))

(use-package! dimmer
  :config (setq dimmer-adjustment-mode :background
                dimmer-fraction 0.4)

  (dimmer-configure-company-box)
  (dimmer-configure-magit)
  (dimmer-configure-org)
  (dimmer-configure-hydra)
  (dimmer-configure-which-key)
  (dimmer-configure-posframe))

(use-package! burly
  :config (map! :leader
                (:prefix ("w" . "workspaces/windows")
                  (:prefix ("B" . "Burly bookmarks")
                   :desc "Restore windows/frames" "o" #'burly-open-bookmark
                   :desc "Open Burly URL" "O" #'burly-open-url
                   :desc "Bookmark Windows" "w" #'burly-bookmark-windows
                   :desc "Bookmark Frameset" "f" #'burly-bookmark-frames
                   :desc "Copy Buffer URL" "B" #'burly-kill-buffer-url
                   :desc "Copy Window URL" "F" #'burly-kill-frames-url
                   :desc "Copy Frameset URL" "W" #'burly-kill-windows-url))))

(setq display-line-numbers-type nil)

(use-package! centered-cursor-mode ;: defer t
  :config (map! :leader :desc "Toggle Centered Cursor"
                "t-" (λ! () (interactive) (centered-cursor-mode 'toggle))))

(setq dc/snippets (expand-file-name (concat doom-private-dir "snippets")))

(eval-after-load 'yasnippet
  (lambda ()
    (add-to-list 'yas-snippet-dirs 'dc/snippets)
    (message "loading snippets")
    (message dc/snippets)
    (yas-load-directory dc/snippets t)))

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\|git\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq explicit-shell-file-name "/bin/zsh")

(use-package! info-colors)

(use-package! magit-tbdiff)

(use-package! repo)

(use-package! firestarter
  :init (firestarter-mode)
  :config (setq firestarter-default-type t))

(use-package! pkgbuild-mode :mode "\\PKGBUILD")

(use-package! crontab-mode)

(use-package! ssh-config-mode)
(use-package! x509-mode)

(use-package! docker
  :config (setq docker-run-as-root t
                docker-image-run-arguments '("-i" "-t" "--rm")))

;; so the ## -*- docker-image-name: "image-name" -*- directive works with ~dockerfile-mode~
;; TODO assess
(put 'dockerfile-image-name 'safe-local-variable #'stringp)

(use-package salt-mode)

(setq lsp-ui-peek-list-width 25
      ;; lsp-ui-sideline--last-width

      ;; TODO ensure these are necessary/useful
      lsp-ui-doc-max-width 35 ;; 35 is default
      ;; lsp-ui-doc--inline-width

      lsp-ui-imenu-window-width 25)

(setq org-directory (getenv "ORG_DIRECTORY")
      +org-capture-journal-file "/data/org/journal.org")

(after! org
  (remove-hook 'after-save-hook #'+literate|recompile-maybe))

(setq org-refile-use-cache t
      org-refile-use-outline-path t)

(unless org-refile-cache-timer
  (run-with-idle-timer 300 t (lambda ()
                               (org-refile-cache-clear)
                               (org-refile-get-targets)))
  (setq org-refile-cache-timer t))

;; TODO consider using =org-refile-target-verify-function
;; to filter subtrees marked "done" from being org-refile-targets
;; (source: mwfogleman/englehorn)







(setq org-edit-src-content-indentation 0)

(use-package! org-treeusage
  :bind ("C-c d" . org-treeusage-mode)
  :config (setq org-treescope-overlay-header nil
                org-treeusage-overlay-usecolorbands nil))

(use-package! org-drill
  :after org
  :config (progn
            (setq org-drill-add-random-noise-to-intervals-p t)
            (setq org-drill-hint-separator "||")
            (setq org-drill-left-cloze-separator "<[")
            (setq org-drill-left-cloze-separator "]>")
            (setq org-drill-learn-fraction 0.25))
  )

(add-hook 'clojure-mode-hook 'zprint-mode)
(add-hook 'clojurescript-mode-hook 'zprint-mode)

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

(use-package! openapi-yaml-mode)

(use-package! graphql)
(use-package! graphql-mode)
(use-package ob-graphql)

(after! org
  (add-to-list 'org-babel-load-languages
               '((julia-vterm . t)
                 (clojure . t)
                 (dot . t)))
  (org-babel-do-load-languages
   'org-babel-load-languages
   org-babel-load-languages))
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
  :hook ((emacs-lisp-mode . prism-mode)
         (clojure-mode . prism-mode)
         (clojurescript-mode . prism-mode))
  :config (map! :leader :desc "Toggle Prism"
                "tP" (lambda () (interactive) (prism-mode 'toggle)))

  (prism-set-colors :lightens '(0 5 10) :desaturations '(-2.5 0 2.5)
    :colors (-map #'doom-color
                  '(red teal green magenta cyan blue orange dark-cyan violet yellow)))
                  ;; options: red orange green teal yellow blue dark blue magenta violet cyan dark cyan
  )

(map! :leader :desc "Toggle Rainbow Mode"
      "tR" (lambda () (interactive) (rainbow-mode 'toggle)))


;; TODO fix to autoload rainbow-mode in doom theme files
;; (setq auto-minor-mode-alist (append '(("theme\\.el$" . rainbow-mode))
                                    ;; auto-minor-mode-alist))

digraph {
        rankdir=LR;
        splines=true;
        node [shape=box];

        A [label="A"]
        B [label="B"]
        C [label="C"]

        A -> B;
        B -> C;
        C -> A;
}
