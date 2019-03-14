INDIR=../../../
INCS=-I$(INDIR)tools/debugserver/source/MacOSX -I$(INDIR)tools/debugserver/source -I$(INDIR)tools/debugserver/source/MacOSX/DarwinLog
INCS+=-I$(INDIR)include -Iinc -Finc
MACROS=-Wparentheses -DWITH_LOCKDOWN -DWITH_FBS -DWITH_BKS -DDEBUGSERVER_PROGRAM_SYMBOL=dbgsrv64
CFLAGS=$(INCS) $(MACROS)  -fno-objc-arc
CXXFLAGS=$(INCS) $(MACROS) -fno-objc-arc -std=c++11
LDFLAGS=-sectcreate __TEXT __info_plist info.plist -framework Foundation
LDFLAGS+=-Finc -framework SpringBoardServices  -framework BackBoardServices -framework FrontBoardServices -framework MobileCoreServices -framework AssertionServices
LDFLAGS+=-lcompression -llockdown -lc++
CC=aarch64-apple-darwin-gcc
CXX=$(CC)
TARGET=dbgsrv64
SRC0:=$(shell cat src)
SRC=$(SRC0)

OBJS=$(addprefix obj/,$(addsuffix .o,$(basename $(SRC))))
DIRS=$(sort $(dir $(OBJS)))

all:$(TARGET)

$(DIRS):
	-mkdir -p $@

$(OBJS):|$(DIRS)

obj/%.o:$(INDIR)%.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/%.o:$(INDIR)%.mm
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/%.o:%.c
	$(CC) -c $(CFLAGS) -o $@ $<

dbgnub-migServer.c dbgnub-migUser.c:$(INDIR)tools/debugserver/source/MacOSX/dbgnub-mig.defs
	aarch64-apple-darwin-mig  -header dbgnub-mig.h -user dbgnub-migUser.c -sheader dbgnub-migServer.h -server dbgnub-migServer.c  $^

clean:
	-@ rm -f dbgnub-mig* $(OBJS) $(TARGET) $(TARGET).dbg
	-@ rm -fr obj/

$(TARGET):$(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	cp $@ $@.dbg
	strip $@
	ldid -Sent2.xml -Inet.swigger.dbgsrv64 $@.dbg
	ldid -Sent2.xml -Inet.swigger.dbgsrv64 $@

install:
	ssh jbios rm -f /usr/bin/dbgsrv64
	scp dbgsrv64 jbios:/usr/bin/

.DELETE_ON_ERROR:
.PHONY: all install clean
