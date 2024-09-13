# Define project directories.
SOURCE_DIR  := src
INCLUDE_DIR := include
OUTPUT_DIR  := build
CACHE_DIR   := .cache

# Define program names.
PYTHON      := python

# Include functions and other definitions.
include make/utils.mk

# Cache configuration variables.
$(eval $(call CacheVariable,TF2DIR))

# Find include files.
INCLUDES := $(sort $(wildcard $(INCLUDE_DIR)/*.res))

# Find all source files and directories.
SOURCES := $(call RecursiveWildcard,$(SOURCE_DIR),*)
# Remove directories from sources list.
SOURCES := $(foreach f,$(SOURCES),$(if $(wildcard $f/.),,$f))
# Remove `.md` files (dev notes).
SOURCES := $(filter-out %.md,$(SOURCES))

# Map source files to output files.
OUTPUTS := $(patsubst $(SOURCE_DIR)/%,$(OUTPUT_DIR)/%,$(SOURCES))
# Add `.res` file for each `.9ui.res` file.
OUTPUTS += $(patsubst %.9ui.res,%.res,$(filter %.9ui.res,$(OUTPUTS)))
# Remove `.stock.res` files from output.
OUTPUTS := $(filter-out %.stock.res,$(OUTPUTS))
# Add `.vtf` file for each `.*.png` file.
OUTPUTS += $(foreach f,$(filter %.png,$(OUTPUTS)),$(call RecursiveBasename,$f).vtf)
# Remove `.png` files from output.
OUTPUTS := $(filter-out %.png,$(OUTPUTS))
# Add `.ttf` file for each `.*.svg` file.
OUTPUTS += $(foreach f,$(filter %.svg,$(OUTPUTS)),$(call RecursiveBasename,$f).ttf)
# Remove `.svg` files from output.
OUTPUTS := $(filter-out %.svg,$(OUTPUTS))
# Add `info.vdf` file for each top-level source subdirectory.
OUTPUTS += $(patsubst $(SOURCE_DIR)%/.,$(OUTPUT_DIR)%/info.vdf,$(wildcard $(SOURCE_DIR)/*/.))
# Remove duplicates.
OUTPUTS := $(sort $(OUTPUTS))

# Find all stock source files.
STOCK_FILES := $(call RecursiveWildcard,$(SOURCE_DIR),*.stock.res)

.PHONY: all
all: $(OUTPUTS)

.PHONY: clean
clean:
	@$(RM) $(OUTPUTS)

.PHONY: dev
dev:
	@$(POSIX_ONLY)
	@which entr &> /dev/null || { echo no entr; exit 1; }
	@echo "Watching $(SOURCE_DIR)/ and $(INCLUDE_DIR)/ for changes. Press Q to exit."
	@while ! find $(SOURCE_DIR) $(INCLUDE_DIR) | env entr -d make MAKELEVEL=0; do :; done

.SECONDEXPANSION:
.DELETE_ON_ERROR:

# Creates build directory.
$(OUTPUT_DIR)/:
	@#echo mkdir$(TAB)$(TAB)$@
	@$(call EnterDirectory,$@)

# Creates build subdirectories (explicit).
$(OUTPUT_DIR)/%/:
	@#echo mkdir$(TAB)$(TAB)$@
	@$(call EnterDirectory,$@)

# Creates build subdirectories (implicit, only when matching source subdirectory exists).
$(OUTPUT_DIR)/%: | $(SOURCE_DIR)/%/
	@#echo mkdir$(TAB)$(TAB)$@
	@$(call EnterDirectory,$@)

# Dummy rule used as a dependency to decrease priority of other rules.
DUMMY-%:
	@

Echo = echo $1 && $(patsubst %,echo $(TAB)% && ,$2) cd .

# Set Python module path.
export PYTHONPATH := deps/keyvalues/src

