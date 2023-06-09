# make makefile
#
# Tools used:
#  Compile::Resource Compiler
#  Compile::GNU C
#  Make: make
all : driver.exe

driver.exe : driver.obj entryfld.lib driver.def
	gcc -Zomf -Zmap -lentryfld driver.obj driver.def -o driver.exe

driver.obj : driver.c
	gcc -Wall -Zomf -c -O2 driver.c -o driver.obj

heapmgr.obj : heapmgr.c
	gcc -Wall -Zomf -c -O2 heapmgr.c -o heapmgr.obj

eventmgr.obj : eventmgr.c
	gcc -Wall -Zomf -c -O2 eventmgr.c -o eventmgr.obj

entryfld.obj : entryfld.c entryfld.h
	gcc -Wall -Zomf -c -O2 entryfld.c -o entryfld.obj

entryfld.dll : entryfld.obj heapmgr.obj eventmgr.obj entryfld.def
	gcc -Zdll -Zomf -Zmap  entryfld.obj heapmgr.obj eventmgr.obj entryfld.def -o entryfld.dll

entryfld.lib : entryfld.obj entryfld.def entryfld.dll
       $(shell emximp -o entryfld.lib entryfld.def)

clean :
	rm -rf *exe *res *obj *lib *dll *map
