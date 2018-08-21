.PHONY: install

install: README.org
	@ emacs --batch --quick \
		--load ob-tangle \
		--eval '(setq org-src-preserve-indentation t)' \
		--eval '(org-babel-tangle-file "$<")'
	@ mkdir -p ~/.helm/plugins/outdated
	@ stow -t ~/.helm/plugins/outdated .
