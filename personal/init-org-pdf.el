(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))

(require 'org-install)
(require 'ox-latex)
(require 'ox-beamer)

;; 取消^和_字体上浮和下沉的特殊性
(setq org-export-with-sub-superscripts nil)
;; 使用xelatex一步生成PDF
(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-file-apps '("pdf" . "zathura %s"))

;; code执行免应答（Eval code without confirm）
(setq org-confirm-babel-evaluate nil)
;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(defun org-mode-article-modes ()
  (reftex-mode t)
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))
(add-hook 'org-mode-hook
          (lambda ()
            (if (member "REFTEX" org-todo-keywords-1)
                (org-mode-article-modes))))

(add-to-list 'org-latex-classes
             '("cn-article"
               "\\documentclass{article}
[NO-DEFAULT-PACKAGES]
[EXTRA]
[PACKAGES]
\\renewcommand{\\contentsname}{目录}
\\definecolor{codebg}{rgb}{0.9,0.9,0.9}
\\setlength{\\headheight}{15pt}
"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("mybeamer"
               "
\\documentclass[presentation]{beamer}
\\definecolor{codebg}{rgb}{0.9,0.9,0.9}
\\setlength{\\headheight}{15pt}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))


(add-to-list 'org-latex-classes
             '("org-article"
               "\\documentclass{org-article}
\\usepackage{graphicx}
\\usepackage{color}
\\usepackage{lmodern}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{geometry}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage{fontspec,xunicode,xltxtra}
\\usepackage{minted}
\\fancyfoot[C]{\\bfseries\\thepage}
\\pagestyle{fancy}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; Make Org use ido-completing-read for most of its completing prompts.
(setq org-completion-use-ido t)
;; 各种Babel语言支持
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (sh . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (js . t)
   ))


;; use minted as code colorizing tool
(setq
 org-latex-listings nil
 org-latex-minted-options '(("bgcolor" "codebg")
                            ("linenos" "false")
                            ("frame" "lines")
                            ("numbersep" "5pt")
                            ("framesep" "2mm"))
 )

;; (setq org-latex-default-packages-alist
;;       '(("" "fixltx2e" nil)
;;         ("" "graphicx" t)
;;         ("" "longtable" nil)
;;         ("" "float" nil)
;;         ("" "wrapfig" nil)
;;         ("" "soul" t)
;;         ("" "textcomp" t)
;;         ("" "marvosym" t)
;;         ("" "wasysym" t)
;;         ("" "latexsym" t)
;;         ("" "amssymb" t)
;;         ("" "hyperref" nil)
;;         ("" "zhfontcfg" nil)
;;         ("" "listings" nil)
;;         ("AUTO" "inputenc" t)
;;         ;; ("" "verbatim" nil)
;;         "\\tolerance=1000"))

(setq org-latex-packages-alist
      '(("" "graphicx" nil)
        ("" "color" nil)
        ("usenames,dvipsnames" "xcolor" nil)
        ("" "lmodern" nil)
        ("" "verbatim" nil)
        ("" "fixltx2e" nil)
        ("" "longtable" nil)
        ("" "float" nil)
        ("" "tikz" nil)
        ("" "wrapfig" nil)
        ("" "soul" nil)
        ("" "textcomp" nil)
        ("" "geometry" nil)
        ("" "algorithmic" nil)
        ("" "marvosym" nil)
        ("" "wasysym" nil)
        ("" "latexsym" nil)
        ("" "natbib" nil)
        ("" "zhfontcfg" nil)
        ;; ("" "fancyhdr" nil)
        ("" "fontspec" nil)
        ("" "xunicode" nil)
        ("" "xltxtra" nil)
        ("" "minted" nil)
        ("" "ulem" nil)
        ("" "fancyhdr" nil)
        ("xetex,colorlinks=true,CJKbookmarks=true,linkcolor=blue,urlcolor=blue,menucolor=blue" "hyperref" nil)
        "\\hypersetup{unicode=true}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\tolerance=1000
"))


(setq ps-paper-type 'a4
      ps-font-size 16.0
      ps-print-header nil
      ps-landscape-mode nil)

(provide 'init-org-pdf)
