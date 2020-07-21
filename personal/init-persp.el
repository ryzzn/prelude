;;; init-persp.el ---
;;
;; Filename: init-persp.el
;; Description:
;; Author: Shi Yudi
;; Maintainer:
;; Created: 2017-10-16T14:22:37+0800
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 7
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

(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil) ;; switch off animation
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

(setq persp-keymap-prefix (kbd "C-x x"))

;; eshell
(persp-def-buffer-save/load
 :mode 'eshell-mode :tag-symbol 'def-eshell-buffer
 :save-vars '(major-mode default-directory))

;; compile
(persp-def-buffer-save/load
 :mode 'compilation-mode :tag-symbol 'def-compilation-buffer
 :save-vars '(major-mode default-directory compilation-directory
                         compilation-environment compilation-arguments))

;; magit-status
(with-eval-after-load "magit-autoloads"
  (autoload 'magit-status-mode "magit")
  (autoload 'magit-refresh "magit")
  (persp-def-buffer-save/load
   :mode 'magit-status-mode :tag-symbol 'def-magit-status-buffer
   :save-vars '(major-mode default-directory)
   :after-load-function #'(lambda (b &rest _)
                            (with-current-buffer b (magit-refresh)))))

(provide 'init-persp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-persp.el ends here
