emotes_target = /usr/share/pixmaps/pidgin/emotes
emotes_src = emotes/src
emotes_theme = emotes/elementary
status_dir = ~/.purple/themes/elementary
status_theme = status-icons/purple
status_theme_src = status-icons/src
status_theme_dst = status-icons/purple/status-icon

convert: convert-emotes convert-status

all_emote_svgs = $(wildcard $(emotes_src)/*.svg)
all_emote_pngs = $(patsubst $(emotes_src)/%.svg,$(emotes_theme)/%.png,$(all_emote_svgs))
all_emote_pngs = $(subst $(emotes_src),$(emotes_theme),$(all_emote_svgs:%.svg=%.png))

convert-emotes: $(all_emote_pngs)

#special "out of tree" build
$(emotes_theme)/%.png: $(emotes_src)/%.svg
	inkscape -z $< -e $@

all_status_svgs = $(shell find $(status_theme_src) -type f -name '*.svg')
all_status_pngs = $(subst $(status_theme_src),$(status_theme_dst),$(all_status_svgs:%.svg=%.png))

convert-status: $(all_status_pngs)

#special "out of tree" build
$(status_theme_dst)/%.png: $(status_theme_src)/%.svg
	inkscape -z $< -e $@

check-root:
	@[ $$(id -u) -eq 0 ] || (echo "-- You need to be root for this to work\n" ; exit 1)

install: install-emotes install-status

install-emotes: check-root convert-emotes
	cp -r $(emotes_theme) $(emotes_target)

install-status: check-root convert-status
	mkdir -p $(status_dir)
	cp -r $(status_theme) $(status_dir)

uninstall: uninstall-emotes uninstall-status

uninstall-emotes: check-root
	test -e $(emotes_target)/elementary && rm -rfv $(emotes_target)/elementary

uninstall-status: check-root
	test -e $(status_dir) && rm -rfv $(status_dir)
