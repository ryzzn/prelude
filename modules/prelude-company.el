;;; prelude-company.el --- company-mode setup
;;
;; Copyright © 2011-2016 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; company-mode config.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(prelude-require-packages '(company))

(require 'company)

(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)

;; clang stuff
;; @see https://github.com/brianjcj/auto-complete-clang
(defun sydi/company-cc-mode-setup ()
  (let ((clang-include-dir-list (list (concat (getenv "TBLIB_ROOT") "/include/tbsys")
                                      (concat (getenv "EASY_ROOT") "/include/easy")
                                      (get-closest-pathname "src"))))
    (setq company-clang-arguments
          (mapcar (lambda (item) (concat "-I" item)) clang-include-dir-list))
    (local-set-key (kbd "M-o") 'company-clang)
    ))

(custom-set-faces
 '(company-preview
   ((t (:foreground "darkgray" :underline t :background "blue"))))
 '(company-preview-search ((t (:inherit company-preview :background "blue1"))))
 '(company-preview-common
   ((t (:inherit company-preview :background "blue"))))
 '(company-tooltip
   ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((t (:background "steelblue" :foreground "white"))))
 '(company-tooltip-common
   ((((type x)) (:inherit company-tooltip :weight bold :background "blue"))
    (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :weight bold ))
    (t (:inherit company-tooltip-selection))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip))))
 '(company-tooltip ((t (:inherit font-lock-builtin-face))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "dark cyan")))))

(global-company-mode 1)

(provide 'prelude-company)
;;; prelude-company.el ends here
