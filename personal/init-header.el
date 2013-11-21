;;; header configuration

(require 'header2)

(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)

(provide 'init-header)
