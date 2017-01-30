.PHONY: default clean build run lib getwindowlib getmaclib package-linux package-windows package-mac package

default: run

NAME=space_narcade

buildclean:
	rm -f $(NAME).love

clean:
	rm -f $(NAME).love
	rm -rf pkg
	rm -rf lib
	rm -rf temp

$(NAME).love: buildclean
	@zip -q $(NAME).love main.lua conf.lua
	@zip -q -r -0 $(NAME).love assets/*
	@zip -q -r $(NAME).love src/*

build: $(NAME).love

build-fast:
	@zip -q -r -0 $(NAME).love assets/*
	@./script/fast.sh
	@cd temp/ && zip -q -r ../$(NAME).love *
	@rm -rf temp

fast: build-fast
	@love $(NAME).love

run: $(NAME).love
	@love $(NAME).love

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

zip: package
	cd pkg && zip -q -r space_narcade.zip ./*
