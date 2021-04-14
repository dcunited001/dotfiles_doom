(setq user-full-name "David Conner"
      user-mail-address "number8@fantasyfarm.com")

(setq doom-theme 'doom-one)

(set-frame-font "Source Code Pro 12" nil t)

(setq window-divider-default-right-width 3)
(setq window-divider-default-bottom-width 3)

(require 'iso-transl)

(setq display-line-numbers-type t)

(setq dired-omit-files "^.DS_Store\\'\\|^.project\\(?:ile\\)?\\'\\|^.\\(svn\\|git\\)\\'\\|^.ccls-cache\\'\\|\\(?:\\.js\\)?\\.meta\\'\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'")

(setq explicit-shell-file-name "/bin/zsh")

(setq org-directory "/data/org")

(after! org
  (setq org-log-done 'time
        ;;org-agenda-files (concat (file-name-as-directory org-directory) "agenda.org")
   ))

(defun dc/org-babel-tangle-async (file)
  "Invoke `org-babel-tangle-file' asynchronously."
  (message "Tangling %s..." (buffer-file-name))
  (async-start
   (let ((args (list file)))
  `(lambda ()
        (require 'org)
        ;;(load "~/.emacs.d/init.el")
        (let ((start-time (current-time)))
          (apply #'org-babel-tangle-file ',args)
          (format "%.2f" (float-time (time-since start-time))))))
   (let ((message-string (format "Tangling %S completed after " file)))
     `(lambda (tangle-time)
        (message (concat ,message-string
                         (format "%s seconds" tangle-time)))))))

(defun dc/org-babel-tangle-current-buffer-async ()
  "Tangle current buffer asynchronously."
  (dc/org-babel-tangle-async (buffer-file-name)))

(map! "<mouse-8>" 'projectile-find-file)
(map! "<mouse-9>" 'projectile-grep)
(map! "C-M-<mouse-8>" '+workspace/switch-left)
(map! "C-M-<mouse-9>" '+workspace/switch-right)
(map! "C-<mouse-8>" '+ivy/switch-workspace-buffer)
(map! "C-<mouse-9>" 'counsel-projectile-switch-project)
(map! "M-<mouse-8>" 'doom/save-session)
(map! "M-<mouse-9>" 'doom/load-session)
(map! "M-S-<mouse-8>" 'winner-undo)
(map! "M-S-<mouse-9>" 'winner-redo)
(map! "S-<mouse-8>" 'previous-buffer)
(map! "S-<mouse-9>" 'next-buffer)

(put 'dockerfile-image-name 'safe-local-variable #'stringp)
