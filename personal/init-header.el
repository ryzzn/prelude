;;; header configuration

(require 'header2)

(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)
(setq header-date-format "%Y-%m-%dT%T%z")

(provide 'init-header)
