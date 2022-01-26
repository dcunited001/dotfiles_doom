;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;* ~/.doom.d/config.el
(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

;; [[file:config.org::*Input Configs][Input Configs:1]]
;;** INPUT

;; Fixes problems with dead keys
(require 'iso-transl)

;;*** Point Movements

;;*** Lispy
(setq lispy-compat '(cider edebug))
(after! lispy
  (map! (:map lispy-mode-map
         "M-." #'+lookup/definition
         "M-," #'better-jumper-jump-backward)))

;;*** Mouse

(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(8)
      mouse-drag-and-drop-region t)

;;*** Experimental Mouse

;;**** Razor (previous/next)
;; for now, simply back/forward buffer
;; TODO: change =forward= to bufler or emacs-tab bar?
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

;;**** Origami

(map! "<mouse-12>" 'origami-toggle-node)
(map! "C-<mouse-12>" 'origami-open-node-recursively)
(map! "C-S-<mouse-12>" 'origami-close-node-recursively)

(map! "M-<mouse-12>" 'origami-forward-fold)
(map! "S-<mouse-12>" 'origami-backward-fold-same-level)
(map! "M-S-<mouse-12>" 'origami-forward-fold-same-level)

(map! "C-M-<mouse-12>" 'origami-close-all-nodes)
(map! "C-M-S-<mouse-12>" 'origami-open-all-nodes)

;; (map! "M-S-<mouse-12>" 'origami-show-only-node)

;;**** Hydras

(map! "M-<mouse-14>" 'which-key-show-major-mode)
;; Input Configs:1 ends here

;; [[file:config.org::*Completion Configs][Completion Configs:1]]
;;** COMPLETION
;; Completion Configs:1 ends here

;; [[file:config.org::*UI Configs][UI Configs:1]]
;;** UI

;;*** Diminish
;; should probably be loaded before :diminish directives
(use-package! diminish
 :ensure t)

;;*** Doom Theme
;; Pick a random theme from the ones I like.
(let* ((themes-ilike '(doom-one doom-dark+ doom-acario-dark doom-molokai modus-vivendi))
       (random-theme (nth (random (length themes-ilike)) themes-ilike)))
  (setq doom-theme random-theme))

;; NOTE just set modus-vivendi for now
(setq doom-theme 'modus-vivendi)

;; (setq doom-theme 'doom-acario-dark
;;   doom-acario-dark-brighter-comments nil
;;   doom-acario-dark-brighter-modeline t
;;   doom-acario-dark-comment-bg nil
;;   doom-acario-dark-padded-modeline 4)

;;*** Doom Dashboard

;;*** Font
;; (set-frame-font "Source Code Pro 12" nil t)
;; Source Code Pro not available in pGTK
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Serif" :size 14)
      doom-font-increment 2)

;; (unless (find-font doom-font)
;;   (message "couldn't find 'doom-font. using a default.")
;;   (setq doom-font (font-spec :family "Source Code Pro" :size 18)))

;; (unless (find-font doom-unicode-font)
;;   (message "couldn't find 'doom-unicode-font. using a default.")
;;   (setq doom-unicode-font (font-spec :family "Source Code Pro" :size 18)))

;;*** Ligatures
;; NOTE: ligatures is inactive (as of 2022-01-24)
(setq +ligatures-extras-in-modes
      '(not special-mode
            comint-mode
            eshell-mode
            term-mode
            vterm-mode
            python-mode))

;;*** Indent Guides
;;NOTE don't use them (they're taxing)

;;*** Window UI
(tooltip-mode)

(setq tooltip-delay 2
      tooltip-short-delay 0.5)

;;*** Window Dividers
;; Dividers are too thin to grab if only 1px
;; ... but what the hell. why not?
(setq window-divider-default-right-width 1
      window-divider-default-bottom-width 1)

;;*** Menu
(menu-bar-mode +2)

;;*** Highlighting


(use-package! auto-highlight-symbol
  ;; should autoload on bind
  :config (map! (:prefix "M-s h" :desc "auto-highlight-mode"
                 "A" #'dc/toggle-auto-highlight-symbol-mode)))

;; TODO try global-auto-highlight-symbol-mode
;; doom-specific
(add-hook 'doom-init-ui-hook
          #'global-auto-highlight-symbol-mode)

(defun dc/toggle-auto-highlight-symbol-mode ()
  "Toggle auto-highlight-symbol-mode"
  (interactive)
  (auto-highlight-symbol-mode 'toggle))

(defun dc/toggle-global-auto-highlight-symbol-mode ()
  "Toggle global-auto-highlight-symbol-mode"
  (interactive)
  (global-auto-highlight-symbol-mode 'toggle))

(map! :leader
      :prefix ("t" . "toggle")
      :desc "Toggle Global Auto Highlight" "H" #'dc/toggle-global-auto-highlight-symbol-mode)

;;*** Popups

(set-popup-rules!
  '(("^\\*Bufler" :side right :width 60
     :vslot -5 :slot 3
     :modeline nil :select t :quit t)

    ;; NOTE this works, but the functionality in geiser/geiser-popup.el only covers *Geiser buffers
    ;; - so =C-`= works to toggle, but all scheme-mode functionality will send repl buffers to other-window
    ;; ("^\\* Guile REPL" :side bottom
    ;;  :vslot 3 :slot 3
    ;;  :modeline nil
    ;;  :select t :quit t)
    ))

;;*** Burly

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

;;*** Bufler
(use-package! bufler
  :config (map! :map ctl-x-map
                  :desc "Bufler List"
                  "C-b" #'bufler-list))

(add-hook 'doom-init-ui-hook
          #'bufler-mode)

;;*** Dogears
(use-package! dogears
  :config (map! :prefix "M-g"
                "d" #'dogears-go
                "M-b" #'dogears-back
                "M-f" #'dogears-forward
                "M-d" #'dogears-list
                "M-D" #'dogears-sidebar))

(add-hook 'doom-init-ui-hook
          #'dogears-mode)

;;*** Modeline
(setq +modeline-height 31)

;;*** Which Key
;(after! which-key
    (setq which-key-idle-delay 1.0)
;   )

;;*** Line Numbers
;; For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;;*** UI Alerts
(setq visible-bell t)

;;**** Beacon
;; (use-package! beacon
;;   :diminish beacon-mode
;;   :init (beacon-mode)
;;   :config (map! :leader
;;                 "tB" :desc "Beacon Mode"))

;;**** Dimmer
(use-package! dimmer
  :config (progn (setq dimmer-adjustment-mode :background
                       dimmer-fraction 0.05)
                 (map! :leader
                        "tD" :desc "Dimmer Mode"))

  (dimmer-configure-company-box)
  (dimmer-configure-magit)
  (dimmer-configure-org)
  (dimmer-configure-hydra)
  (dimmer-configure-which-key)
  (dimmer-configure-posframe))

(add-hook 'doom-init-ui-hook
          #'dimmer-mode)
;; UI Configs:1 ends here

;; [[file:config.org::*Editor Configs][Editor Configs:1]]
;;** EDITOR

;;*** Auto Insert

;; TODO determine whether auto-insert-mode is necessary
;; - esp. with doom's +file-templates module
;(auto-insert-mode)

;;*** Doom File Templates
;; TODO add new file templates to +file-template-alist where needed
;; - use set-file-template!

;;*** Code Folding

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
          #'global-origami-mode)

;;*** centered-cursor-mode

(use-package! centered-cursor-mode      ;: defer t
  :config (map! :leader
                :desc "Toggle Centered Cursor" "t-" #'dc/toggle-global-centered-cursor-mode
                :desc "Toggle Centered Cursor" "t_" #'dc/toggle-centered-cursor-mode))

(defun dc/toggle-centered-cursor-mode ()
  "Toggle centered-cursor-mode"
  (interactive)
  (centered-cursor-mode 'toggle))

(defun dc/toggle-global-centered-cursor-mode ()
  "Toggle centered-cursor-mode"
  (interactive)
  (global-centered-cursor-mode 'toggle))

;; TODO try global-centered-cursor-mode by default
;; (mostly to remind myself that it exists
(add-hook 'doom-init-ui-hook
          #'global-centered-cursor-mode)

;;*** Snippets

(setq dc/snippets (expand-file-name (concat doom-private-dir "snippets")))

(eval-after-load 'yasnippet
  (lambda ()
    (add-to-list 'yas-snippet-dirs 'dc/snippets)
    (message "loading dc/snippets")
    (yas-load-directory dc/snippets t)))
;; Editor Configs:1 ends here

;; [[file:config.org::*Emacs Config][Emacs Config:1]]
;;** EMACS

;;*** GPG

;; (setq auth-sources '("~/.authinfo" "~/.authinfo.gpg" "~/.netrc"))
;; (setq auth-sources (append `(,(concat (file-name-as-directory (getenv "DF_")) ".ectorepo.gpg")) auth-sources))

;;*** DIRED
(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

;; Remove `.` and `..` from list of omitted file patterns
;; (so i can always run commands on the directory)
(map! (:map dired-mode-map
       ;; godammit don't close all the fucking dired buffers
       "q" #'find-name-dired

       ;; ... but potentially a good idea with TRAMP ... maybe?)
       :leader :desc "Close all direds" "Q" #'+dired/quit-all))
;; Emacs Config:1 ends here

;; [[file:config.org::*Term Configs][Term Configs:1]]
;;** TERM
;; Term Configs:1 ends here

;; [[file:config.org::*Checkers Configs][Checkers Configs:1]]
;;** CHECKERS
;; Checkers Configs:1 ends here

;; [[file:config.org::*Tools Configs][Tools Configs:1]]
;;** TOOLS

;;*** INFO
(use-package! info-colors)

;;*** TLDR
(use-package! tldr
  :config (map! :leader "T" #'tldr))

;;*** EDIFF


;;*** GIT

;;*** MAGIT
;; magit-tbdiff: diff over ranges of commits
(use-package! magit-tbdiff)

;;*** FORGE


;;*** GITHUB


;;*** REPO
(use-package! repo)


;;*** SHELL
;; enables =./.dir-local.el= variables and file-local declarations to
;; config/control on-save shell tasks.[fn:haozeke]
(use-package! firestarter
  :init (firestarter-mode)
  :config (setq firestarter-default-type t))


;;*** TRAMP
(after! tramp
  (appendq! tramp-remote-path
            '("~/.guix-profile/bin" "~/.guix-profile/sbin"
              "/run/current-system/profile/bin"
              "/run/current-system/profile/sbin")))

;;*** GUIX
(use-package! guix
  :config (map! :leader "g" #'guix))

;;*** PKGBUILD (arch)
(use-package! pkgbuild-mode :mode "\\PKGBUILD")

;;*** CRON
(use-package! crontab-mode)

;;*** SSH
;; For =ssh-config-mode= add this file-local variable to configs
;; =# -*- mode: ssh-config -*-=

(use-package! ssh-config-mode)

;; TODO ssh-agency
;; TODO ssh-tunnels

;;*** X.509 certs
(use-package! x509-mode)

;;*** DOCKER
(use-package! docker
  :config (setq docker-run-as-root t
                docker-image-run-arguments '("-i" "-t" "--rm")))

;; TODO assess autoloading -*- docker-image-name: "image-name" -*-
;; (put 'dockerfile-image-name 'safe-local-variable #'stringp)

;;**** LSP DOCKER
;; this requires pulling emacslisp/lsp-docker-full

;;*** SALTSTACK
;; NOTE i'm not really using salt
;; (use-package! salt-mode)

;;*** AST
;; Tools Configs:1 ends here

;; [[file:config.org::*Lsp Configs][Lsp Configs:1]]
;;** LSP

;;*** LSP MODE

;;*** LSP UI
(setq lsp-ui-peek-list-width 25
      ;; lsp-ui-sideline--last-width

      ;; TODO ensure these are necessary/useful
      lsp-ui-doc-max-width 35 ;; 35 is default
      ;; lsp-ui-doc--inline-width

      lsp-ui-imenu-window-width 25)
;; Lsp Configs:1 ends here

;; [[file:config.org::*OS Configs][OS Configs:1]]
;;** OS
;; OS Configs:1 ends here

;; [[file:config.org::*Org Configs][Org Configs:1]]
;;** ORG

;;*** org-agenda packages


;;*** org-mode main config

(setq org-directory (getenv "ORG_DIRECTORY")
      org-calendars-directory (concat  (file-name-as-directory org-directory) "calendars")

      ;; Don't indent content in source blocks
      org-edit-src-content-indentation 0

      ;; org-clock-idle-time 3
        )


;; doom-specific: Prevent over-eager dotfiles recompilation
(after! org
  (remove-hook 'org-mode-hook #'+literate-enable-recompile-h))

(after! org
  (setq org-log-done 'time
        org-support-shift-select t
        org-agenda-files (list
                          (file-name-as-directory
                           (concat  org-directory "/roam/dailies" )))
        ;; TODO include content from Adam James
        ))

;;*** org-agenda config

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

;;**** org-clock

;; Set auto-clockout to keep time tracking accurate.
(setq org-clock-auto-clockout-timer 300)
(org-clock-auto-clockout-insinuate)

;; Insinuate means that, unless a new clocking entry occurs
;; you will auto-clockout (for inactivity)
;; Refer to [[https://orgmode.org/manual/Clocking-Work-Time.html#Clocking-Work-Time][Orgmode Manual entry]] for details.

;;*** org-roam

;; encapsulate org-roam-directory within (file-truename ___) if using links
(setq org-roam-directory (concat (file-name-as-directory org-directory) "roam")
      org-roam-db-location (concat (file-name-as-directory org-roam-directory) "org-roam.db")
      org-roam-file-extensions '("org")

      ;; Doom Defaults
      ;; org-roam-v2-ack t
      ;; org-roam-completion-everywhere t
      ;; org-roam-node-display-template "${doom-hierarchy:*} ${doom-tags:45}"

      ;; org-roam-extract-new-file-path doesn't work with a "slips/" path prepended to it
      org-roam-extract-new-file-path "${slug}-%<%Y%m%d%H%M%S>-.org"
      org-roam-dailies-directory "dailies/"
      org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :if-new (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n\n* Tasks \n\n* Notes")))

      org-roam-mode-section-functions #'(org-roam-backlinks-section
                                         org-roam-reflinks-section))

;; from https://org-roam.discourse.group/t/org-roam-major-redesign/1198/220
;;(setq org-roam-node-display-template "${title:80}  ${file:9} ${tags:20}")

(defun dc/org-roam-toggle-open-buffer-on-find-file ()
  "toggles the doom +org-roam-open-buffer-on-find-file variable"
  (interactive)
  (setq +org-roam-open-buffer-on-find-file
        (not +org-roam-open-buffer-on-find-file)))

(setq org-roam-capture-templates
      (append
       ;; org-roam-capture-templates
       '(
         ("p" "projects" plain "%?" :unnarrowed t
          :target (file+head "projects/${slug}.org"
                             "#+title: ${title}\n\n"))
         ("t" "topics" plain "%?" :unnarrowed t
          :target (file+head "topics/${slug}.org"
                             "#+title: ${title}\n\n"))
         ("c" "code" plain "%?" :unnarrowed t
          :target (file+head "code/${slug}.org"
                             "#+title: ${title}\n\n"))
         ("D" "drills" plain "%?" :unnarrowed t
          :target (file+head "drills/${slug}.org"
                             "#+title: ${title}\n\n"))
         ;; TODO: validate whether this should be changed
         ;; - for org-roam-bibtex or org-ref
         ;; NOTE: slug needs to be a DOI in form:
         ;; - ${indicator}.${registrant}/${suffix}
         ("n" "noter (DOI)" plain "%?" :unnarrowed t
          :target (file+head "noter/${slug}.org"
                             "#+title: ${title}\n\n"))

         ("s" "slips" plain "%?" :unnarrowed t
          :target (file+head "slips/%<%Y%m%d%H%M%S>-${slug}.org"
                             "#+title: ${title}"))

         ) org-roam-capture-templates))

;; DEFAULTS:
;; (setq org-roam-capture-templates '(("d" "default" plain "%?" :unnarrowed t
;;                                      :target (file+head "slips/%<%Y%m%d%H%M%S>-${slug}.org"
;;                                                         "#+title: ${title}"))))

;;**** org-roam-protocol
(use-package! org-roam-protocol
  :after org-protocol)

;;*** org-roam: daviwil

;;****  Project Templates
(defvar dw/org-roam-project-template
  '("p" "project" plain "** TODO %?"
    :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+category: ${title}\n$+filetags: Projects\n"
                           ("Tasks"))))

;; decide whether these functions are going to work for me (problems with roam subdirectories)
;; TODO (defun my/org-roam-filter-by-tag ...)
;; TODO (defun my/org-list-notes-by-tag ...)

;;**** Roam Node Insert
;; NOTE: (interactive "P") version of org-roam-node-insert
(defun dw/org-roam-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (push arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))


;;**** Roam Capture Task: project captures
(defun dw/org-roam-capture-task ()
  (interactive)
  ;; TODO
  ;(add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  )

;;*** org-capture
;; TODO ... actually use capture templates
;;
;; (now that i have enough experience to know what data/files are worth generating)

;;**** org-capture protocols
;; TODO see ./reorg.org for protocol capture templates

;;*** org-refile
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 2))
        (("./todo.org" "./notes.org") . (:maxlevel . 3))
        (nil . (:maxlevel . 2)))

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

;;*** org-mode misc
;;**** org-drill

;; Config and flashcard info can be found at
;; https://gitlab.com//phillord/org-drill

(use-package! org-drill
  :after org
  :config (progn
            (setq org-drill-add-random-noise-to-intervals-p t)
            (setq org-drill-hint-separator "||")
            (setq org-drill-left-cloze-separator "<[")
            (setq org-drill-left-cloze-separator "]>")
            (setq org-drill-learn-fraction 0.25)))

;;**** org-treeusage
;;
;; this package helps analyze org headlines for cyclomatic complexity
;;
;; Can be customized according to:
;; https://github.com/mtekman/org-treeusage.el#customisation

(use-package! org-treeusage
  ;; :bind ("C-c d" . org-treeusage-mode)
  :config (setq org-treescope-overlay-header nil
                org-treeusage-overlay-usecolorbands nil))

;;*** org-mode keys

;; doom-specific: add keys to doom defaults
(map! (:map org-mode-map
       :leader
       :prefix ("nr" . "org-roam")
       "T" #'dc/org-roam-toggle-open-buffer-on-find-file

       ;; this is a nice way to explore a sparse space though
       "a" #'org-roam-node-random

       "D" #'org-roam-demote-entire-buffer
       "i" #'dw/org-roam-insert-immediate
       "I" #'org-roam-insert-node
       "#" #'org-id-get-create
       "r" #'org-roam-refile
       "R" #'org-roam-link-replace-all
       "m" #'org-roam-buffer-toggle
       "M" #'org-roam-buffer-display-dedicated

       (:prefix ("o" . "node properties")
        "a" #'org-roam-alias-add
        "A" #'org-roam-alias-remove
        "t" #'org-roam-tag-add
        "T" #'org-roam-tag-remove
        "r" #'org-roam-ref-add
        "R" #'org-roam-ref-remove)))

;; doom-specific: doom maps these keys in two places, fix them both

(map! (:map org-mode-map
       :localleader
       :prefix ("m" . "org-roam")
       "T" #'dc/org-roam-toggle-open-buffer-on-find-file
       "a" #'org-roam-node-random
       "D" #'org-roam-demote-entire-buffer
       "i" #'dw/org-roam-insert-immediate
       "I" #'org-roam-insert-node
       "#" #'org-id-get-create
       "r" #'org-roam-refile
       "R" #'org-roam-link-replace-all
       "m" #'org-roam-buffer-toggle
       "M" #'org-roam-buffer-display-dedicated

       (:prefix ("o" . "node properties")
        "a" #'org-roam-alias-add
        "A" #'org-roam-alias-remove
        "t" #'org-roam-tag-add
        "T" #'org-roam-tag-remove
        "r" #'org-roam-ref-add
        "R" #'org-roam-ref-remove)))

;; doom-specific: toggle narrow to subtree
(map! :map org-mode-map
      :leader
      :prefix ("t" . "toggle")
      :desc "Toggle Org Narrow" "T" #'org-toggle-narrow-to-subtree
      :desc "Toggle Org Treeusage" "U" #'org-treeusage-mode)
;; Org Configs:1 ends here

;; [[file:config.org::*Lang Configs][Lang Configs:1]]
;;** LANG

;;*** ELISP
(use-package! elisp-depmap
  :bind (("C-c M-d" . elisp-depmap-graphviz-digraph)
         ("C-c M-g" . elisp-depmap-graphviz)
         ("C-c M-s" . elisp-depmap-makesummarytable))
  :config (setq elisp-depmap-exec-file (getenv "GRAPHVIZ_DOT")))

;;*** LATEX

;;*** CLOJURE
(add-hook 'clojure-mode-hook 'zprint-mode)
(add-hook 'clojurescript-mode-hook 'zprint-mode)

;;**** LSP (clojure)

;;**** CIDER
(add-hook 'cider-mode-hook #'clj-refactor-mode)
(setq org-babel-clojure-backend 'cider)

;;*** JULIA
(let ((julia-depot-path
       (car (split-string (getenv "JULIA_DEPOT_PATH") (path-separator)))))
  (setq lsp-julia-package-dir nil
        lsp-julia-default-environment
        (concat (file-name-as-directory julia-depot-path)
                "environments/v1.6")))

;;**** LSP (julia)

;;*** XML

;;*** C++

;;**** DOXYGEN
(use-package! highlight-doxygen
  :hook ((c-mode c++-mode) . highlight-doxygen-mode))

;;**** FILES
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

;;*** ARDUINO
;; (use-package! arduino-mode
;;   :hook ((arduino-mode . flycheck-arduino-setup)))
;; (add-hook 'arduino-mode-hook #'flycheck-arduino-setup)


;;*** SPICE

;;*** OPEN API
(use-package! openapi-yaml-mode)

;;*** RESTCLIENT


;;*** GRAPHQL
(use-package! graphql)
(use-package! graphql-mode)
(use-package! ob-graphql)
;; Lang Configs:1 ends here

;; [[file:config.org::*Babel Configs][Babel Configs:1]]
;;** BABEL

(after! org
  (setq org-babel-load-languages
        (append org-babel-load-languages
                '((julia-vterm . t)
                  (clojure . t)
                  (dot . t))))
  (org-babel-do-load-languages
   'org-babel-load-languages
   org-babel-load-languages))
(org-babel-make-language-alias "julia" "julia-vterm")

;; [[file:config.org::*\[\[https:/github.com/krisajenkins/ob-translate\]\[ob-translate\]\]][[[https://github.com/krisajenkins/ob-translate][ob-translate]]:2]]
;;*** ob-translate
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
;; ob-translate Configs:1 ends here

;; [[file:config.org::*Firewall Configs][Firewall Configs:1]]
;;** FIREWALL
;; Firewall Configs:1 ends here

;; [[file:config.org::*Email Configs][Email Configs:1]]
;;** EMAIL
;; Email Configs:1 ends here

;; [[file:config.org::*App Configs][App Configs:1]]
;;** APP
;; App Configs:1 ends here

;; [[file:config.org::*Config Configs][Config Configs:1]]
;;** CONFIG

;;*** Prism
(defun dc/prism-get-modus-colors ()
  "get modus colors for prism"
  (-map (lambda (c) (cdr (assq c modus-themes-vivendi-colors)))
        '(red blue-alt-other-faint green magenta cyan-alt-other blue orange-intense
              green-alt-other-faint purple-intense yellow-intense)))

(defun dc/prism-get-doom-colors ()
  "get doom colors which will return nil and result in the 'emacs config from hell',
   which prevents lispy-mode (and many moooore) and ALSO deletes the results of the
   C-c ' blocks"
  (-map #'doom-color '(red teal green magenta cyan blue orange
                           dark-cyan violet yellow)))

(use-package! prism
  :hook ((emacs-lisp-mode . prism-mode)
         (clojure-mode . prism-mode)
         (clojurescript-mode . prism-mode)
         (common-lisp-mode . prism-mode)
         (scheme-mode . prism-mode))
  :config (map! :leader :desc "Toggle Prism" "tP"
                (lambda () (interactive) (prism-mode 'toggle)))

  (prism-set-colors
   :lightens '(0 5 10)
   :desaturations '(-2.5 0 2.5)
   :colors (dc/prism-get-modus-colors)))

;;*** Rainbow Mode

(map! :leader :desc "Toggle Rainbow Mode" "tR"
      (lambda () (interactive) (rainbow-mode 'toggle)))

;; TODO fix to autoload rainbow-mode in doom theme files (setq
;; auto-minor-mode-alist (append '(("theme\\.el$" . rainbow-mode))
;; auto-minor-mode-alist))
;; Config Configs:1 ends here

;; [[file:config.org::*Hydras Configs][Hydras Configs:1]]
;;** HYDRAS

(load-file (expand-file-name
             (concat (file-name-as-directory (getenv "DOOMDIR"))
                     "scripts/hydras.el")))
;; Hydras Configs:1 ends here
