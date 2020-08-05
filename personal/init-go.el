;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

(prelude-require-package 'use-package)

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration)
         )
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-flycheck-enable nil))

;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

(use-package go-mode
  :init
  ;;Go rename
  (prelude-require-package 'go-rename)
  ;;Configure golint
  (prelude-require-package 'golint)

  :bind
  (("M-." . xref-find-definitions)
   ("M-," . xref-pop-marker-stack))

  :preface
  (defun go-mode-setup ()
    ;; (linum-mode 1)
    ;; (go-eldoc-setup)
    ;; (setq gofmt-command "goimports")
    (setq compilation-read-command nil)
    (setq tab-width 4)

    (if (package-installed-p 'super-save)
        (super-save-mode 0))


    ;; ;; Set up before-save hooks to format buffer and add/delete imports.
    ;; ;; Make sure you don't have other gofmt/goimports hooks enabled.
    ;; (defun lsp-go-install-save-hooks ()
    ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
    ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
    ;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

    ;; ;; Company mode is a standard completion package that works well with lsp-mode.
    ;; (use-package company
    ;;              :ensure t
    ;;              :config
    ;;              ;; Optionally enable completion-as-you-type behavior.
    ;;              (setq company-idle-delay 0)
    ;;              (setq company-minimum-prefix-length 1))

    ;; ;; Optional - provides snippet support.
    ;; (use-package yasnippet
    ;;              :ensure t
    ;;              :commands yas-minor-mode
    ;;              :hook (go-mode . yas-minor-mode))

    (setq read-process-output-max 1048576)
    (whitespace-toggle-options '(indentation::tab)))
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (go-mode-setup))))

;;Custom Compile Command
(with-eval-after-load 'go-mode
  ;;Load auto-complete
  ;; (ac-config-default)
  ;; (require 'auto-complete-config)
  ;; (require 'go-autocomplete)



  ;;Smaller compilation buffer
  ;; (setq compilation-window-height 14)
  ;; (defun my-compilation-hook ()
  ;;   (when (not (get-buffer-window "*compilation*"))
  ;;     (save-selected-window
  ;;       (save-excursion
  ;;         (let* ((w (split-window-vertically))
  ;;                (h (window-height w)))
  ;;           (select-window w)
  ;;           (switch-to-buffer "*compilation*")
  ;;           (shrink-window (- h compilation-window-height)))))))
  ;; (add-hook 'compilation-mode-hook 'my-compilation-hook)

  ;;Compilation autoscroll
  ;; (setq compilation-scroll-output t)
  )
