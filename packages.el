;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;; ~/.doom.d/packages.el

(package! auto-highlight-symbol)

(package! treemacs-all-the-icons)

(package! dimmer)

(package! burly)

;;(package! )

(package! origami)

(package! centered-cursor-mode)

(package! info-colors)

(package! magit-tbdiff)

(package! repo)

(package! firestarter)

(package! journalctl-mode)

(package! pkgbuild-mode
  :recipe (:host github :repo "juergenhoetzel/pkgbuild-mode"))

(package! crontab-mode)

(package! ssh-config-mode)
(package! x509-mode)
;; TODO ssh-agency
;; TODO ssh-tunnels

(package! salt-mode)



(package! org-treeusage)
(package! org-drill)

;; dependencies org-super-agenda => org-ql => org-sidebar
(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)

(package! zprint-mode)

(add-hook 'cider-mode-hook #'clj-refactor-mode)

(setq org-babel-clojure-backend 'cider)

(package! julia-vterm)
(package! ob-julia-vterm)

(package! highlight-doxygen)

(package! openapi-yaml-mode
  :recipe (:host github :repo "esc-emacs/openapi-yaml-mode"))

(package! graphql)
(package! graphql-mode)
(package! ob-graphql)

(package! google-translate)
(package! ob-translate)



(package! prism)
