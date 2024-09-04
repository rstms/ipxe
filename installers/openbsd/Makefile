major = 7
minor = 5
arch = amd64

src = install$(major)$(minor).img
dst = netboot$(major)$(minor).img
installurl != cat /etc/installurl

src_img="$base_dir/pub/OpenBSD/$version/$arch/${src_image_name}${label}.img"
dst_img="$base_dir/pub/OpenBSD/$version/$arch/netboot${label}.img"


$(dst): $(src) mkautoinstallimg
	doas ./mkautoinstallimg $(src) $@ netboot.pem netboot.key
	doas chown $(USER).$(USER) $@
	doas cp $(dst) /var/www/htdocs/pub/OpenBSD/$(major).$(minor)/$(arch)/$(dst)

$(src):
	ftp $(installurl)/$(major).$(minor)/$(arch)/$(src)

install: $(dst)
	doas cp $(dst) /var/www/htdocs/pub/OpenBSD/$(major).$(minor)/$(arch)/$(dst)

clean:
	rm -f $(dst)
