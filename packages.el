;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;* ~/.doom.d/packages.el

;; [[file:config.org::*INPUT][INPUT:1]]
;;** INPUT
;; INPUT:1 ends here

;; [[file:config.org::*COMPLETION][COMPLETION:1]]
;;** COMPLETION
;; COMPLETION:1 ends here

;; [[file:config.org::*UI][UI:1]]
;;** UI

(package! diminish)
(package! auto-highlight-symbol)
(package! bufler :recipe (:host github
                           :repo "alphapapa/bufler.el"
                           :files (:defaults (:exclude "helm-bufler.el"))))
(package! dogears :recipe (:host github
                           :repo "alphapapa/dogears.el"
                           :files (:defaults (:exclude "helm-dogears.el"))))

(package! dimmer)
;; (package! beacon)



;;*** Alphapapa
(package! burly)
(package! bufler
  :recipe (:host github
           :repo "alphapapa/bufler.el"
           :files (:defaults (:exclude "helm-bufler.el"))))
(package! dogears
  :recipe (:host github
           :repo "alphapapa/dogears.el"
           :files (:defaults (:exclude "helm-dogears.el"))))
;; UI:1 ends here

;; [[file:config.org::*EDITOR][EDITOR:1]]
;;** EDITOR

(package! origami)
(package! centered-cursor-mode)
;; EDITOR:1 ends here

;; [[file:config.org::*EMACS][EMACS:1]]
;;** EMACS
;; EMACS:1 ends here

;; [[file:config.org::*TERM][TERM:1]]
;;** TERM
;; TERM:1 ends here

;; [[file:config.org::*CHECKERS][CHECKERS:1]]
;;** CHECKERS
;; CHECKERS:1 ends here

;; [[file:config.org::*TOOLS][TOOLS:1]]
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
;; TOOLS:1 ends here

;; [[file:config.org::*LSP][LSP:1]]
;;** LSP
;; LSP:1 ends here

;; [[file:config.org::*OS][OS:1]]
;;** OS
;; OS:1 ends here

;; [[file:config.org::*ORG][ORG:1]]
;;** ORG
(package! org-treeusage)
(package! org-drill)
(package! org-ref)

;; dependencies org-super-agenda => org-ql => org-sidebar
(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)
;; ORG:1 ends here

;; [[file:config.org::*LANG][LANG:1]]
;;** LANG

(package! elisp-depmap
  :recipe (:host gitlab :repo "mtekman/elisp-depmap.el"))
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
;; LANG:1 ends here

;; [[file:config.org::*BABEL][BABEL:1]]
;;** BABEL
;; BABEL:1 ends here

;; [[file:config.org::*\[\[https:/github.com/krisajenkins/ob-translate\]\[ob-translate\]\]][[[https://github.com/krisajenkins/ob-translate][ob-translate]]:1]]
;;*** ob-translate
(package! google-translate)
(package! ob-translate)
;; [[https://github.com/krisajenkins/ob-translate][ob-translate]]:1 ends here

;; [[file:config.org::*FIREWALL][FIREWALL:1]]
;;** FIREWALL
;; FIREWALL:1 ends here

;; [[file:config.org::*EMAIL][EMAIL:1]]
;;** EMAIL
;; EMAIL:1 ends here

;; [[file:config.org::*APP][APP:1]]
;;** APP
;; APP:1 ends here

;; [[file:config.org::*CONFIG][CONFIG:1]]
;;** CONFIG
(package! prism)
;; CONFIG:1 ends here

;; [[file:config.org::*HYDRAS][HYDRAS:1]]
;;** HYDRAS
;; HYDRAS:1 ends here
