NAME=amonredis
DOC_FILES=index.restdown

include ./tools/mk/Makefile.defs

TAR=tar
RELEASE_TARBALL=$(NAME)-pkg-$(STAMP).tar.bz2
CLEAN_FILES += $(NAME)-pkg-*.tar.bz2


#
# Targets
#

.PHONY: all

all: sdc-scripts

release: $(RELEASE_TARBALL)

$(RELEASE_TARBALL):
	TAR=$(TAR) bash package.sh $(RELEASE_TARBALL)

publish:
	@if [[ -z "$(BITS_DIR)" ]]; then \
		echo "error: 'BITS_DIR' must be set for 'publish' target"; \
		exit 1; \
	fi
	mkdir -p $(BITS_DIR)/$(NAME)
	cp $(RELEASE_TARBALL) $(BITS_DIR)/$(NAME)/$(RELEASE_TARBALL)


include ./tools/mk/Makefile.deps
include ./tools/mk/Makefile.targ

sdc-scripts: deps/%/.git
