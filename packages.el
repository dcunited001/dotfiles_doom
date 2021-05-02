;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! all-the-icons-dired)

(package! prism.el
  :after (:any clojure-mode emacs-lisp-mode))

;; from HaoZeke/dotdoom
(package! pkgbuild-mode
  :recipe (:host github
           :repo "juergenhoetzel/pkgbuild-mode"))
