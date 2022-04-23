;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;* ~/.doom.d/packages.el

;; [[file:config.org::*Input Packages][Input Packages:1]]
;;** INPUT
;; Input Packages:1 ends here

;; [[file:config.org::*Completion Packages][Completion Packages:1]]
;;** COMPLETION
;; Completion Packages:1 ends here

;; [[file:config.org::*UI Packages][UI Packages:1]]
;;** UI

(package! diminish)
(package! auto-highlight-symbol)
(package! dimmer)
;; (package! beacon)

;;*** Alphapapa
(package! burly)
;; (package! bufler
;;   :recipe (:host github
;;            :repo "alphapapa/bufler.el"
;;            :files (:defaults (:exclude "helm-bufler.el"))))
(package! dogears
  :recipe (:host github
           :repo "alphapapa/dogears.el"
           :files (:defaults (:exclude "helm-dogears.el"))))
;; UI Packages:1 ends here

;; [[file:config.org::*Editor Packages][Editor Packages:1]]
;;** EDITOR

(package! origami)
(package! centered-cursor-mode)
;; Editor Packages:1 ends here

;; [[file:config.org::*Emacs Packages][Emacs Packages:1]]
;;** EMACS
;; Emacs Packages:1 ends here

;; [[file:config.org::*Term Packages][Term Packages:1]]
;;** TERM
;; Term Packages:1 ends here

;; [[file:config.org::*Checkers Packages][Checkers Packages:1]]
;;** CHECKERS
;; Checkers Packages:1 ends here

;; [[file:config.org::*Tools Packages][Tools Packages:1]]
;;** TOOLS

(package! info-colors)
(package! tldr)
(package! magit-tbdiff)
(package! repo)
(package! firestarter)
(package! guix)
(package! journalctl-mode)
(package! pkgbuild-mode
  :recipe (:host github
           :repo "juergenhoetzel/pkgbuild-mode"))
(package! crontab-mode)
(package! ssh-config-mode)
(package! x509-mode)
;; TODO ssh-agency
;; TODO ssh-tunnels
(package! salt-mode)
;; Tools Packages:1 ends here

;; [[file:config.org::*Lsp Packages][Lsp Packages:1]]
;;** LSP
;; Lsp Packages:1 ends here

;; [[file:config.org::*OS Packages][OS Packages:1]]
;;** OS
;; OS Packages:1 ends here

;; [[file:config.org::*Org Packages][Org Packages:1]]
;;** ORG
(package! org-treeusage)
(package! org-drill)
(package! org-ref)

;; dependencies org-super-agenda => org-ql => org-sidebar
(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)
;; Org Packages:1 ends here

;; [[file:config.org::*Lang Packages][Lang Packages:1]]
;;** LANG

(package! elisp-depmap
  :recipe (:host gitlab :repo "mtekman/elisp-depmap.el"))
(package! graphviz-dot-mode)
(package! dynamic-graphs)
(package! zprint-mode)
(package! julia-vterm)
(package! ob-julia-vterm)
(package! highlight-doxygen)
(package! arduino-cli-mode)
(package! openapi-yaml-mode
  :recipe (:host github :repo "esc-emacs/openapi-yaml-mode"))
(package! graphql)
(package! graphql-mode)
(package! ob-graphql)
;; Lang Packages:1 ends here

;; [[file:config.org::*Babel Packages][Babel Packages:1]]
;;** BABEL
;; Babel Packages:1 ends here

;; [[file:config.org::*ob-translate Packages][ob-translate Packages:1]]
;;*** ob-translate
(package! google-translate)
(package! ob-translate)
;; ob-translate Packages:1 ends here

;; [[file:config.org::*Firewall Package][Firewall Package:1]]
;;** FIREWALL
;; Firewall Package:1 ends here

;; [[file:config.org::*Email Packages][Email Packages:1]]
;;** EMAIL
;; Email Packages:1 ends here

;; [[file:config.org::*App Packages][App Packages:1]]
;** APP
(package! anki-editor)
;; App Packages:1 ends here

;; [[file:config.org::*Config Packages][Config Packages:1]]
;;** CONFIG
(package! prism)
;; Config Packages:1 ends here

;; [[file:config.org::*Hydras Packages][Hydras Packages:1]]
;;** HYDRAS
;; Hydras Packages:1 ends here
