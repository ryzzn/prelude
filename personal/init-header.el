;;; header configuration

(require 'header2)

(eval-after-load 'header2
  '(progn
     (setq header-date-format "%Y-%m-%d %T (%z)")
     ))

(add-hook 'before-save-hook 'update-file-header)
(provide 'init-header)
