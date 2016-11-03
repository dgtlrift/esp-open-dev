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

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_path:= $(patsubst %/,%,$(dir $(mkfile_path)))
current_dir := $(notdir $(current_path))

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

qemu-xtensa: qemu
	$(Q)	\
	mkdir -p $(@)			&&	\
	cd $(@)				&&	\
	../qemu/configure			\
		--prefix=$(current_path)/local	\
		--target-list=xtensa-softmmu	\
		--disable-werror 	&&	\
	make				&&	\
	make install

.PHONY:	esp-open-rtos
esp-open-sdk:	Makefile
	$(Q)					\
	cd $(@)				&&	\
	$(MAKE)					\
		toolchain			\
		esptool				\
		libhal				\
		STANDALONE=n

#	export PATH=/home/jim/project/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

open-rtos-examples:=$(patsubst esp-open-rtos/%,%,$(wildcard esp-open-rtos/examples/*))
make-rtos-examples=$(foreach dir,$(1),if [ -d $(dir) ] ; then $(MAKE) $(2) -C $(dir) ; fi &&)

ifndef TARGET
TARGET:=all
endif

ifndef PROJECT
PROJECT:=examples/simple
endif

esp-open-rtos:
	$(Q)			\
	cd $(@)		&&	\
	export PATH=$(current_path)/esp-open-sdk/xtensa-lx106-elf/bin:$${PATH}	&&	\
	echo $${PATH}	&&	\
	$(call make-rtos-examples,$(PROJECT),$(TARGET)) true

esp-open-rtos-all:
	$(Q)			\
	cd $(@)		&&	\
	export PATH=$(current_path)/esp-open-sdk/xtensa-lx106-elf/bin:$${PATH}	&&	\
	echo $${PATH}	&&	\
	$(call make-rtos-examples,$(open-rtos-examples),$(TARGET)) true

