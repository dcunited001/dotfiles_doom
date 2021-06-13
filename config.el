;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;; ~/.doom.d/config.el
(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

;; Fixes problems with dead keys
(require 'iso-transl)

;; TODO clojurescript hook
;; TODO this may need to be set before lispy loads....
(setq lispy-compat '(cider edebug))

(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(8)
      mouse-drag-and-drop-region t)

;; TODO: misc subdir & project-level shortcuts (died,project)

;; for now, simply back/forward buffer ;; TODO: change =forward= to bufler or emacs-tab bar?
(map! "S-<mouse-8>" 'previous-buffer)
;; TODO something else: (map! "S-<mouse-9>" 'next-buffer)

(map! "<mouse-8>" '+fold/toggle)
(map! "<mouse-9> " 'er/expand-region)
(map! "S-<mouse-9> " 'er/contract-region)

;; (map! "<mouse-8>" 'counsel-grep-or-swiper)
;; (map! "<mouse-9> " 'swiper-all-buffer-p)
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

(map! "<mouse-12>" 'origami-toggle-node)
(map! "C-<mouse-12>" 'origami-open-node-recursively)
(map! "C-S-<mouse-12>" 'origami-close-node-recursively)

(map! "M-<mouse-12>" 'origami-forward-fold)
(map! "S-<mouse-12>" 'origami-backward-fold-same-level)
(map! "M-S-<mouse-12>" 'origami-forward-fold-same-level)

(map! "C-M-<mouse-12>" 'origami-close-all-nodes)
(map! "C-M-S-<mouse-12>" 'origami-open-all-nodes)

;; (map! "M-S-<mouse-12>" 'origami-show-only-node)

(map! "M-<mouse-14>" 'which-key-show-major-mode)

(let* ((themes-ilike '(doom-one doom-dark+ doom-acario-dark doom-molokai))
       (random-theme (nth (random (length themes-ilike)) themes-ilike)))
  (setq doom-theme random-theme))

(setq doom-one-brighter-modeline t)

;; (setq doom-theme 'doom-acario-dark
;;   doom-acario-dark-brighter-comments nil
;;   doom-acario-dark-brighter-modeline t
;;   doom-acario-dark-comment-bg nil
;;   doom-acario-dark-padded-modeline 4)

;; (set-frame-font "Source Code Pro 12" nil t)
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 16)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 16)
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

(use-package! origami
  :config (map! :map origami-mode-map
                :prefix "C-c C-f"
                "C-f" #'origami-toggle-node
                "C-u" #'origami-open-node-recursively
                "C-c" #'origami-close-node-recursively
                "C-a C-r" #'origami-reset
                "C-a C-f" #'origami-close-all-nodes
                "C-a C-u" #'origami-open-all-nodes)

  (defvar ap/org-super-agenda-auto-show-groups
    '("Schedule" "Bills" "Priority A items" "Priority B items"))

  (defun ap/org-super-agenda-origami-fold-default ()
    "Fold certain groups by default in Org Super Agenda buffer."
    (forward-line 3)
    (cl-loop do (origami-forward-toggle-node (current-buffer) (point))
             while (origami-forward-fold-same-level (current-buffer) (point)))
    (--each ap/org-super-agenda-auto-show-groups
      (goto-char (point-min))
      (when (re-search-forward (rx-to-string `(seq bol " " ,it)) nil t)
        (origami-show-node (current-buffer) (point)))))

  ;; :hook ((org-agenda-mode . origami-mode)
         ;; (org-agenda-finalize . ap/org-super-agenda-origami-fold-default))

        )

(add-hook 'doom-init-ui-hook
          (lambda ()
            (global-origami-mode +1)))

(use-package! centered-cursor-mode ;: defer t
  :config (map! :leader :desc "Toggle Centered Cursor"
                "t-" (λ! () (interactive) (centered-cursor-mode 'toggle))))

(setq dc/snippets (expand-file-name (concat doom-private-dir "snippets")))

(eval-after-load 'yasnippet
  (lambda ()
    (add-to-list 'yas-snippet-dirs 'dc/snippets)
    (message "loading dc/snippets")
    (yas-load-directory dc/snippets t)))

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

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
      +org-capture-journal-file (concat (file-name-as-directory org-directory) "journal.org")
      org-calendars-directory (concat  (file-name-as-directory org-directory) "calendars"))

(after! org
  (remove-hook 'after-save-hook #'+literate|recompile-maybe))

(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 3))
        (nil . (:maxlevel . 3)))

      org-refile-use-outline-path t
      org-refile-allow-creating-parent-nodes 'confirm
      org-refile-use-cache t)

(unless (boundp 'org-refile-cache-timer)
  (run-with-idle-timer 300 t (lambda ()
                               (org-refile-cache-clear)
                               (org-refile-get-targets)))
  (setq org-refile-cache-timer t))

;; TODO consider using =org-refile-target-verify-function
;; to filter subtrees marked "done" from being org-refile-targets
;; (source: mwfogleman/englehorn)

(setq org-clock-auto-clockout-timer 300
      ;; org-clock-idle-time 3
        )
(org-clock-auto-clockout-insinuate)

(use-package! org-super-agenda
  :init (setq org-super-agenda-groups
                '((:name "Today"
                   :time-grid t
                   :todo "Today")
                  (:habit t)
                  (:name "Due today"
                   :deadline today)
                  (:name "Overdue"
                   :deadline past)
                  (:name "Due soon"
                   :deadline future)
                  (:name "Important"
                   :priority "A")
                  (:priority<= "B"
                   :order 1)
                  ))
  :config (org-super-agenda-mode))





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

(use-package! elisp-depmap
  :bind (("C-c M-d" . elisp-depmap-graphviz-digraph)
         ("C-c M-g" . elisp-depmap-graphviz)
         ("C-c M-s" . elisp-depmap-makesummarytable))
  :config (setq elisp-depmap-exec-file (getenv "GRAPHVIZ_DOT")))

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

(let ((bindings '(("g" "edebug-go-mode" "Modes") ("SPC" "edebug-step-mode" "Modes") ("t" "edebug-trace-mode" "Modes") ("c" "edebug-continue-mode" "Modes") ("G" "edebug-Go-nonstop-mode" "Modes") ("T" "edebug-Trace-fast-mode" "Modes") ("C" "edebug-Continue-fast-mode" "Modes") ("n" "edebug-next-mode" "Modes") ("I" "edebug-set-initial-mode" "Modes") ("S" "edebug-stop" "Jumping") ("h" "edebug-goto-here" "Jumping") ("f" "edebug-forward-sexp" "Jumping") ("o" "edebug-step-out" "Jumping") ("i" "edebug-step-in" "Jumping") ("?" "edebug-help" "Misc") ("Q" "edebug-top-level-nonstop" "Misc") ("r" "edebug-previous-result" "Misc") ("d" "edebug-pop-to-backtrace" "Misc") ("=" "edebug-display-freq-count" "Misc") ("b" "edebug-set-breakpoint" "Breaks") ("B" "edebug-next-breakpoint" "Breaks") ("u" "edebug-unset-breakpoint" "Breaks") ("U" "edebug-unset-breakpoints" "Breaks") ("D" "edebug-toggle-disable-breakpoint" "Breaks") ("x" "edebug-set-conditional-breakpoint" "Breaks") ("X" "edebug-set-global-break-condition" "Breaks") ("v" "edebug-view-outside" "Views") ("P" "edebug-bounce-point" "Views") ("w" "edebug-where" "Views") ("W" "edebug-toggle-save-windows" "Views") ("e" "edebug-eval-expression" "Eval") ("C-x C-e" "edebug-eval-last-sexp" "Eval") ("E" "edebug-visit-eval-list" "Eval") ("C-j" "edebug-eval-print-last-sexp" "Eval") ("C-c C-u" "edebug-update-eval-list" "Eval") ("C-c C-d" "edebug-delete-eval-item" "Eval") ("C-c C-w" "edebug-where" "Eval"))))
(eval
 (append
  '(defhydra dchydra/edebug-cheat-sheet (:hint nil :foreign-keys run)
     ("C-<mouse-14>" nil "Exit" :exit t))
  (cl-loop for x in bindings
           unless (string= "" (elt x 2))
           collect
           (list (car x)
                 (intern (elt x 1))
                 ;; edebug-(?:eval-)?\(.+)
                 (when (string-match "edebug-\\(.+\\)"
                                     (elt x 1))
                   (match-string 1 (elt x 1)))
                 :column
                 (elt x 2)))))

(with-eval-after-load "edebug"
  (define-key edebug-mode-map (kbd "C-<mouse-14>") 'dchydra/edebug-cheat-sheet/body))
(with-eval-after-load "debugger"
  (define-key debugger-mode-map (kbd "C-<mouse-14>") 'dchydra/edebug-cheat-sheet/body))

)

(let ((bindings '(("<" "lispy-barf" "") ("A" "lispy-beginning-of-defun" "") ("j" "lispy-down" "") ("Z" "lispy-edebug-stop" "") ("B" "lispy-ediff-regions" "") ("G" "lispy-goto-local" "") ("h" "lispy-left" "") ("N" "lispy-narrow" "") ("y" "lispy-occur" "") ("o" "lispy-other-mode" "") ("J" "lispy-outline-next" "") ("K" "lispy-outline-prev" "") ("P" "lispy-paste" "") ("l" "lispy-right" "") ("I" "lispy-shifttab" "") (">" "lispy-slurp" "") ("SPC" "lispy-space" "") ("xB" "lispy-store-region-and-buffer" "") ("u" "lispy-undo" "") ("k" "lispy-up" "") ("v" "lispy-view" "") ("V" "lispy-visit" "") ("W" "lispy-widen" "") ("D" "pop-tag-mark" "") ("x" "see" "") ("L" "unbound" "") ("U" "unbound" "") ("X" "unbound" "") ("Y" "unbound" "") ("H" "lispy-ace-symbol-replace" "Edit") ("c" "lispy-clone" "Edit") ("C" "lispy-convolute" "Edit") ("n" "lispy-new-copy" "Edit") ("O" "lispy-oneline" "Edit") ("r" "lispy-raise" "Edit") ("R" "lispy-raise-some" "Edit") ("\\" "lispy-splice" "Edit") ("S" "lispy-stringify" "Edit") ("i" "lispy-tab" "Edit") ("xj" "lispy-debug-step-in" "Eval") ("xe" "lispy-edebug" "Eval") ("xT" "lispy-ert" "Eval") ("e" "lispy-eval" "Eval") ("E" "lispy-eval-and-insert" "Eval") ("xr" "lispy-eval-and-replace" "Eval") ("p" "lispy-eval-other-window" "Eval") ("q" "lispy-ace-paren" "Move") ("z" "lispy-knight" "Move") ("s" "lispy-move-down" "Move") ("w" "lispy-move-up" "Move") ("t" "lispy-teleport" "Move") ("Q" "lispy-ace-char" "Nav") ("-" "lispy-ace-subword" "Nav") ("a" "lispy-ace-symbol" "Nav") ("b" "lispy-back" "Nav") ("d" "lispy-different" "Nav") ("f" "lispy-flow" "Nav") ("F" "lispy-follow" "Nav") ("g" "lispy-goto" "Nav") ("xb" "lispy-bind-variable" "Refactor") ("xf" "lispy-flatten" "Refactor") ("xc" "lispy-to-cond" "Refactor") ("xd" "lispy-to-defun" "Refactor") ("xi" "lispy-to-ifs" "Refactor") ("xl" "lispy-to-lambda" "Refactor") ("xu" "lispy-unbind-variable" "Refactor") ("M" "lispy-multiline" "Other") ("xh" "lispy-describe" "Other") ("m" "lispy-mark-list" "Other"))))
(eval
 (append
  '(defhydra dchydra/lispy-cheat-sheet (:hint nil :foreign-keys run)
     ("C-<mouse-14>" nil "Exit" :exit t))
  (cl-loop for x in bindings
           unless (string= "" (elt x 2))
           collect
           (list (car x)
                 (intern (elt x 1))
                 (when (string-match "lispy-\\(?:eval-\\)?\\(.+\\)"
                                     (elt x 1))
                   (match-string 1 (elt x 1)))
                 :column
                 (elt x 2)))))

(with-eval-after-load "lispy"
  (define-key lispy-mode-map (kbd "C-<mouse-14>") 'dchydra/lispy-cheat-sheet/body))

)
