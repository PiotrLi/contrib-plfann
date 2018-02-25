LIBS=$(shell pkg-config --libs fann)
VERSION=$(shell swipl -q -t "version(X),write(X)" pack.pl)

default_target: all

all:
	make compile
	make package

compile:
	swipl-ld -o bin/plfann -shared src/plfann.c $(LIBS)

check::
	swipl -q -g main,halt example.pl

install:: package
	swipl -g "pack_install('plfann-$(VERSION).tgz'),halt"

remove::
	swipl -g "pack_remove(plfann),halt"
	
package: compile
	tar zcvf "plfann-$(VERSION).tgz" pack.pl prolog/plfann.pl bin/plfann.so

clean::
	rm -f *~ ./*/*~ ./bin/*.so


