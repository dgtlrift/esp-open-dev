.PHONY:	all update

GIT_VERBOSE=true

ifdef V
 Q :=
 vecho = @echo
 ifeq ("$(V)","0")
  Q := @
  vecho = @true
 else ifeq ("$(V)","2")
  GIT_VERBOSE=export GIT_TRACE=2
 endif
else
 Q := @
 vecho = @true
endif

all: update infrastructure

update:
	$(Q)		\
	$(GIT_VERBOSE)	;\
	git pull	&&	\
	git submodule sync	&&	\
	git submodule update --init --recursive

infrastructure:
	$(Q)sudo apt-get install	\
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

