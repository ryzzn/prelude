;;; Time-stamp: <2013-10-29 11:21:38 ryan>

;;; Code:
(require 'org-capture)
(defvar consumption-filename
  (concat "~/sydi.org/org/life/personal-consumption-"
          (downcase (format-time-string "%Y-%B")) ".org"))
(defvar interesting-links-filename
  (concat "~/sydi.org/org/reading/interesting-links-"
          (downcase (format-time-string "%Y-%B")) ".org"))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("w" "Work Journal" entry (file+datetree "~/org/work_journal.org")
         "* %?\nEntered on %U\n  %i\n")
        ("j" "Web Journal" entry (file "~/sydi.org/org/journal.org")
         "* %U\n%?%i" :prepend t)
        ("s" "OceanBase Senses" entry (file "~/sydi.org/org/oceanbase/senses.org")
         "* %U\n%?%i")
        ("o" "Reading Oceanbase" entry (file "~/documents/reading/oceanbase.org")
         "* %?\n [[%l][follow]] -- [%U]\n  %i")
        ("c" "consumption" table-line (file consumption-filename))
        ("l" "Interesting Reading Links" item (file interesting-links-filename))))

(provide 'init-org-capture)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org-capture.el ends here
