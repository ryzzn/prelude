(defvar my-lua-indent 2
  "The number of spaces to insert for indentation")

(defun my-lua-enter ()
  "Inserts a newline and indents the line like the previous
non-empty line."
  (interactive)
  (newline)
  (indent-relative-maybe))

(defun my-lua-indent ()
  "Moves point to the first non-whitespace character of the
line if it is left of it. If point is already at that
position, or if it is at the beginning of an empty line,
inserts two spaces at point."
  (interactive)
  (when (looking-back "^\\s *")
    (if (looking-at "[\t ]")
        (progn (back-to-indentation)
               (when (looking-at "$")
                 (kill-line 0)
                 (indent-relative-maybe)
                 (insert (make-string my-lua-indent ? ))))
      (insert (make-string my-lua-indent ? )))))

(defun my-lua-setup ()
  "Binds ENTER to my-lua-enter and configures indentation the way
I want it. Makes sure spaces are used for indentation, not tabs."
  (setq indent-tabs-mode nil)
  (local-set-key "\r" 'my-lua-enter)
  (setq indent-line-function 'my-lua-indent))

;; add `my-lua-setup' as a call-back that is invoked whenever lua-mode
;; is activated.
(add-hook 'lua-mode-hook 'my-lua-setup)
(add-hook 'lua-mode-hook
          (lambda ()
            (setq safe-local-variable-values
                  '((lua-indent-level . 2)
                    (lua-indent-level . 3)
                    (lua-indent-level . 4)
                    (lua-indent-level . 8)))
            (flymake-lua-load)
            ))

(provide 'init-lua-mode)
