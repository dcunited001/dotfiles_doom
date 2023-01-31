;; -*- no-byte-compile: t; 
;;* ~/.doom.d/packages.el

;; [[file:config.org::*Input Packages][Input Packages:1]]
;;** INPUT
;; Input Packages:1 ends here

;; [[file:config.org::*Completion Packages][Completion Packages:1]]
;;** COMPLETION
;; Completion Packages:1 ends here

;; [[file:config.org::*UI Packages][UI Packages:1]]
;;** UI
(package! ef-themes)

(package! diminish)
(package! auto-highlight-symbol)
(package! dimmer)
;; (package! beacon)

;;*** Alphapapa
(package! burly)
(package! bufler
  :recipe (:host github
           :repo "alphapapa/bufler.el"
           :files (:defaults (:exclude "helm-bufler.el" "bufler-workspace.el" "bufler-workspace-tabs.el"))))

(package! dogears
  :recipe (:host github
           :repo "alphapapa/dogears.el"
           :files (:defaults (:exclude "helm-dogears.el"))))
;; UI Packages:1 ends here

;; [[file:config.org::*Snippets Packages][Snippets Packages:1]]
(package! yasnippet :pin "5cbdbf0d2015540c59ed8ee0fcf4788effdf75b6")
(package! auto-yasnippet :pin "db9e0dd4335b2202cd5dac95bbbc87a1032d9bbe")
(package! doom-snippets
  :recipe (:host github
           :repo "doomemacs/snippets"
           :files (:defaults "*"))
  :pin "2d031f723164c6500ce68dcafe3dd30e6d3b23b1")
;; Snippets Packages:1 ends here

;; [[file:config.org::*Web Packages][Web Packages:1]]
;; +html.el
(package! emmet-mode :pin "6b2e554f7fd27f732810f4b14ea01e3c54b7b3da")
(package! haml-mode :pin "bf5b6c11b1206759d2b28af48765e04882dd1fc4")
(package! pug-mode :pin "73f8c2f95eba695f701df20c8436f49abadebdc1")
(package! slim-mode :pin "3636d18ab1c8b316eea71c4732eb44743e2ded87")
(when (package! web-mode :pin "efa853e5cfff8e0bcacbda9d1c6696b33da91b03")
  (when (modulep! :completion company)
    (package! company-web :pin "863fb84b81ed283474e50330cd8d27b1ca0d74f1")))

;; +css.el
(package! css-mode :built-in t)
(package! less-css-mode :built-in t :pin "c7fa3d56d83206b28657f2e56439dc62280a2bf2")

(package! sass-mode :pin "247a0d4b509f10b28e4687cd8763492bca03599b")
(package! stylus-mode :pin "1ad7c51f3c6a6ae64550d9510c5e4e8470014375")
(package! sws-mode :pin "1ad7c51f3c6a6ae64550d9510c5e4e8470014375")
(package! rainbow-mode :pin "949166cc0146bc9fabf74ce70c1c4a097f4cffd4")
(when (modulep! :completion ivy)
  (package! counsel-css :pin "8e9c0515fc952452eee786d8ebb43d48ea86c9f8"))
(when (modulep! :completion helm)
  (package! helm-css-scss :pin "48b996f73af1fef8d6e88a1c545d98f8c50b0cf3"))
;; Web Packages:1 ends here

;; [[file:config.org::*Editor Packages][Editor Packages:1]]
;;** EDITOR

(package! origami)
(package! centered-cursor-mode)

;; requires helm (-公-;)
;; (package! kaomoji)
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

(package! xdg-paths)
(package! info-colors)
(package! tldr)
(package! magit-tbdiff)
(package! repo)
(package! firestarter)
(package! guix)
(package! journalctl-mode)
(package! crontab-mode)
(package! ssh-config-mode)
(package! x509-mode)

(package! pcap-mode
  :recipe (:host github
           :repo "orgcandman/pcap-mode"))
;; TODO ssh-agency
;; TODO ssh-tunnels
(package! salt-mode)

;; ok apparently there is an elf-mode :)
(package! elf-mode)

;; (package! rpm-spec-mode) ; apparently broken
(package! archive-rpm)
;; Tools Packages:1 ends here

;; [[file:config.org::*Lsp Packages][Lsp Packages:1]]
;;** LSP
;; Lsp Packages:1 ends here

;; [[file:config.org::*OS Packages][OS Packages:1]]
;;** OS
;; OS Packages:1 ends here

;; [[file:config.org::*Org Packages][Org Packages:1]]
;;** ORG

;; org data
(package! org-treeusage)

;; org bibliography
(package! org-ref)

;; org agenda
;; dependencies org-super-agenda => org-ql => org-sidebar
(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)

;; org roam
; so roam-ui gets latest roam (breaks doom update on main/ref)
;; (unpin! org-roam)
(package! org-roam-ui)

;; org misc
(package! org-krita
  :recipe (:host github
           :repo "lepisma/org-krita"
           :files ("resources" "resources" "*.el" "*.el")))

(package! org-drill)

(package! org-lms
  :recipe (:host github :repo "titaniumbones/org-lms"))
;; Org Packages:1 ends here

;; [[file:config.org::*Exports Packages][Exports Packages:1]]

;; Exports Packages:1 ends here

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
(package! smiles-mode)
(package! ob-smiles)
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
