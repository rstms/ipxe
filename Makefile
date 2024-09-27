
UID != id -u
GID != id -g
USER != whoami
ARGS = UID GID USER 
BUILDER = ipxe-builder
ISO = src/bin/ipxe.iso
IPXE_SOURCE != find src -type f | egrep '.*\.(h|c)$$'
VOLUMES = \
  -v $(PWD)/src:/home/$(USER)/src \
  -v $(PWD)/certs:/home/$(USER)/certs \
  -v $(PWD)/menus:/home/$(USER)/menus \
  -v $(PWD)/config/colour.h:/home/$(USER)/src/config/local/colour.h \
  -v $(PWD)/config/console.h:/home/$(USER)/src/config/local/console.h \
  -v $(PWD)/config/crypto.h:/home/$(USER)/src/config/local/crypto.h \
  -v $(PWD)/config/general.h:/home/$(USER)/src/config/local/general.h

#CERTS = ../certs/root.pem,../certs/intermediate.pem,../certs/netboot_client.pem
#TRUST = ../certs/root.pem,../certs/intermediate.pem
CERTS = ../certs/root.pem,../certs/netboot_client.pem
TRUST = ../certs/root.pem

CERT_FILES = certs/root.pem certs/netboot_client.pem certs/netboot_client.key
NETBOOT_MENUS = menus/netboot.ipxe menus/netboot-debian.ipxe menus/netboot-openbsd.ipxe
LOCALBOOT_MENUS = menus/localboot.ipxe menus/localboot-debian.ipxe menus/localboot-openbsd.ipxe

BUILD_ARGS = $(foreach ARG,$(ARGS),--build-arg $(ARG)=$($(ARG)) )

BUILD = docker run -it --rm --hostname $(BUILDER) $(VOLUMES) $(BUILDER) /bin/bash -c '$(1)'

upload: netboot localboot

netboot: bin/netboot.iso bin/netboot.img $(NETBOOT_MENUS)
	./scripts/deploy netboot netboot.rstms.net
	./scripts/deploy netboot localboot.rstms.net

localboot: bin/localboot.iso bin/localboot.img $(LOCALBOOT_MENUS)
	./scripts/deploy localboot localboot.rstms.net

$(CERT_FILES):
	mkdir -p certs
	scripts/getcerts
	mkcert netboot_client -d 10y --cert-file certs/netboot_client.pem --key-file certs/netboot_client.key -- --force

menus/netboot.ipxe: menus/template.ipxe
	sed <$< >$@ 's/NETBOOT_NAME/netboot/;s/NETBOOT_DOMAIN/rstms.net/'

menus/netboot-debian.ipxe: menus/template-debian.ipxe
	sed <$< >$@ 's/NETBOOT_FQDN/netboot.rstms.net/'

menus/netboot-openbsd.ipxe: menus/template-openbsd.ipxe
	sed <$< >$@ 's/NETBOOT_FQDN/netboot.rstms.net/'

menus/localboot.ipxe: menus/template.ipxe
	sed <$< >$@ 's/NETBOOT_FQDN/localboot.rstms.net/'

menus/localboot-debian.ipxe: menus/template-debian.ipxe
	sed <$< >$@ 's/NETBOOT_FQDN/localboot.rstms.net/'

menus/localboot-openbsd.ipxe: menus/template-openbsd.ipxe
	sed <$< >$@ 's/NETBOOT_FQDN/localboot.rstms.net/'

#$(call BUILD,make CERT=$(CERTS) TRUST=$(TRUST) EMBED=../menus/netboot.ipxe bin/ipxe.iso)
#$(call BUILD,make CERT=$(CERTS) TRUST=$(TRUST) PRIVKEY=../certs/netboot_client.key EMBED=../menus/netboot.ipxe bin/ipxe.iso)

bin/netboot.iso: .$(BUILDER) $(NETBOOT_MENUS) $(CERT_FILES) $(wildcard config/*) $(IPXE_SOURCE) Makefile
	mkdir -p bin
	$(call BUILD,make CERT=$(CERTS) TRUST=$(TRUST) PRIVKEY=../certs/netboot_client.key EMBED=../menus/netboot.ipxe all)
	mv src/bin/ipxe.iso $@

bin/netboot.img: bin/netboot.iso
	mv src/bin/ipxe.usb $@

bin/localboot.iso: .$(BUILDER) $(LOCALBOOT_MENUS) $(CERT_FILES) $(wildcard config/*) $(IPXE_SOURCE) Makefile
	mkdir -p bin
	$(call BUILD,make CERT=$(CERTS) TRUST=$(TRUST) PRIVKEY=../certs/netboot_client.key EMBED=../menus/localboot.ipxe all)
	mv src/bin/ipxe.iso $@

bin/localboot.img: bin/localboot.iso
	mv src/bin/ipxe.usb $@

shell: .$(BUILDER)
	$(call BUILD,bash -l)

.$(BUILDER): Dockerfile
	docker build $(BUILD_ARGS) --tag $(BUILDER) --iidfile .$(BUILDER) -<Dockerfile

clean:
	$(call BUILD,make clean) || true
	rm -f .$(BUILDER)
	rm -f $(NETBOOT_MENUS) 
	rm -f $(LOCALBOOT_MENUS) 
	rm -rf certs
	rm -rf bin

sterile: clean
	docker rmi -f $(BUILDER) || true

