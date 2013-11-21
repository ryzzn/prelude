;; written by zhuweng@taobao-inc
;;; Change Log:
;; 2012-08-03    fufeng@taobao
;;    emacs 24 doesn't back compatible for `c-beginning-of-statement-1',
;;    change implement of indent of access lable.

(require 'cc-langs)

;; Create my personal c style which follows the coding standard of the OceanBase project
(defconst oceanbase-c-style
  '((c-basic-offset . 2)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open before after)
				   (brace-list-open)))
    (c-offsets-alist (statement-block-intro . +)
		     (substatement-open . 0)
		     (inline-open . 0)
		     (substatement-label . 0)
		     (statement-cont . +)
		     (case-label . +)
		     (inclass . ++)
		     (access-label . -)
		     (topmost-intro . 0)
		     )
    )
  "C/C++ Programming Style for OceanBase project\nThis style is a modification of stroustrup style. ")

(c-add-style "oceanbase" oceanbase-c-style)

(provide 'oceanbase-style)
