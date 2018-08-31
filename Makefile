.DEFAULT: install
.PHONY: install
install: README.org
	@ emacs --batch --quick \
		--load ob-tangle \
		--eval '(setq org-src-preserve-indentation t)' \
		--eval '(org-babel-tangle-file "$<")'
	@ mkdir -p "$${HELM_HOME:-$$HOME/.helm}/plugins/outdated"
	@ stow -t "$${HELM_HOME:-$$HOME/.helm}/plugins/outdated" .
