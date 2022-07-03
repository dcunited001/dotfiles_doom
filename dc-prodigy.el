;;; dc-prodigy.el --- summary -*- lexical-binding: t -*-

;; Author: David Conner
;; Maintainer: David Conner
;; Version: 0.0.1
;; Package-Requires: ()
;; Homepage: https://github.com/dcunited001/dotfiles_doom
;; Keywords: prodigy

;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; commentary

;;; Code:

(defun dc-prodigy-julia-pluto-args (args)
  "Assemble the args to pass to julia/pluto in a project's context"
  (or (getf args :project) ".")
  `("--threads=auto"
    "--project=" ,(or (getf args :project) ".")
    "-e" ,(format (or (getf args :e) "using Pluto; Pluto.run(port=%s)")
                 (or (getf args :port) "4321"))))

;; (dc-prodigy-julia-pluto-args '())

(prodigy-define-tag
  :name 'julia-pluto
  :command "julia"
  :cwd (file-name-as-directory
        (format "%s/%s" (getenv "_LANG") "julia/nb"))
  :args (prodigy-callback (service)
          (dc-prodigy-julia-pluto-args (getf service :pluto))))

(prodigy-define-service
  :name "julia-pluto"
  :tags '(julia-pluto)
  :pluto '())

;; currently getting:
;; /run/current-system/profile/bin/emacs: /data/lang/julia/.bin/julia: Exec format error

(provide 'dc-prodigy)

;;; dc-prodigy.el ends here
