;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;; ~/.doom.d/packages.el

;; [[file:config.org::*Highlighting][Highlighting:1]]
(package! auto-highlight-symbol)
;; Highlighting:1 ends here

;; [[file:config.org::*Bufler][Bufler:1]]
(package! bufler :recipe (:host github
                           :repo "alphapapa/bufler.el"
                           :files (:defaults (:exclude "helm-bufler.el"))))
;; Bufler:1 ends here

;; [[file:config.org::*Dogears][Dogears:1]]
(package! dogears :recipe (:host github
                           :repo "alphapapa/dogears.el"
                           :files (:defaults (:exclude "helm-dogears.el"))))
;; Dogears:1 ends here

;; [[file:config.org::*Dimmer][Dimmer:1]]
(package! dimmer)
;; Dimmer:1 ends here

;; [[file:config.org::*Window & Frame Management][Window & Frame Management:1]]
(package! burly)
;; Window & Frame Management:1 ends here

;; [[file:config.org::*Sticky Windows][Sticky Windows:1]]
;;(package! )
;; Sticky Windows:1 ends here

;; [[file:config.org::*Origami Mode][Origami Mode:1]]
(package! origami)
;; Origami Mode:1 ends here

;; [[file:config.org::*Centered Cursor Mode][Centered Cursor Mode:1]]
(package! centered-cursor-mode)
;; Centered Cursor Mode:1 ends here

;; [[file:config.org::*Info][Info:1]]
(package! info-colors)
;; Info:1 ends here

;; [[file:config.org::*TLDR][TLDR:1]]
(package! tldr)
;; TLDR:1 ends here

;; [[file:config.org::*Magit][Magit:1]]
(package! magit-tbdiff)
;; Magit:1 ends here

;; [[file:config.org::*Repo][Repo:1]]
(package! repo)
;; Repo:1 ends here

;; [[file:config.org::*Shell][Shell:1]]
(package! firestarter)
;; Shell:1 ends here

;; [[file:config.org::*Guix][Guix:1]]
(package! guix)
;; Guix:1 ends here

;; [[file:config.org::*SystemD][SystemD:1]]
(package! journalctl-mode)
;; SystemD:1 ends here

;; [[file:config.org::*PKGBUILD Mode][PKGBUILD Mode:1]]
(package! pkgbuild-mode :recipe (:host github
                                 :repo "juergenhoetzel/pkgbuild-mode"))
;; PKGBUILD Mode:1 ends here

;; [[file:config.org::*Crontab Mode][Crontab Mode:1]]
(package! crontab-mode)
;; Crontab Mode:1 ends here

;; [[file:config.org::*Ken Kesey][Ken Kesey:1]]
(package! ssh-config-mode)
(package! x509-mode)
;; TODO ssh-agency
;; TODO ssh-tunnels
;; Ken Kesey:1 ends here

;; [[file:config.org::*SaltStack][SaltStack:1]]
(package! salt-mode)
;; SaltStack:1 ends here

;; [[file:config.org::*Emacs Packages][Emacs Packages:1]]

;; Emacs Packages:1 ends here

;; [[file:config.org::*ORG][ORG:1]]
(package! org-treeusage)
(package! org-drill)
(package! org-ref)

;; dependencies org-super-agenda => org-ql => org-sidebar
(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)
;; ORG:1 ends here

;; [[file:config.org::*\[\[https:/gitlab.com/mtekman/elisp-depmap.el\]\[Elisp Depmap\]\]][[[https://gitlab.com/mtekman/elisp-depmap.el][Elisp Depmap]]:1]]
(package! elisp-depmap
  :recipe (:host gitlab :repo "mtekman/elisp-depmap.el"))
;; [[https://gitlab.com/mtekman/elisp-depmap.el][Elisp Depmap]]:1 ends here

;; [[file:config.org::*CLOJURE][CLOJURE:1]]
(package! zprint-mode)
;; CLOJURE:1 ends here

;; [[file:config.org::*JULIA][JULIA:1]]
(package! julia-vterm)
(package! ob-julia-vterm)
;; JULIA:1 ends here

;; [[file:config.org::*Doxygen Support][Doxygen Support:1]]
(package! highlight-doxygen)
;; Doxygen Support:1 ends here

;; [[file:config.org::*ARDUINO][ARDUINO:1]]
(package! arduino-mode)
(package! arduino-cli-mode)
;; ARDUINO:1 ends here

;; [[file:config.org::*OPEN API][OPEN API:1]]
(package! openapi-yaml-mode
  :recipe (:host github :repo "esc-emacs/openapi-yaml-mode"))
;; OPEN API:1 ends here

;; [[file:config.org::*GRAPHQL][GRAPHQL:1]]
(package! graphql)
(package! graphql-mode)
(package! ob-graphql)
;; GRAPHQL:1 ends here

;; [[file:config.org::*SPICE][SPICE:1]]
(package! spice-mode)
;; SPICE:1 ends here

;; [[file:config.org::*Setup for =ob-spice=][Setup for =ob-spice=:1]]
(package! ob-spice :recipe (:host github :repo "stardiviner/ob-spice"
                            :fork (:host github :repo "dcunited001/ob-spice"
                            :branch "fix-org-babel-api")))
;; Setup for =ob-spice=:1 ends here

;; [[file:config.org::*\[\[https:/github.com/krisajenkins/ob-translate\]\[ob-translate\]\]][[[https://github.com/krisajenkins/ob-translate][ob-translate]]:1]]
(package! google-translate)
(package! ob-translate)
;; [[https://github.com/krisajenkins/ob-translate][ob-translate]]:1 ends here

;; [[file:config.org::*FIREWALL][FIREWALL:1]]

;; FIREWALL:1 ends here

;; [[file:config.org::*Prism.el][Prism.el:1]]
(package! prism)
;; Prism.el:1 ends here
