;;; prelude-dot.el --- graphviz dot config for emacs prelude
;;
;; Filename: prelude-dot.el
;; Description: graphviz dot config for emacs prelude
;; Author: Shi Yudi
;; Maintainer:
;; Created: 2014-10-18T15:49:16+0800
;; Version: 0.1
;; Package-Requires: (graphviz-dot-mode)
;; Last-Updated:
;;           By:
;;     Update #: 47
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
;; 19-Oct-2014    Shi Yudi
;;    add indentation
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

(prelude-require-package 'graphviz-dot-mode)
(require 'org)                          ; require `org-src-lang-modes'
(require 'graphviz-dot-mode)


(add-hook 'graphviz-dot-mode-hook
          (lambda ()
            (setq graphviz-dot-view-edit-command nil)
            (setq graphviz-dot-auto-indent-on-newline nil)
            (setq graphviz-dot-indent-width 4)
            (setq graphviz-dot-auto-indent-on-semi nil)

            (define-key graphviz-dot-mode-map (kbd "\C-c\C-P") 'graphviz-dot-preview)

            (setq indent-line-function 'ryzn/dot-indent-line)
            ))

(defun ryzn/dot-indent-line ()
  "Indent current line of dot code."
  (interactive)
  (if (bolp)
      (ryzn/dot-real-indent-line)
    (save-excursion
      (ryzn/dot-real-indent-line))))

(defun ryzn/dot-real-indent-line ()
  "Indent current line of dot code."
  (beginning-of-line)
  (cond
   ((bobp)
    ;; simple case, indent to 0
    (indent-line-to 0))
   ((looking-at "^[ \t]*}.*$")
    ;; block closing, deindent relative to previous line
    (indent-line-to (save-excursion
                      (forward-line -1)
                      (if (looking-at "\\(^.*{[^}]*$\\)")
                          ;; previous line opened a block
                          ;; use same indentation
                          (current-indentation)
                        (max 0 (- (current-indentation) graphviz-dot-indent-width))))))
   ((looking-at "^[ \t]*\\][ \t]*;?[ \t]*$")
    ;; block closing, deindent relative to previous line
    (indent-line-to (save-excursion
                      (while (and (< (point-min) (point))
                                  (not (looking-at "^.*\\[[^]]*$")))
                        (forward-line -1))
                      ;; found corresponding left block or first line
                      (current-indentation)
                      )))
   ;; other cases need to look at previous lines
   (t
    (indent-line-to (save-excursion
                      (forward-line -1)
                      (cond
                       ((looking-at "\\(^.*{[^}]*$\\)")
                        ;; previous line opened a block
                        ;; indent to that line
                        (+ (current-indentation) graphviz-dot-indent-width))
                       ((looking-at "^.*\\[[^]]*$")
                        ;; previous line started filling
                        ;; attributes, intend to that start
                        (+ (current-indentation) graphviz-dot-indent-width))
                       ((looking-at "^([^[])*\\].*$")
                        ;; previous line stopped filling
                        ;; attributes, find the line that started
                        ;; filling them and indent to that line
                        (while (not (looking-at "^.*\\[[^]]*$"))
                          (forward-line -1))
                        (current-indentation))
                       (t
                        ;; default case, indent the
                        ;; same as previous NON-BLANK line
                        ;; (or the first line, if there are no previous non-blank lines)
                        (while (and (< (point-min) (point))
                                    (looking-at "^[ \t]*$"))
                          (forward-line -1))
                        (current-indentation))))))))

(provide 'prelude-dot)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; prelude-dot.el ends here
