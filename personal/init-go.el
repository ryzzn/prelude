;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

(prelude-require-package 'use-package)

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;; (use-package lsp-mode
;;   :ensure t
;;   :defer t
;;   :hook (lsp-mode . (lambda ()
;;                       (let ((lsp-keymap-prefix "C-c l"))
;;                         (lsp-enable-which-key-integration))))
;;   :init
;;   (setq lsp-keep-workspace-alive nil
;;         lsp-signature-doc-lines 5
;;         lsp-idle-delay 0.5
;;         lsp-prefer-capf t
;;         lsp-client-packages nil)
;;   :config
;;   (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
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

;;Custom Compile Command
(with-eval-after-load 'go-mode
  (defun go-mode-setup ()
    ;; (linum-mode 1)
    ;; (go-eldoc-setup)
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
    (setq compilation-read-command nil)
    ;;  (define-key (current-local-map) "\C-c\C-c" 'compile)
    (local-set-key (kbd "M-.") 'xref-find-definitions)
    (local-set-key (kbd "M-,") 'xref-pop-marker-stack)

    ;; ;; Set up before-save hooks to format buffer and add/delete imports.
    ;; ;; Make sure you don't have other gofmt/goimports hooks enabled.
    ;; (defun lsp-go-install-save-hooks ()
    ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
    ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
    ;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

    ;; ;; Optional - provides fancier overlays.
    ;; (use-package lsp-ui
    ;;              :ensure t
    ;;              :commands lsp-ui-mode)

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
    )

  (add-hook 'go-mode-hook 'go-mode-setup)

  ;;Load auto-complete
  ;; (ac-config-default)
  ;; (require 'auto-complete-config)
  ;; (require 'go-autocomplete)
  (prelude-require-package 'lsp-mode)

  ;;Go rename
  (prelude-require-package 'go-rename)

  ;;Configure golint
  (add-to-list 'load-path (concat (getenv "GOPATH")
                                  "/src/github.com/golang/lint/misc/emacs"))
  (prelude-require-package 'golint)

  ;;Smaller compilation buffer
  (setq compilation-window-height 14)
  (defun my-compilation-hook ()
    (when (not (get-buffer-window "*compilation*"))
      (save-selected-window
        (save-excursion
          (let* ((w (split-window-vertically))
                 (h (window-height w)))
            (select-window w)
            (switch-to-buffer "*compilation*")
            (shrink-window (- h compilation-window-height)))))))
  (add-hook 'compilation-mode-hook 'my-compilation-hook)

  ;;Other Key bindings
  (global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

  ;;Compilation autoscroll
  (setq compilation-scroll-output t)
  )
