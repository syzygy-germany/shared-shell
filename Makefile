# .PHONY: package
package: ## create debian package
	echo a

# .PHONY: config
config: ## copy config
	mkdir -p /etc/sascha-andres/shared-shell
	cp sys-config/config.sh /etc/sascha-andres/shared-shell/config

test: ## run test.sh, copy config before
	sudo make config
	./test.sh

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
