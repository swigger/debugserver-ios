CC=aarch64-apple-darwin-gcc
FAKE_MOUNT_PATH=/mnt/dbgsrv64_node
DIRS=obj/debroot/DEBIAN obj/debroot$(FAKE_MOUNT_PATH)/Library/Lockdown/ServiceAgents obj/debroot/usr/bin

all:dbgsrv.deb

$(DIRS):
	-mkdir -p $@

dbgsrv.deb:dbgsrv64_notify control.txt net.swigger.dbgsrv64.plist |$(DIRS)
	cp control.txt obj/debroot/DEBIAN/control
	cp net.swigger.dbgsrv64.plist obj/debroot$(FAKE_MOUNT_PATH)/Library/Lockdown/ServiceAgents/
	cp dbgsrv64_notify obj/debroot/usr/bin/
	cp ../dbgsrv64 obj/debroot/usr/bin/
	dpkg-deb --root-owner-group -b -Zgzip obj/debroot $@

dbgsrv64_notify:dbgsrv64_notify.c
	$(CC) -o $@ $<

clean:
	-@ rm -f dbgsrv.deb
	-@ rm -fr obj/

.DELETE_ON_ERROR:
.PHONY: all clean
