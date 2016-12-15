;;; Code:

(require 'easy-utils)

(add-auto-mode 'mail-mode "/mutt-sydi-[-0-9]+$")
(setq user-full-name "Shi Yudi")
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

                                        ;show ascii table
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (goto-char (point-min)))

;; http://stackoverflow.com/a/13407502/3627264
(add-hook 'sql-mode-hook
          (lambda ()
            (sql-highlight-mysql-keywords)))

;; Transparent background for emacs when using in terminal
;; (custom-set-faces
;;  '(default ((t (:background "unspecified" :foreground "#b3c4c6")))))

(defun ryzn/toggle-proxy-proxy ()
  (interactive)
  (if (bound-and-true-p url-proxy-services)
      (setq url-proxy-services nil)
    (setq url-proxy-services
          '(("no_proxy" . "^\\(localhost\\|10.*\\)")
            ("http" . "sydi.org:3328")
            ("https" . "sydi.org:3328")
            ;; ("http" . "10.23.8.125:3128")
            ;; ("https" . "10.23.8.125:3128")
            )))
  (message
   (if (bound-and-true-p url-proxy-services)
       "setting url proxy done!" "cancel url proxy done!"))
  )

;; disable auto save undo history to file because /tmp directory write
;; latency is too high.
(setq undo-tree-auto-save-history nil)

;; auto insert symbol at point when using ag to search
(setq helm-ag-insert-at-point 'symbol)

;; disable magit auto revert
(setq magit-auto-revert-mode nil)

;; my personal gcc
(setq-default flycheck-c/c++-gcc-executable "/home/fufeng.syd/.local/bin/gcc")
(setq-default flycheck-gcc-args '("-D__STDC_LIMIT_MACROS"
                                  "-std=gnu++11"
                                  "-DSTDC_HEADERS=1"
                                  "-DHAVE_SYS_TYPES_H=1"
                                  "-DHAVE_SYS_STAT_H=1"
                                  "-DHAVE_STDLIB_H=1"
                                  "-DHAVE_STRING_H=1"
                                  "-DHAVE_MEMORY_H=1"
                                  "-DHAVE_STRINGS_H=1"
                                  "-DHAVE_INTTYPES_H=1"
                                  "-DHAVE_STDINT_H=1"
                                  "-DHAVE_UNISTD_H=1"
                                  "-DHAVE_DLFCN_H=1"
                                  "-I."
                                  "-I/home/fufeng.syd/code/dev/src/observer"
                                  "-I/home/fufeng.syd/ins/tblib/include/tbsys"
                                  "-I/home/fufeng.syd/ins/easy/include/easy"
                                  "-I/home/fufeng.syd/code/dev/include"
                                  "-I/home/fufeng.syd/code/dev/src"
                                  "-I/home/fufeng.syd/code/oblib/src"
                                  "-Wall"
                                  "-Werror"
                                  "-Wextra"
                                  "-Wunused-parameter"
                                  "-Wformat"
                                  "-Wconversion"
                                  "-Wno-deprecated"
                                  "-fno-strict-aliasing"
                                  "-I/usr/include""-I/usr/include/mysql"
                                  "-Weffc++"
                                  ))

(setq-default flycheck-disabled-checkers '(c/c++-clang))

;; (defadvice flymake-find-buildfile
;;     (around advice-find-makefile-separate-obj-dir
;;             activate compile)
;;   "Look for buildfile in a separate build directory"
;;   (let* ((source-dir (ad-get-arg 1))
;;          (bld-dir (ac-build-dir source-dir)))
;;     (ad-set-arg 1 bld-dir)
;;     ad-do-it))

;; (defun ac-find-configure (source-dir)
;;   (locate-dominating-file source-dir "configure"))

;; (defvar project-build-root "/home/fufeng.syd/code/dev/build/"
;;   "top build directory of the project")

;; (defun ac-build-dir (source-dir)
;;   "find the build directory for the given source directory"
;;   (condition-case nil
;;       (let* ((topdir (ac-find-configure source-dir))
;;              (subdir (file-relative-name (file-name-directory source-dir) topdir))
;;              (blddir (concat (file-name-as-directory project-build-root) subdir)))
;;         (locate-dominating-file blddir "Makefile"))
;;     (error source-dir)))

(provide 'init-misc)
;;; init-misc.el ends here
