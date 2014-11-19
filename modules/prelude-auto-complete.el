;;; package --- Summary
;;; Commentary:
;;; Code:
;; @see http://cx4a.org/software/auto-complete/manual.html
(require 'auto-complete-config)
(prelude-require-package 'auto-complete-clang)

(global-auto-complete-mode t)
(setq ac-expand-on-auto-complete t)
(setq ac-auto-start t)
(setq ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB") ; AFTER input prefix, press TAB key ASAP

;; Use C-n/C-p to select candidate ONLY when completion menu is displayed
;; Below code is copied from official manual
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; extra modes auto-complete must support
(dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode
                js2-mode js3-mode css-mode less-css-mode))
  (add-to-list 'ac-modes mode))

;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  "Exclude very large buffers `OTHER-BUFFER' from dabbrev."
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(require 'dabbrev)
(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)

;; clang stuff
;; @see https://github.com/brianjcj/auto-complete-clang
(defun my-ac-cc-mode-setup ()
  (require 'auto-complete-clang)
  (setq ac-sources (append '(ac-source-clang) ac-sources))

  (setq clang-include-dir-str "
 /usr/include/c++/4.8.2
 /usr/include/c++/4.8.2/x86_64-unknown-linux-gnu
 /usr/include/c++/4.8.2/backward
 /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.2/include
 /usr/local/include
 /usr/lib/gcc/x86_64-unknown-linux-gnu/4.8.2/include-fixed
 /usr/include
")
  (setq ac-clang-flags
        (mapcar (lambda (item) (concat "-I" item))
                (split-string clang-include-dir-str)))

  ; (cppcm-reload-all)
  ; fixed rinari's bug
  (remove-hook 'find-file-hook 'rinari-launch)

  ; (setq ac-clang-auto-save t)
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

(ac-config-default)

(provide 'prelude-auto-complete)
;;; prelude-auto-complete.el ends here
