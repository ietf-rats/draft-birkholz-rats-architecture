# asciio is from https://metacpan.org/pod/App::Asciio, apt-get install asciio
# 
LIBDIR := lib
include $(LIBDIR)/main.mk

# Asciio has no command line to format to txt, sorry, use GUI :-(
# wholeflow.txt: wholeflow.asciio

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b master https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
