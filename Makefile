emotes_target = "/usr/share/pixmaps/pidgin/emotes"
emotes_src = "emotes/src"
emotes_theme = "emotes/elementary"
status_dir = "~/.purple/themes/elementary"
status_theme = "status-icons/purple"

all:

convert:
	for icon in $(emotes_src)/*.svg; do \
		inkscape -z $$icon -e $${icon%%.*}.png; \
	done
	mv $(emotes_src)/*.png $(emotes_theme)

install: install-emotes install-status

install-emotes:
	cp -r $(emotes_theme) $(emotes_target)

install-status:
	mkdir -p $(status_dir)
	cp -r $(status_theme) $(status_dir)

uninstall: uninstall-emotes uninstall-status

uninstall-emotes:
	test -e $(emotes_target)/elementary && rm -rfv $(emotes_target)/elementary

uninstall-status:
	test -e $(status_dir) && rm -rfv $(status_dir)