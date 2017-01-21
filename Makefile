.PHONY: default clean build run lib getwindowlib getmaclib package-linux package-windows package-mac package

default: build run

buildclean:
	@[[ ! -e waves.love ]] || rm waves.love

clean:
	@[[ ! -e waves.love ]] || rm waves.love
	@[[ ! -e pkg ]] || rm -r pkg
	@[[ ! -e lib ]] || rm -r lib
	@[[ ! -e temp ]] || rm -r temp

build: buildclean
	@zip -q -r -0 waves.love assets/*
	@cd src/ && zip -q -r ../waves.love *

build-fast:
	@zip -q -r -0 waves.love assets/*
	@./script/fast.sh
	@cd temp/ && zip -q -r ../waves.love *
	@rm -rf temp

fast: build-fast
	@love waves.love

run:
	@love waves.love

setup:
	git submodule update --init --recursive

package-linux: build
	@./script/download.sh linux
	@./script/package.sh linux

package-windows: build
	@./script/download.sh windows
	@./script/package.sh windows

package-mac: build
	@./script/download.sh osx
	@./script/package.sh osx

subupdate:
	git submodule foreach git pull origin master

package: build package-linux package-windows package-mac