# Builds `.9ui.res` files from `.9ui.res` and `.stock.res` sources.
$(OUTPUT_DIR)/%.9ui.res: $(SOURCE_DIR)/%.9ui.res $(SOURCE_DIR)/%.stock.res $(INCLUDES) | $$(@D)/
	@$(call Echo,$@,$^)
	@$(PYTHON) dev/scripts/cat.py \
			"{ PRAGMA COMPAT @@@ENDCOMPAT@@@ }" \
			@$(SOURCE_DIR)/$*.stock.res \
			"// @@@ENDCOMPAT@@@" \
			$(addprefix @,$(INCLUDES)) \
			@$< \
		| $(PYTHON) -m keyvalues expand - > $@

# Builds `.9ui.res` files from `.9ui.res` sources only.
$(OUTPUT_DIR)/%.9ui.res: $(SOURCE_DIR)/%.9ui.res $(INCLUDES) | $$(@D)/
	@$(call Echo,$@,$^)
	@$(PYTHON) dev/scripts/cat.py \
			$(addprefix @,$(INCLUDES)) \
			@$< \
		| $(PYTHON) -m keyvalues expand - > $@

# Copy `.res` files from source.
$(OUTPUT_DIR)/%.res: $(SOURCE_DIR)/%.res | $$(@D)/
	@$(call Echo,$@,$^)
	@cp $< $@

# Generates `.res` files.
$(OUTPUT_DIR)/%.res: | $$(@D)/
	@$(call Echo,$@,$^)
	@$(RM) $@
	@echo $(ESC)#base $(notdir $*).custom.res >> $@
	@echo $(ESC)#base $(notdir $*).9ui.res >> $@

# Generates `info.vdf` files.
$(OUTPUT_DIR)/%/info.vdf: | $$(@D)/
	@$(call Echo,$@,$^)
	@echo $* { ui_version 3 } > $@

# Builds `.vtf` files from `.png` sources.
$(OUTPUT_DIR)/%.vtf: $$(or $$(firstword $$(wildcard $(SOURCE_DIR)/%.*.png)),__never__) | $$(@D)/
	@$(call Echo,$@,$^)
	@$(PYTHON) dev/scripts/tovtf.py $^ $(lastword $(subst ., ,$(basename $^))) > $@

# Generates fonts from SVG icons.
$(OUTPUT_DIR)/%.ttf: $$(or $$(wildcard $(SOURCE_DIR)/%.*.svg),__never__) | $$(@D)/
	@$(call Echo,$@,$^)
	@$(PYTHON) dev/scripts/mkfont.py $(notdir $*) $@ $(call ParseGlyphNames,$(SOURCE_DIR)/$*.,$^)

ParseGlyphNames = $(foreach f,$2,$(firstword $(subst ., ,$(patsubst $1%,%,$f)))=$f)

# Copies files that don't match any more specific rule.
$(OUTPUT_DIR)/%: $(SOURCE_DIR)/% | $$(@D)/ DUMMY-1
	@$(call Echo,$@,$^)
	@cp $< $@

.PHONY: stock
stock: $(STOCK_FILES)

# Error message used by following rules.
define TF2DIR_HELP :=
@echo $(TAB)TF2DIR=$(QUOT)$(TF2DIR)$(QUOT)
@echo To use a different directory, specify it when invoking Make.
@echo $(TAB)make $(QUOT)TF2DIR=...$(QUOT) $(MAKECMDGOALS)
endef

ifndef TF2DIR

# Fails when stock files are missing.
$(SOURCE_DIR)/%.stock.res:
	@$(call Echo,$@,$^)
	@echo TF2 directory not found.
	$(TF2DIR_HELP)
	@exit 1

else

# Escape special characters in TF2DIR so that it can be used in targets and dependencies.
TF2DIR_ESCAPED := $(call Escape,$(TF2DIR))

# Extracts stock source files from TF2's VPKs.
$(SOURCE_DIR)/%.stock.res: $(TF2DIR_ESCAPED)/tf/tf2_misc_dir.vpk
	@$(call Echo,$@,)
	@$(PYTHON) dev/scripts/unvpk.py "$<" $(call DirectoryTail,$*).res > $@

endif
