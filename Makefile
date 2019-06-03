#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2019, Joyent, Inc.
#

NAME=amonredis

ENGBLD_USE_BUILDIMAGE	= true
ENGBLD_REQUIRE		:= $(shell git submodule update --init deps/eng)
include ./deps/eng/tools/mk/Makefile.defs
TOP ?= $(error Unable to access eng.git submodule Makefiles.)

ifeq ($(shell uname -s),SunOS)
    include ./deps/eng/tools/mk/Makefile.agent_prebuilt.defs
endif

TAR=tar
RELEASE_TARBALL=$(NAME)-pkg-$(STAMP).tar.gz

BASE_IMAGE_UUID = a9368831-958e-432d-a031-f8ce6768d190
BUILDIMAGE_NAME = $(NAME)
BUILDIMAGE_DESC	= SDC Amon Redis
AGENTS		= amon config registrar

#
# Targets
#

.PHONY: all
all: sdc-scripts

release: all $(RELEASE_TARBALL)

$(RELEASE_TARBALL):
	TAR=$(TAR) bash package.sh $(RELEASE_TARBALL)

publish:
	mkdir -p $(ENGBLD_BITS_DIR)/$(NAME)
	cp $(RELEASE_TARBALL) $(ENGBLD_BITS_DIR)/$(NAME)/$(RELEASE_TARBALL)

sdc-scripts: deps/sdc-scripts/.git

ifeq ($(shell uname -s),SunOS)
    include ./deps/eng/tools/mk/Makefile.agent_prebuilt.targ
endif
include ./deps/eng/tools/mk/Makefile.deps
include ./deps/eng/tools/mk/Makefile.targ
