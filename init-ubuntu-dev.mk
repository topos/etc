help:; @echo "make install"

install: pkgs fonts emacs compression gems

PKGS = ruby ruby-dev rake ksh fvwm git diffuse source-highlight flex bison g++
pkgs:
	for p in ${PKGS}; do sudo apt install -y $$p; done

LIBS = libgconf2-4 libgconf2-dev libnss3-dev libnss3-1d libnss3-tools libudev-dev libxss-dev libxss-dev libxml2-dev libncurses-dev libgpm-dev libgmp10-dev libgmp10 libmpfr-dev libmpc-dev libisl-dev libcloog-isl-dev
libs:
	for p in ${LIBS}; do sudo apt install -y $$p; done

FONTS = ttf-mscorefonts-installer
fonts:
	for p in ${FONTS}; do sudo apt install -y $$p; done
	sudo apt install -y edubuntu-fonts emacs-intl-fonts xfonts-100dpi xfonts-100dpi-transcoded gsfonts gsfonts-other gsfonts-x11
	sudo fc-cache -f -v

update:; sudo apt update -y

upgrade:; sudo apt upgrade -y

full-upgrade:; sudo apt full-upgrade -y

emacs:; sudo apt install -y emacs24 emacs24-el emacs-goodies-el emacs-goodies-extra-el haskell-mode

google-chrome: libs
	sudo dpkg --install google-chrome-stable_current_amd64.deb

java:;	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update -y
	sudo apt install -y oracle-java8-installer

media: media-ppa
	sudo apt install -y non-free-codecs libdvdcss

media-ppa:; sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

# nvidia:
# 	cd /tmp && sudo apt-get --purge remove xserver-xorg-video-nouveau
# 	cd /tmp && sudo sudo service lightdm stop
# 	cd /tmp && wget -c us.uk.download.nvidia.com/XFree86/Linux-x86_64/319.17/NVIDIA-Linux-x86_64-319.17.run
# 	cd /tmp && sudo chmod +x NVIDIA-Linux-x86-319.17.run && sudo ./NVIDIA-Linux-x86-319.17.run
# -alternative -
# sudo apt-add-repository ppa:ubuntu-x-swat/x-updates
# sudo apt-get update
# sudo apt-get install nvidia-current


compression:; sudo apt install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller

dev: tools
	for i in $$(apt search -F '%p' x11|grep dev|grep -v :i386|grep -v libhgc); do sudo apt install -y $$i; done
	sudo apt install -y libtiff-dev libtiff-tools libjpeg8-dev libgif-dev libxpm-dev
	sudo apt install -y xserver-xorg-input-mtrack
	sudo apt install -y ubuntu-dev-tools libgmp3-dev libgmp-dev libmpfr-dev libmpc-dev bison flex gcc-multilib xz-utils
	sudo apt install -y freeglut3-dev

dev-info:; apt search -F '%p' x11|grep dev|grep -v :i386|grep -v libhgc


tools:;	sudo apt install -y curl wget imagemagick graphicsmagick-imagemagick-compat

default-keyboard:
	sudo cp keyboard /etc/default/keyboard
	sudo dpkg-reconfigure -phigh console-setup

gemrc:; echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

GEMS=rake smart_colored
gems:
	@for i in ${GEMS}; do \
		gem=$$(echo $$i|sed 's/:/ -v /1'); \
		echo $$gem; \
	if [ "$$(gem list --local -i $$gem)" = "false" ]; then sudo gem install --no-ri --no-rdoc $$gem; fi \
	done

buildr:
	@if [ "$$(gem list --local -i $@)" = "false" ]; then \
		if [ -z "${JAVA_HOME}" ]; then \
			sudo env JAVA_HOME=/usr/lib/jvm/java-6-sun gem install --no-ri --no-rdoc $@; \
		else \
			sudo gem install --no-ri --no-rdoc $@; \
		fi; \
	fi

sudo:; sudo cp ml.sudo /etc/sudoers.d/ml

clean:
	sudo apt-get autoremove -y unity-lens-shopping
	sudo apt-get autoremove -y unity-lens-music
	sudo apt-get autoremove -y unity-lens-photos
	sudo apt-get autoremove -y unity-lens-gwibber
	sudo apt-get autoremove -y unity-lens-video
	sudo aptitude clean -y && sudo aptitude autoclean -y

remove: clean
	sudo apt-get autoremove --purge unity unity-common unity-services unity-lens-* unity-scope-* unity-webapps-* gnome-control-center-unity hud libunity-core-6* libunity-misc4 libunity-webapps* appmenu-gtk appmenu-gtk3 appmenu-qt* overlay-scrollbar* activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu libufe-xidgetter0 xul-ext-unity xul-ext-webaccounts webaccounts-extension-common xul-ext-websites-integration
