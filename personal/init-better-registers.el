(require 'better-registers)
(better-registers-install-save-registers-hook)
(load better-registers-save-file)

;;; I don't like bind C-j to it especially in minibuffer.
(define-key better-registers-map "\C-j" nil)
(define-key better-registers-map "\C-r" nil)

(provide 'init-better-registers)
