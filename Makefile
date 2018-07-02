.PHONY: package

VERSION ?= 0.0.0
CONFIG_PREFIX ?= 

.PHONY: deb
deb: ## create a debian package
	-rm *.deb
	nfpm pkg -f ${CONFIG_PREFIX}nfpm.yaml --target ${CONFIG_PREFIX}bash-functions_${VERSION}.deb

.PHONY: rpm
rpm: ## create a redhat package
	@echo rpm not in use

package: deb rpm ## create packages

test: ## run test.sh, copy config before
	./test.sh

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
