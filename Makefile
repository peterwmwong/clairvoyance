src_files = $(shell find src -type f)

define compile_coffee
	coffee -b -o $2 -c $1
endef

#-------------------------------------------------------------------
# Convenience
#------------------------------------------------------------------- 
.PHONY : all dev clean

all: build

build: $(src_files)
	mkdir -p build
	cp -r src/* build/
	find build/ -regex '.*\.\(coffee\)' -type f -exec rm {} \;
	coffee -b -o build/ -c src/

clean: 
	@@rm -rf build

dev:

