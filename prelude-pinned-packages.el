;;; prelude-pinnned-packages.el --- Initialization file for Emacs
;;;

;;; Commentary:
;;

;;; Code:

(if (eq system-type 'windows-nt)
    (setq package-archives
          '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
            ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")))
  (setq package-archives
        '(("gnu"   . "https://mirrors.cloud.tencent.com/elpa/gnu/")
          ("melpa" . "https://mirrors.cloud.tencent.com/elpa/melpa/"))))

(provide 'prelude-pinned-packages)

;;; prelude-pinned-packages.el ends here
