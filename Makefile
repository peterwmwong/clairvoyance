src_files = $(shell find src -type f)

define compile_coffee
	coffee -b -o $2 -c $1
endef

#-------------------------------------------------------------------
# Convenience
#------------------------------------------------------------------- 
.PHONY : all dev clean

all: build

build: support/cell/build/cell.js $(src_files)
	mkdir -p build
	cp -r src/* build/
	find build/ -regex '.*\.\(coffee\)' -type f -exec rm {} \;
	mkdir -p build/support
	cp support/cell/build/cell.js build/support/cell.js
	coffee -b -o build/ -c src/

support/cell/build/cell.js:
	cd support/cell; make

clean: 
	@@rm -rf build

dev:

