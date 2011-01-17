src_files = $(shell find src -type f)

define compile_coffee
	coffee -b -o $2 -c $1
endef

#-------------------------------------------------------------------
# Convenience
#------------------------------------------------------------------- 
.PHONY : build dev clean


build: support/cell/build/cell.js $(src_files)
	mkdir -p build
	cp -r src/* build/
	find build/ -regex '.*\.\(coffee\)' -type f -exec rm {} \;
	mkdir -p build/support
	cp support/cell/build/cell.js build/support/cell.js
	coffee -b -o build/ -c src/

support/cell/build/cell.js:
	git submodule init
	git submodule update
	cd support/cell; make


dev: support/express/support/connect/index.js
	coffee test/util/dev-server.coffee

support/express/support/connect/index.js:
	cd support/express; git submodule init; git submodule update


clean: 
	@@rm -rf build
