.PHONY:	all update

all: update infrastructure

update: infrastructure
	git pull
	git submodule sync
	git submodule update --init --recursive

infrastructure:
	sudo apt-get install	\
		make	\
		unrar-free	\
		autoconf	\
		automake	\
		libtool	\
		gcc	\
		g++	\
		gperf	\
		flex	\
		bison	\
		texinfo	\
		gawk	\
		ncurses-dev	\
		libexpat-dev	\
		python-dev	\
		python	\
		python-serial	\
		sed	\
		git	\
		unzip	\
		bash	\
		help2man	\
		wget	\
		bzip2	\
		libtool-bin

