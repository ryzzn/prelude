;; (setq ediff-make-buffers-readonly-at-startup t)

;; Some custom configuration to ediff
(defvar my-ediff-bwin-config nil "Window configuration before ediff.")
(defcustom my-ediff-bwin-reg ?b
  "*Register to be set up to hold `my-ediff-bwin-config'
configuration.")

(defvar my-ediff-awin-config nil "Window configuration after ediff.")
(defcustom my-ediff-awin-reg ?e
  "*Register to be used to hold `my-ediff-awin-config' window
configuration.")

(defun my-ediff-bsh ()
  "Function to be called before any buffers or window setup for
ediff."
  (setq my-ediff-bwin-config (current-window-configuration))
  (when (characterp my-ediff-bwin-reg)
    (set-register my-ediff-bwin-reg
                  (list my-ediff-bwin-config (point-marker)))))

(defun my-ediff-ash ()
  "Function to be called after buffers and window setup for ediff."
  (setq my-ediff-awin-config (current-window-configuration))
  (when (characterp my-ediff-awin-reg)
    (set-register my-ediff-awin-reg
                  (list my-ediff-awin-config (point-marker)))))

(defun my-ediff-qh ()
  "Function to be called when ediff quits."
  (when my-ediff-bwin-config
    (set-window-configuration my-ediff-bwin-config)))

(add-hook 'ediff-before-setup-hook 'my-ediff-bsh)
(add-hook 'ediff-after-setup-windows-hook 'my-ediff-ash 'append)
(add-hook 'ediff-quit-hook 'my-ediff-qh)

(add-hook 'ediff-mode-hook
          (lambda ()
            (set-face-foreground
             ediff-current-diff-face-A "#ffffff")
            (set-face-background
             ediff-current-diff-face-A "#009900")
            (set-face-foreground
             ediff-fine-diff-face-A "#ffffff")
            (make-face-bold
             ediff-fine-diff-face-A)
            (set-face-background
             ediff-fine-diff-face-A "#CC3333")
            (set-face-background
             ediff-odd-diff-face-A "#444444")
            (set-face-foreground
             ediff-odd-diff-face-A "#ffffff")
            (set-face-foreground
             ediff-current-diff-face-B "#ffffff")
            (set-face-background
             ediff-current-diff-face-B "#009900")
            (set-face-foreground
             ediff-fine-diff-face-B "#ffffff")
            (make-face-bold
             ediff-fine-diff-face-B)
            (set-face-background
             ediff-fine-diff-face-B "#CC3333")
            (set-face-background
             ediff-odd-diff-face-B "#444444")
            (set-face-foreground
             ediff-odd-diff-face-B "#ffffff")
            (set-face-background
             ediff-odd-diff-face-A "#444444")
            (set-face-foreground
             ediff-odd-diff-face-A "#ffffff")
            (set-face-background
             ediff-even-diff-face-B "#444444")
            (set-face-foreground
             ediff-even-diff-face-B "#ffffff")
            (set-face-background
             ediff-even-diff-face-A "#444444")
            (set-face-foreground
             ediff-even-diff-face-A "#ffffff")
            ))

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

(provide 'prelude-ediff)
