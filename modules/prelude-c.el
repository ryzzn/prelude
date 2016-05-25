;;; prelude-c.el --- Emacs Prelude: cc-mode configuration.
;;
;; Copyright © 2011-2015 Bozhidar Batsov
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

(defun ryzn/get-real-builddir (&optional upper)
  "Get relative object path of source code directory.
Default build directory is set as 'build'.
`UPPER' means how many count should ignore Compile file."
  (interactive)

  (defun go-upper (upper)
    (let ((get-dir (file-name-directory (get-closest-pathname "Makefile.am"))))
      (if (or (not upper) (= 0 upper))
          get-dir
          (let ((default-directory (file-name-directory (directory-file-name get-dir))))
            (go-upper (1- upper))))))

  (let* ((src-topdir (file-name-directory (get-closest-pathname "configure.ac")))
         (build-topdir (concat src-topdir "/build"))
         (rel-curdir (file-relative-name (go-upper upper) src-topdir)))
    (message rel-curdir)
    (expand-file-name (concat build-topdir "/" rel-curdir))))

(defun ryzn/build (upper)
  "Compile project with directory by finding `UPPER' latest Makefile."
  (interactive "NGo Upper Count: ")
  (let ((default-directory (ryzn/get-real-builddir upper)))
    (compile "make -s -j10 LIBTOOLFLAGS=--silent")))

;; C/C++ SECTION
(defun sydi/c++-mode-hook()
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)
  (local-set-key "\M-f" 'c-forward-into-nomenclature)
  (local-set-key "\M-b" 'c-backward-into-nomenclature)
  (setq cc-search-directories '("." ".." "/usr/include" "/usr/local/include/*"))
  (setq c-style-variables-are-local-p nil)
  (setq c-auto-newline nil)

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  ;; (setq lazy-lock-defer-contextually t)
  ;; (setq lazy-lock-defer-time 0)

  (ggtags-mode 1)

  (new-oceanbase-style)

  ;; make the ENTER key indent next line properly
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key (kbd "RET") 'newline-and-indent)

  (local-set-key (kbd "M-`") 'ryzn/build)
  (local-set-key (kbd "M-~") 'recompile)

  (sydi/company-cc-mode-setup)

  ;; @see https://github.com/seanfisk/cmake-flymake
  ;; make sure you project use cmake
  ;; (flymake-mode)

  (add-hook 'ff-pre-find-hook
          (lambda ()
            (when (string-match ".*/src/" buffer-file-name)
              (add-to-list ff-search-directories (match-string 0 buffer-file-name))
              (message (match-string 0 buffer-file-name)))))
  )

;; c++-mode for h files.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

(defun prelude-c-mode-common-defaults ()
  "Some docstring."
  (setq
   c-default-style "k&r"
   c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
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
                                (run-hooks 'prelude-makefile-mode-hook))) (provide 'prelude-c)

;;; prelude-c.el ends here
