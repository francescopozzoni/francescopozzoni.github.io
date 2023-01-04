# Makefile for myblog

.PHONY: all publish publish_no_init

all: publish

publish: publish.el
	@echo "Publishing... with current Emacs configurations."
	emacs --batch --load publish.el --funcall org-publish-all

publish_no_init: publish.el
	@echo "Publishing... with --no-init."
	emacs --batch --no-init --load publish.el --funcall org-publish-all

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf docs
	@rm -rvf ./.org-timestamps/*
	@rm -rvf sitemap.org

test:
	@echo "Running python test server... Visit http://127.0.0.1:8000"
	@python -m http.server --directory=docs
