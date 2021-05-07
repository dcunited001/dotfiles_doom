(use-package! bufler
  :config (map! ;(:after ...?)
           :map ctl-x-map
           :desc "Bufler List" "C-b" #'bufler-list))

(add-hook 'doom-init-ui-hook
          (lambda () ;;(global-tab-line-mode +1)
            (bufler-mode +1)
            (bufler-tabs-mode +1)))
