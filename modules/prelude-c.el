;;; prelude-c.el --- Emacs Prelude: cc-mode configuration.
;;
;; Copyright © 2011-2013 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for cc-mode and the modes derived from it.

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

(require 'prelude-programming)
(require 'new-oceanbase-style)

(defun ryzn/get-real-builddir ()
  "Get relative object path of source code directory.
Default build directory is set as 'build'."
  (interactive)
  (let* ((src-topdir (file-name-directory (get-closest-pathname "configure.ac")))
         (build-topdir (concat src-topdir "/build"))
         (rel-curdir (file-relative-name (file-name-directory (get-closest-pathname "Makefile.am")) src-topdir))
         (build-path (expand-file-name (concat build-topdir "/" rel-curdir))))
    build-path
    (message build-path)
    ))

;; C/C++ SECTION
(defun sydi/c++-mode-hook()
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)
  (local-set-key "\M-f" 'c-forward-into-nomenclature)
  (local-set-key "\M-b" 'c-backward-into-nomenclature)
  (setq cc-search-directories '("." ".." "/usr/include" "/usr/local/include/*"))
  (setq c-style-variables-are-local-p nil)
  ;; (setq c-auto-newline t)

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  ;; (setq lazy-lock-defer-contextually t)
  ;; (setq lazy-lock-defer-time 0)

  (ggtags-mode 1)

  (new-oceanbase-style)

  ;; make the ENTER key indent next line properly
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key (kbd "RET") 'newline-and-indent)

  (local-set-key (kbd "M-`") (lambda ()
                               (interactive)
                               (let ((default-directory (ryzn/get-real-builddir)))
                                 (compile "make -j10"))))
  (local-set-key (kbd "M-~") 'recompile)

  ;; @see https://github.com/seanfisk/cmake-flymake
  ;; make sure you project use cmake
  ;; (flymake-mode)
  )

;; c++-mode for h files.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

(defun prelude-c-mode-common-defaults ()
  (sydi/c++-mode-hook))

(setq prelude-c-mode-common-hook 'prelude-c-mode-common-defaults)

;; this will affect all modes derived from cc-mode, like
;; java-mode, php-mode, etc
(add-hook 'c-mode-common-hook
          (lambda () (run-hooks 'prelude-c-mode-common-hook)))

(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))
(provide 'prelude-c)

;;; prelude-c.el ends here
