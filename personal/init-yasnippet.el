(require 'yasnippet)

;; default TAB key is occupied by auto-complete
(global-set-key (kbd "C-c k") 'yas-expand)
(add-hook 'yas-after-exit-snippet-hook
          '(lambda ()
             (indent-region yas-snippet-beg yas-snippet-end)))
(global-set-key (kbd "C-c k") 'yas-expand)

;; ;; give yas-dropdown-prompt in yas-prompt-functions a chance
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt
                             yas-ido-prompt
                             yas-completing-prompt))
;; use yas-completing-prompt when ONLY when `M-x yas-insert-snippet'
;; thanks to capitaomorte for providing the trick.
(defadvice yas-insert-snippet (around use-completing-prompt activate)
  "Use `yas-completing-prompt' for `yas-prompt-functions' but only here..."
  (let ((yas-prompt-functions '(yas-completing-prompt)))
    ad-do-it))

(setq yas-triggers-in-field t)

;; Inter-field navigation
(defun yas-goto-end-of-active-field ()p
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-end (yas--snippet-active-field snippet))))
    (goto-char position)))

(defun yas-goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-start (yas--snippet-active-field snippet))))
    (goto-char position)))

(define-key yas-keymap (kbd "C-e") 'yas-goto-end-of-active-field)
(define-key yas-keymap (kbd "C-a") 'yas-goto-start-of-active-field)

;; C-k in a field
(defun yas-clear-current-field ()
  (interactive)
  (let ((field (and yas-active-field-overlay
                    (overlay-buffer yas-active-field-overlay)
                    (overlay-get yas-active-field-overlay 'yas-field))))
    (and field (delete-region (point) (yas--field-end field)))))

(define-key yas-keymap (kbd "C-k") 'yas-clear-current-field)

;;; set yasnippet directory
(setq yas-snippet-dirs "~/.emacs.d/snippets")
;; (unless (file-exists-p yas-root-directory)
;;   (make-directory yas-root-directory))
;; (yas-load-directory yas-root-directory)

(yas-global-mode 1)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
