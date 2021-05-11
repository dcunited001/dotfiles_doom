;; -*- no-byte-compile: t; lexical-binding: t; -*-
;;; modules/ui/bufler/config.el
(use-package! bufler)

(add-hook 'doom-init-ui-hook
          (lambda () ;;(global-tab-line-mode +1)
            (map! :map ctl-x-map
                  :desc "Bufler List"
                  "C-b" #'bufler-list)
            (bufler-mode +1)
            (bufler-tabs-mode +1)))
