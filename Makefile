
UID != id -u
GID != id -g
USER != whoami
ARGS = UID GID USER 
BUILDER = ipxe-builder
ISO = src/bin/ipxe.iso
SOURCES != find src -type f | egrep '.*\.(h|c)$$'
VOLUMES = \
  -v $(PWD)/src:/home/$(USER)/src \
  -v $(PWD)/certs:/home/$(USER)/certs \
  -v $(PWD)/menus:/home/$(USER)/menus

CERTS = ../certs/root.pem,../certs/intermediate.pem,../certs/netboot.pem
TRUST = ../certs/root.pem,../certs/intermediate.pem

BUILD_ARGS = $(foreach ARG,$(ARGS),--build-arg $(ARG)=$($(ARG)) )

BUILD = docker run -it --rm --hostname $(BUILDER) $(VOLUMES) $(BUILDER) /bin/bash -c '$(1)'

upload: $(ISO)
	./scripts/deploy $(ISO)

certs:
	mkdir certs
	./scripts/getcerts
	mkcert netboot -d 10y --cert-file certs/netboot.pem --key-file certs/netboot.key -- --force

$(ISO): .$(BUILDER) $(SOURCES) certs
	$(call BUILD,make CERT=$(CERTS) TRUST=$(TRUST) PRIVKEY=../certs/netboot.key EMBED=../menus/netboot.ipxe bin/ipxe.iso)

shell: .$(BUILDER)
	$(call BUILD,bash -l)

.$(BUILDER): Dockerfile
	docker build $(BUILD_ARGS) --tag $(BUILDER) --iidfile .$(BUILDER) -<Dockerfile

clean:
	$(call BUILD,make clean) || true
	rm -f ipxe.iso
	rm -f .$(BUILDER)
	rm -rf certs

sterile: clean
	docker rmi -f $(BUILDER) || true

