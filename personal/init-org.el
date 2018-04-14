;;; init-org.el ---
;;
;; Filename: init-org.el
;; Description:
;; Author: Shi Yudi
;; Maintainer:
;; Created: 2015-01-03T10:17:31+0800
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 7
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'org)
(require 'org-agenda)
(require 'org-clock)

(eval-after-load 'org
  '(progn
     (require 'org-clock)

     ;; (require 'org-checklist)
     ;; (require 'org-fstree)
     (setq org-ditaa-jar-path
           (expand-file-name "~/.emacs.d/elpa/contrib/scripts/ditaa.jar"))
     (add-hook 'org-mode-hook 'soft-wrap-lines)
     (defun soft-wrap-lines ()
       "Make lines wrap at window edge and on word boundary,
        in current buffer."
       (interactive)
       (setq truncate-lines nil)
       (setq word-wrap t))

     ;; http://capitaomorte.github.com/yasnippet/faq.html
     ;; (add-hook 'org-mode-hook
     ;;           (let ((original-command (lookup-key org-mode-map [tab])))
     ;;             `(lambda ()
     ;;                (setq yas/fallback-behavior
     ;;                      '(apply ,original-command))
     ;;                (local-set-key [tab] 'yas/expand))))

     ;; Various preferences
     (setq org-log-done t
           org-completion-use-ido t
           org-edit-src-content-indentation 0
           org-edit-timestamp-down-means-later t
           org-agenda-start-on-weekday nil
           org-agenda-span 14
           org-agenda-include-diary t
           org-agenda-window-setup 'current-window
           org-fast-tag-selection-single-key 'expert
           org-tags-column 80
           ;; @see http://irreal.org/blog/?p=671
           org-src-fontify-natively t
           org-startup-indented t
           ;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
           org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))
           ;; Targets start with the file name - allows creating level 1 tasks
           org-refile-use-outline-path 'file
           ;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
           org-outline-path-complete-in-steps t
           org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                               (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)")))
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load 'org-clock
  '(progn
     ;; Save the running clock and all clock history when exiting Emacs, load it on startup
     ;; (setq org-clock-persistence-insinuate t)
     (setq org-clock-persist t)
     (setq org-clock-in-resume t)

     ;; Change task state to STARTED when clocking in
     (setq org-clock-in-switch-to-state "STARTED")
     ;; Save clock data and notes in the LOGBOOK drawer
     (setq org-clock-into-drawer t)
     ;; Removes clocked tasks with 0:00 duration
     (setq org-clock-out-remove-zero-time-clocks t)

     ;; Show the clocked-in task - if any - in the header line
     (defun sanityinc/show-org-clock-in-header-line ()
       (setq-default header-line-format '((" " org-mode-line-string " "))))

     (defun sanityinc/hide-org-clock-from-header-line ()
       (setq-default header-line-format nil))

     (add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
     (add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
     (add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)
     ))


(eval-after-load 'org
  '(progn
     (custom-set-variables
      '(org-journal-dir "~/personal/org/journal")
      '(org-agenda-files (quote ("~/personal/org/todo-list.org")))
      '(org-default-notes-file "~/personal/org/notes.org")
      '(org-agenda-span 7)
      '(org-deadline-warning-days 14)
      '(org-agenda-show-all-dates t)
      '(org-agenda-skip-deadline-if-done t)
      '(org-agenda-skip-scheduled-if-done t)
      '(org-agenda-start-on-weekday nil)
      '(org-reverse-note-order t)
      '(org-fast-tag-selection-single-key (quote expert))
      '(org-agenda-custom-commands
        (quote (("d" todo "DELEGATED" nil)
                ("c" todo "DONE|DEFERRED|CANCELLED" nil)
                ("w" todo "WAITING" nil)
                ("W" agenda "" ((org-agenda-span 21)))
                ("A" agenda ""
                 ((org-agenda-skip-function
                   (lambda nil
                     (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
                  (org-agenda-span 1)
                  (org-agenda-overriding-header "Today's Priority #A tasks: ")))
                ("u" alltodo ""
                 ((org-agenda-skip-function
                   (lambda nil
                     (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                               (quote regexp) "\n]+>")))
                  (org-agenda-overriding-header "Unscheduled TODO entries: ")))))))
     (message "load org-mode")))

(provide 'init-org)

;;; init-org.el ends here
