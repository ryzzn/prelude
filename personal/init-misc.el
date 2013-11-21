;;; Code:

(require 'easy-utils)

(add-auto-mode 'mail-mode "/mutt-sydi-[-0-9]+$")
(setq user-full-name "Yudi Shi")
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
