GCC = gcc
AS_FLAGS = --32
LD_FLAGS = -m32 -g -c
FLAGS = -m32 -g -c
DEBUG = -gstabs

all:bin/main

obj/menu.o: src/menu.s
	as --32 -gstabs src/menu.s -o obj/menu.o

obj/menuSupervisor.o: src/menuSupervisor.s
	as --32 -gstabs src/menuSupervisor.s -o obj/menuSupervisor.o

obj/isSupervisor.o: src/isSupervisor.s
	as --32 -gstabs src/isSupervisor.s -o obj/isSupervisor.o

obj/getArrow.o: src/getArrow.s
	as --32 -gstabs src/getArrow.s -o obj/getArrow.o

obj/blinksManager.o: src/blinksManager.s
	as --32 -gstabs src/blinksManager.s -o obj/blinksManager.o

obj/menuList.o: src/menuList.s
	as --32 -gstabs src/menuList.s -o obj/menuList.o

bin/main: obj/menu.o obj/menuSupervisor.o obj/isSupervisor.o obj/getArrow.o obj/menuList.o obj/blinksManager.o
	ld -m elf_i386 obj/isSupervisor.o obj/getArrow.o obj/menu.o obj/menuSupervisor.o obj/menuList.o obj/blinksManager.o -o bin/main



.PHONY: clean

clean:
	rm -rf obj/*
	rm -rf bin/main
	Enviornment cleaned
