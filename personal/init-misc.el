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
            )))
  (message
   (if (bound-and-true-p url-proxy-services)
       "setting url proxy done!" "cancel url proxy done!"))
  )


(provide 'init-misc)
;;; init-misc.el ends here
