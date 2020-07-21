;;; prelude-php.el --- Emacs prelude: php mode settings
;;
;; Filename: prelude-php.el
;; Description:
;; Author: Shi Yudi
;; Maintainer:
;; Created: 2016-07-22T10:43:20+0800
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 9
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

(defun prelude-php-mode()
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key php-mode-map [return] 'newline-and-indent)
  (define-key php-mode-map [(control c) (r)] 'php-run)
  (define-key php-mode-map [(control c) (d)] 'php-debug)

  (defun ywb-php-lineup-arglist-intro (langelem)
    (save-excursion
      (goto-char (cdr langelem))
      (vector (+ (current-column) c-basic-offset))))
  (defun ywb-php-lineup-arglist-close (langelem)
    (save-excursion
      (goto-char (cdr langelem))
      (vector (current-column))))

  (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
  (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)
  (c-set-style "drupal")
  )

(add-hook 'php-mode-hook 'prelude-php-mode)

(provide 'prelude-php)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; prelude-php.el ends here
