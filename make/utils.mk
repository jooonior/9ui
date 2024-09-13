# Space character.
SPACE := $(subst ,, )

# Detect which shell is Make using. 
ifeq ($(shell echo ""),"")
# cmd.exe
ESC := ^
TAB :=	
QUOT := "
NULL := NUL
POSIX_ONLY := echo This functionality requires a POSIX compliant shell. && exit 1
else
# /bin/sh
ESC := \$(strip)
TAB := "	"
QUOT := \""
NULL := /dev/null
POSIX_ONLY :=
endif

Escape = $(subst :,\:,$(subst $(SPACE),\ ,$1))
Split = $(subst $1, ,$2)
Concat = $(subst $(eval ) ,$1,$2)
Tail = $(wordlist 2,$(words $1),$1)
DirectoryTail = $(call Concat,/,$(call Tail,$(call Split,/,$1)))

RecursiveBasename = $(if $1,$(let b,$(basename $1),$(if $(filter $1,$b),$1,$(call RecursiveBasename,$b))))

# https://stackoverflow.com/a/18258352
RecursiveWildcard = $(foreach d,$(wildcard $(1:=/*)),$(call RecursiveWildcard,$d,$2) $(filter $(subst *,%,$2),$d))

# Cross platform way of recursively creating directories.
EnterDirectory = cd . $(foreach d,$(call Split,/,$1),&& mkdir $d 2>$(NULL) || cd . && cd $d || exit 1)

# $(eval $(call CacheVariable,VARIABLE))
# If VARIABLE is defined, saves its value to cache, otherwise loads its cached value.
define CacheVariable =
ifndef CACHE_DIR
$$(error CACHE_DIR not set)
endif
ifneq ($$(origin $1),undefined)
$$(shell $$(call EnterDirectory,$$(CACHE_DIR)) && echo $1 := "$$($1)" > $1.cache.mk)
else
-include $$(CACHE_DIR)/$1.cache.mk
# In `cmd.exe`, the quotes get echoed too and must be removed here.
$1 := $$(subst ",,$$($1))
endif
endef
