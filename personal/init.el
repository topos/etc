(add-hook 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-hook 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-hook 'auto-mode-alist '("rake$" . ruby-mode))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)