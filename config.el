;; -*- lexical-binding: t; -*-
;;* ~/.doom.d/config.el
(setq user-full-name "David Conner"
      user-mail-address "noreply@te.xel.io")

;; [[file:config.org::*Input Configs][Input Configs:1]]
;;** INPUT

;;** IDO
(when (featurep 'ido)
  (message "Disabling ido-mode")
  (ido-mode nil))

;; (map! "C-c f d" #'dired
;;       "C-x d" #'dired)

;; Fixes problems with dead keys
(require 'iso-transl)

;;*** Point Movements

;;*** Lispy
(setq lispy-compat '(cider edebug))
(setq auto-minor-mode-alist
      (append
       '(("/\\.dir-locals\\.el$" . lispy-mode))
       auto-minor-mode-alist))

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
(setq tab-always-indent 'complete)

;;*** Company

(map! "C-:" #'company-box-doc-manually
      "C-<tab>" #'company-yasnippet
      "C-M-;" #'company-yasnippet)

;;*** Ivy

;;*** Counsel
;; hopefully mindfuck myself into actually remembering 'counsel-imenu and 'counsel-swiper
(map! "C-s" 'counsel-imenu)
;; Completion Configs:1 ends here

;; [[file:config.org::*UI Configs][UI Configs:1]]
;;** UI

;;*** Diminish
;; should probably be loaded before :diminish directives
(use-package! diminish :ensure t)

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
      doom-variable-pitch-font (font-spec :family "Overpass" :size 14)
      doom-unicode-font (font-spec :family "JuliaMono" :size 14)
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
;; NOTE: 2022-04-23 disable to determine if it's associated with (pgtk?) lag
(tooltip-mode -1)

(setq tooltip-delay 2
      tooltip-short-delay 0.5)

;;*** Copy/Paste
;; no, nope, NO, NOO, NO!
;; HELL NO! What in the hell smatter with y0ou?
(setq x-select-enable-primary nil
      ;; select-enable-primary nil
      ;; x-select-enable-clipboard t
      ;; select-enable clipboard t
      )

;; when did that change?...

;;*** Window Dividers
;; Dividers are too thin to grab if only 1px
;; ... but what the hell. why not?
(setq window-divider-default-right-width 1
      window-divider-default-bottom-width 1)

(map! ("M-<f10>" #'doom/window-enlargen))

;;*** Menu
(menu-bar-mode +2)

;;*** Highlighting

(use-package! auto-highlight-symbol
  ;; should autoload on bind
  :config (map! (:prefix "M-s h" :desc "auto-highlight-mode"
                 "A" #'dc/toggle-auto-highlight-symbol-mode)))

;; TODO try global-auto-highlight-symbol-mode
;; doom-specific
;; (add-hook 'doom-init-ui-hook #'global-auto-highlight-symbol-mode)

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
  '(("^\\*lsp-ui-imenu" :side left :width 60
     :vslot -5 :slot 3
     :modeline nil :select t :quit t)
    ("^\\*Bufler" :side bottom :width 60
     :vslot -5 :slot -5
     :modeline nil :select t :quit t)))

;;*** Projectile

(setq projectile-project-search-path '(("/data/repo/" . 1)
                                       ;; ("/data/dev/" . 2) ;; trigger project depth
                                       ("/data/ecto/" . 3)))

;; projectile-auto-discover is nil
;; trigger project auto-discovery with projectile-discover-projects-in-search-path

;;*** Burly

(use-package! dash)
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

;; (add-hook 'doom-init-ui-hook #'bufler-mode)

;;*** Dogears
(use-package! dogears
  :config (map! :prefix "M-g"
                "d" #'dogears-go
                "M-b" #'dogears-back
                "M-f" #'dogears-forward
                "M-d" #'dogears-list
                "M-D" #'dogears-sidebar))

(add-hook 'doom-init-ui-hook #'dogears-mode)

;;*** Modeline
(setq +modeline-height 31)

;;*** Which Key
(setq which-key-idle-delay 1.0)

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

  ;;(dimmer-configure-company-box)
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

;(auto-insert-mode)

;;*** Doom File Templates

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
;; mostly to remind myself that it exists
;; (add-hook 'doom-init-ui-hook #'global-centered-cursor-mode)

;;*** Snippets

(setq dc/snippets (expand-file-name (concat doom-private-dir "snippets")))
(after! 'yasnippet
  (add-to-list 'yas-snippet-dirs 'dc/snippets)
  (message "loading dc/snippets")
  (yas-load-directory dc/snippets t))

(defun dc/toggle-objed-mode ()
  (interactive)
  (objed-mode 'toggle))

;; (map! ("<f10>" #'dc/toggle-objed-mode))
;; Editor Configs:1 ends here

;; [[file:config.org::*Emacs Config][Emacs Config:1]]
;;** EMACS

;;*** CONFIG 

;; https://labs.phundrak.com/phundrak/dotfiles/src/branch/master/org/config/emacs.org#Basic-Configuration-A-better-custom-variable-setter-56z4ni61lhj0
(defmacro csetq (&rest forms)
  "Bind each custom variable FORM to the value of its VAL.

FORMS is a list of pairs of values [FORM VAL].
`customize-set-variable' is called sequentially on each pairs
contained in FORMS. This means `csetq' has a similar behaviour as
`setq': each VAL expression are evaluated sequentially, i.e. the
first VAL is evaluated before the second, and so on. This means
the value of the first FORM can be used to set the second FORM.

The return value of `csetq' is the value of the last VAL.

\(fn [FORM VAL]...)"
  (declare (debug (&rest sexp form))
           (indent 1))
  ;; Check if we have an even number of arguments
  (when (= (mod (length forms) 2) 1)
    (signal 'wrong-number-of-arguments (list 'csetq (1+ (length forms)))))
  ;; Transform FORMS into a list of pairs (FORM . VALUE)
  (let (sexps)
    (while forms
      (let ((form  (pop forms))
            (value (pop forms)))
        (push `(customize-set-variable ',form ,value)
              sexps)))
    `(progn ,@(nreverse sexps))))

;;*** GPG

;; (setq auth-sources '("~/.authinfo" "~/.authinfo.gpg" "~/.netrc"))
;; (setq auth-sources (append `(,(concat (file-name-as-directory (getenv "DF_")) ".ectorepo.gpg")) auth-sources))

;;*** DIRED
(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq dired-dwim-target 'dired-dwim-target-recent)

;; Remove `.` and `..` from list of omitted file patterns
;; (so i can always run commands on the directory)
(map! (:map dired-mode-map
       ;; godammit don't close all the fucking dired buffers
       "q" #'find-name-dired
       :leader :desc "Close all direds" "Q" #'+dired/quit-all))

(defun +dired/quit-all ()
  "remap"
  (interactive)
  (message "don't close the buffers"))
;; Emacs Config:1 ends here

;; [[file:config.org::*Term Configs][Term Configs:1]]
;;** TERM
;; To install on guix with cmake (cc errors)
;; (setq vterm-module-cmake-args "-DCC=gcc")
;; Term Configs:1 ends here

;; [[file:config.org::*Checkers Configs][Checkers Configs:1]]
;;** CHECKERS
;; Checkers Configs:1 ends here

;; [[file:config.org::*Tools Configs][Tools Configs:1]]
;;** TOOLS

;;*** FIND/GREP
(setq counsel-grep-base-command "rg --color never %s %s")
;; (setq counsel-grep-base-command "grep -E -n -e %s %s")

;;*** INFO
(use-package! info-colors)

;;*** TLDR
(use-package! tldr
  :config (map! :leader "T" #'tldr))

;;*** EDIFF


;;*** GIT

;; control-f8, like facebook's conference
(map! "C-<f8>"
      :desc "Toggle Global Auto Highlight"
      #'git-timemachine-toggle)

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
;; (use-package! pkgbuild-mode :mode "\\PKGBUILD")

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
(appendq! auto-mode-alist
          '(("\\.pem$" . x509-mode)
            ("\\.cer$" . x509-mode)
            ("\\.der$" . x509-mode)
            ("\\.crt$" . x509-mode)
            ("\\.crl$" . x509-mode)))

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

;;*** ELF

;;*** RPM
;; (use-package! rpm-spec-mode) ; apparently broken
(use-package! archive-rpm)
;; Tools Configs:1 ends here

;; [[file:config.org::*Lsp Configs][Lsp Configs:1]]
;;** LSP

;;*** LSP MODE

;;*** LSP UI
(setq lsp-ui-peek-list-width 25
      ;; lsp-ui-sideline--last-width

      ;; TODO ensure these are necessary/useful
      lsp-ui-doc-max-width 40 ;; 35 is default
      ;; lsp-ui-doc--inline-width

      lsp-ui-imenu-window-width 25)

(defun dc/toggle-lsp-ui-menu ()
  "If within lsp-ui-mode major, toggle the buffer closed and return to the originating buffer. if not
then toggle to the lsp-ui-menu buffer & activate mode if necessary. "
  (interactive)

  ;; TODO: fix && fully implement
  (if (string-match (regexp-quote "*lsp-ui-imenu") (buffer-name))
   (lsp-ui-imenu--kill)
   (progn (unless (bound-and-true-p lsp-ui-mode) (lsp-ui-mode))
           (lsp-ui-imenu))))

(map! "<f9>"
      :desc "Toggle LSP UI Menu"
      #'dc/toggle-lsp-ui-menu)
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

      ;; org-src buffers replace current-window
      ;; NOTE: popup config is overriding this variableœ
      org-src-window-setup 'current-window

      ;; org-clock-idle-time 3
      )


;; doom-specific: Prevent over-eager dotfiles recompilation
(after! org
  (remove-hook 'org-mode-hook #'+literate-enable-recompile-h))


(defun dc/org-agenda-add-roam-dailies ()
  "add org-roam-dailies to org-agenda-files if it's not already contained"
  (let ((my-roam-dailies (file-name-as-directory
                          (concat org-directory "/roam/dailies"))))
    (unless (member my-roam-dailies org-agenda-files)
      (progn (message "appending org-roam-dailies to org-agenda-files")
             (append my-roam-dailies org-agenda-files)))))

;; (list
;;  (file-name-as-directory
;;   (concat  org-directory "/roam/dailies" )))

(after! org
  (setq org-log-done 'time
        org-support-shift-select t
        org-agenda-files '()))

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
                   :order 1)))
  :config (org-super-agenda-mode))

;;**** org-clock

;; Set auto-clockout to keep time tracking accurate.
(setq org-clock-auto-clockout-timer 300)
(org-clock-auto-clockout-insinuate)

;; Insinuate means that, unless a new clocking entry occurs
;; you will auto-clockout (for inactivity)
;; Refer to Orgmode Manual entry for details: https://orgmode.org/manual/Clocking-Work-Time.html#Clocking-Work-Time

;;*** org-roam

(defun dc/org-roam-read-template-from-file (file)
  (if (file-exists-p file) (org-file-contents file)
    (format "* Template file %S not found" file)))

(setq dc/org-roam-dailies-template
      (concat (file-name-as-directory doom-private-dir)
              "captures/roam/daily-default.org"))

;; encapsulate org-roam-directory within (file-truename ___) if using links
(setq org-roam-directory (concat (file-name-as-directory org-directory) "roam")
      org-roam-db-location (concat (file-name-as-directory (concat (getenv "HOME") "/.local/share/org-roam")) "org-roam.db")
      org-roam-file-extensions '("org")

      ;; Doom Defaults
      ;; org-roam-v2-ack t

      ;; the default gives titles that are too narrow (12)
      ;; org-roam-node--* sends the width of the then-current buffer
      ;; and the completing-read functionality is adjusted for ~80 chars
      ;;
      org-roam-node-display-template
      (format "${doom-hierarchy:36} %s %s"
              (propertize "${doom-type:*}" 'face 'font-lock-keyword-face)
              (propertize "${doom-tags:18}" 'face 'org-tag))

      org-roam-completion-everywhere nil

      ;; org-roam-extract-new-file-path doesn't work with a "slips/" path prepended to it
      org-roam-extract-new-file-path "${slug}-%<%Y%m%d%H%M%S>-.org"
      org-roam-dailies-directory "dailies/"
      org-roam-dailies-capture-templates
      `(("d" "default" entry
         ;; this should work, but seems unimplemented in org-roam
         ;; (file "./relative/path/from/roam/template.org")
         "%?"
         :target
         (file+head "%<%Y-%m-%d>.org"
                    ,(dc/org-roam-read-template-from-file dc/org-roam-dailies-template)
                    ;; ,(dc/org-roam-read-template-from-file
                    ;;   (concat (file-name-as-directory doom-private-dir)
                    ;;           "captures/roam/daily-default.org"))

                    )))

      org-roam-mode-section-functions #'(org-roam-backlinks-section
                                         org-roam-reflinks-section))

;; from https://org-roam.discourse.group/t/org-roam-major-redesign/1198/220
;;(setq org-roam-node-display-template "${title:80}  ${file:9} ${tags:20}")

(defun dc/org-roam-toggle-open-buffer-on-find-file ()
  "toggles the doom +org-roam-open-buffer-on-find-file variable"
  (interactive)
  (setq +org-roam-open-buffer-on-find-file
        (not +org-roam-open-buffer-on-find-file)))

(defconst dc/org-roam-capture-anki
  (string-join '("#+TITLE: ${title}"
                 "#+CATEGORY: anki"
                 "#+TAGS: "
                 ""
                 "* About"
                 ""
                 "* Cards"
                 ":PROPERTIES:"
                 ":ANKI_DECK: %^{DECK}"
                 ":ANKI_NOTE_TYPE: LaTeX"
                 ":END:") "\n"))

;; example file+head+olp
;; ("E" "example" plain "%?" :unnarrowed t
;;  :target (file+head+olp "${slug}.org"
;;                         "#+TITLE: ${title}\n\n"
;;                         ("h1" ("h2" "h2a") ("h3") "h4")))

(setq org-roam-capture-templates
      (append
       ;; org-roam-capture-templates
      `(
        ("p" "projects" plain "%?" :unnarrowed t
         :target (file+head "projects/${slug}.org"
                            "#+TITLE: ${title}\n\n"))
        ("t" "topics" plain "%?" :unnarrowed t
         :target (file+head "topics/${slug}.org"
                            "#+TITLE: ${title}\n\n"))
        ("c" "code" plain "%?" :unnarrowed t
         :target (file+head "code/${slug}.org"
                            "#+TITLE: ${title}\n\n"))

        ;; for Anki/Editor format examples
        ;; - see https://github.com/louietan/anki-editor/examples.org
        ;; only notes that already exist in Anki should have ANKI_NOTE_ID
        ;; - see https://github.com/louietan/anki-editor/blob/master/anki-editor.el#161
        ("a" "anki" plain "%?" :unnarrowed t
         :target (file+head "anki/${slug}.org"
                            ,dc/org-roam-capture-anki))
        ("D" "drills" plain "%?" :unnarrowed t
         :target (file+head "drills/${slug}.org"
                            "#+TITLE: ${title}\n\n"))

        ;; TODO: validate whether this should be changed
        ;; - for org-roam-bibtex or org-ref
        ;; NOTE: slug needs to be a DOI in form:
        ;; - ${indicator}.${registrant}/${suffix}
        ("n" "noter (DOI)" plain "%?" :unnarrowed t
         :target (file+head "noter/${slug}.org"
                            ,(string-join '("#+TITLE: ${title}"
                                            "#+CATEGORY: slips"
                                            "#+TAGS: ") "\n")))

        ("s" "slips" plain "%?" :unnarrowed t
         :target (file+head "slips/%<%Y%m%d%H%M%S>-${slug}.org"
                            ,(string-join '("#+TITLE: ${title}"
                                            "#+CATEGORY: slips"
                                            "#+TAGS: ") "\n")))) org-roam-capture-templates))

(defun dc/org-roam-insert-slug ()
  (interactive)
  (insert (org-roam-node-slug (org-roam-node-at-point))))

(defun dc/org-roam-get-slug ()
  (interactive)
  (org-roam-node-slug (org-roam-node-at-point)))

(use-package! org-roam-ui
  ;; :hook (...) ;; dont hook
  :after org-roam)

(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-open-on-start nil
      org-roam-ui-update-on-save t)

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
    :target (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                           (string-join '("#+title: ${title}"
                                          "#+category: projects"
                                          "#+tags: project") "\n")
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
;; TODO: remove org-agenda-files and replace with:
;; - roam/topics & roam/projects
;; TODO: filter org roam dailies by filename's parsed dates
;; - filter to two months
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
;;**** org-krita
(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))

;; org-krita uses (call-process exe nil 0 nil args...)
(setq org-krita-executable "flatpak run org.kde.krita")
;; (defun dc/org-krita-get-flatpak-location ()
;;   (shell-command-to-string "flatpak info org.kde.krita --show-location"))


(defun org-krita-edit (path &optional full-mode)
  "Edit given PATH in krita canvasonly mode.
If FULL-MODE is not null, run full krita."
  (let ((kra-path (expand-file-name path)))
    (when (f-exists-p kra-path)
      (call-process-shell-command org-krita-executable nil 0 nil "--nosplash" kra-path)
      (org-krita-add-watcher kra-path))))

;; alter-f8 ... with art
(map! "M-<f8>" :desc "Insert Krita Image" #'org-krita-insert-new-image)

;; allow overriding the template with a project-local template
(defun org-krita-resource (file)
  "Return full path of a resource FILE."
  (expand-file-name
   file (file-name-as-directory (or (and (boundp 'my-org-krita-dir) my-org-krita-dir)
                                    (concat  org-krita-dir "resources")))))

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
       "4" #'dc/org-roam-get-slug
       "$" #'dc/org-roam-insert-slug
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
       "4" #'dc/org-roam-get-slug
       "$" #'dc/org-roam-insert-slug

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

;;*** SCHEME

;;**** GEISER
;; see notes below on ipc from scheme to geiser (and v.v.)
(setq geiser-repl-autodoc-p nil)


;;**** GUILE

;;*** GUIX

;;*** JULIA

(let ((julia-depot-path
       (car (split-string (or (getenv "JULIA_DEPOT_PATH")
                              (concat (getenv "_LANG") "/.julia"))
                              path-separator))))
  (setq lsp-julia-package-dir nil
        lsp-julia-default-environment
        (concat (file-name-as-directory julia-depot-path)
                "environments/v1.7")))

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
                                ("\\.hpp$" . c++-mode))
                              auto-mode-alist))

;;*** ARDUINO
;; (use-package! arduino-mode
;;   :hook ((arduino-mode . flycheck-arduino-setup)))
;; (add-hook 'arduino-mode-hook #'flycheck-arduino-setup)


;;*** SPICE

;;*** SMILES
(use-package! smiles-mode)
(use-package! ob-smiles)

;;*** OPEN API
(use-package! openapi-yaml-mode)

;;*** RESTCLIENT


;;*** GRAPHQL
(use-package! graphql)
(use-package! graphql-mode)
(use-package! ob-graphql)

;;*** GRAPHVIZ

;;**** graphviz-dot-mode
(use-package! graphviz-dot-mode)

;;**** dynamic-graphviz
(use-package! dynamic-graphs)
;; Lang Configs:1 ends here

;; [[file:config.org::*Babel Configs][Babel Configs:1]]
;;** BABEL

(use-package! ob-dot)
(org-babel-make-language-alias "julia" "julia-vterm")

;; this is insufficient as make-language-alias remaps a few other symbols
;; (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
;; Babel Configs:1 ends here

;; [[file:config.org::*ob-translate Configs][ob-translate Configs:1]]
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
(use-package anki-editor
  :after org-noter
  :config (setq anki-editor-create-decks 't))

(map! (:map org-mode-map
       :leader
       :prefix ("n@" . "Anki")
       :desc "Push Anki Notes" "p" 'anki-editor-push-notes
       :desc "Retry Anki Notes" "r" 'anki-editor-retry-failure-notes
       :desc "Insert Note" "n" 'anki-editor-insert-note
       (:prefix ("c" . "Cloze")
        :desc "Dwim" "d" 'anki-editor-cloze-dwim
        :desc "Region" "r" 'anki-editor-cloze-region)))
;; App Configs:1 ends here

;; [[file:config.org::*Config Configs][Config Configs:1]]
;;** CONFIG

;;*** Prism
(defun dc/prism-get-modus-colors ()
  "get modus colors for prism"
  (-map (lambda (c) (cdr (assoc (symbol-name c) modus-vivendi-theme-default-colors-alist)))
        '(red-fringe-bg blue green magenta cyan-alt-other blue red-alt
                        green-intense  blue-refine-bg yellow-intense)))

(defun dc/prism-get-doom-colors ()
  "get doom colors which will return nil and result in the 'emacs config from hell',
   which prevents lispy-mode (and many moooore) and ALSO deletes the results of the
   C-c ' blocks"
  (-map #'doom-color '(red teal green magenta cyan blue orange
                           dark-cyan violet yellow)))

;; i'm not sure whether this will help with performance
;; but it took forever to find
(defun dc/unless-org-src-fontification-activate (mode)
  "enable mode unless in an org-mode block"
  (unless (string-match (regexp-quote "*org-src-fontification:") (buffer-name))
    (apply mode '(+1))))

(use-package! prism
  :after modus-vivendi-theme
  :config (map! :leader :desc "Toggle Prism" "tP"
                (lambda () (interactive) (prism-mode 'toggle)))

  (add-hook! (emacs-lisp-mode clojure-mode clojurescript-mode common-lisp-mode scheme-mode)
             #'(lambda () (dc/unless-org-src-fontification-activate 'prism-mode))))

(add-hook! 'modus-themes-after-load-theme-hook
           :append
           #'(lambda ()

               (prism-set-colors
                 :lightens '(0 5 10)
                 :desaturations '(-2.5 0 2.5)
                 :colors (dc/prism-get-modus-colors))))

;; (dc/prism-get-modus-colors)
;; ("#ff8059"
;;  "#80b2f0"
;;  "#44bc44"
;;  "#feacd0"
;;  "#6ae4b9"
;;  "#2fafff"
;;  "#fba849"
;;  "#88bf99"
;;  "#9f80ff"
;;  "#f0dd60")

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
