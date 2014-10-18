;;; prelude-dot.el --- graphviz dot config for emacs prelude
;;
;; Filename: prelude-dot.el
;; Description:
;; Author: Shi Yudi
;; Maintainer:
;; Created: 2014-10-18T15:49:16+0800
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 24
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'graphviz-dot-mode)

(add-hook 'graphviz-dot-mode-hook
          (lambda ()
            (setq graphviz-dot-view-edit-command nil)
            (setq graphviz-dot-auto-indent-on-newline nil)
            (setq graphviz-dot-indent-width 4)
            (setq graphviz-dot-auto-indent-on-semi nil)
            (setq graphviz-dot-view-command "feh %s")

            (define-key graphviz-dot-mode-map (kbd "\C-c\C-P") 'graphviz-dot-preview)
            ))


(provide 'prelude-dot)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; prelude-dot.el ends here
