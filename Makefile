# Makefile for running SICP exercises
# Usage: make run CHAPTER=1 Q=1

# Default values
CHAPTER ?= 1
Q ?= 1

# Racket executable
RACKET = racket

# Chapter mapping (number to folder name)
ifeq ($(CHAPTER),1)
    CHAPTER_NAME = building-abstractions-with-procedures
else ifeq ($(CHAPTER),2)
    CHAPTER_NAME = building-abstractions-with-data
else ifeq ($(CHAPTER),3)
    CHAPTER_NAME = modularity-objects-and-state
else ifeq ($(CHAPTER),4)
    CHAPTER_NAME = metalinguistic-abstraction
else ifeq ($(CHAPTER),5)
    CHAPTER_NAME = computing-with-register-machines
else
    CHAPTER_NAME = $(CHAPTER)
endif

# Target directory
DIR = $(CHAPTER_NAME)/$(Q)

.PHONY: run help

run:
	@if [ ! -d "$(DIR)" ]; then \
		echo "Error: Directory $(DIR) does not exist"; \
		exit 1; \
	fi; \
	if [ ! -f "$(DIR)/solution.rkt" ]; then \
		echo "Error: solution.rkt not found in $(DIR)"; \
		exit 1; \
	fi; \
	echo "Running Chapter $(CHAPTER) - Question $(Q)..."; \
	cd "$(DIR)" && $(RACKET) solution.rkt

help:
	@echo "SICP Exercise Runner"
	@echo ""
	@echo "Usage:"
	@echo "  make run CHAPTER=<chapter-number> Q=<question-number>"
	@echo ""
	@echo "Examples:"
	@echo "  make run CHAPTER=1 Q=1"
	@echo "  make run Q=2           # Uses default CHAPTER=1"
	@echo "  make run CHAPTER=2 Q=5"
	@echo ""
	@echo "Chapter Mapping:"
	@echo "  1 - building-abstractions-with-procedures"
	@echo "  2 - building-abstractions-with-data"
	@echo "  3 - modularity-objects-and-state"
	@echo "  4 - metalinguistic-abstraction"
	@echo "  5 - computing-with-register-machines"
	@echo ""
	@echo "Options:"
	@echo "  CHAPTER - Chapter number (default: 1)"
	@echo "  Q       - Question number (default: 1)"
