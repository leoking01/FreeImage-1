# What is FreeImage ?
FreeImage is an Open Source library project for developers who would like to support popular graphics image formats like PNG, BMP, JPEG, TIFF and others as needed by today's multimedia applications.
FreeImage is easy to use, fast, multithreading safe, and cross-platform (works with Windows, Linux and Mac OS X).

Thanks to it's ANSI C interface, FreeImage is usable in many languages including C, C++, VB, C#, Delphi, Java and also in common scripting languages such as Perl, Python, PHP, TCL, Lua or Ruby.

The library comes in two versions: a binary DLL distribution that can be linked against any WIN32/WIN64 C/C++ compiler and a source distribution.
Workspace files for Microsoft Visual Studio provided, as well as makefiles for Linux, Mac OS X and other systems.

# Build with CMake

```bash
cd <freeimage-source-directory>
mkdir build
cd build

# normal build(static lib)
cmake .. -DFI_SRCS_FILE=../Makefile.srcs

# build with fip(static lib)
cmake .. -DFI_SRCS_FILE=../fipMakefile.srcs

# normal build(shared lib)
cmake .. -DFI_SRCS_FILE=../Makefile.srcs -DBUILD_SHARED_LIBS:BOOL=ON

# build with fip(shared lib)
cmake .. -DFI_SRCS_FILE=../Makefile.srcs -DBUILD_SHARED_LIBS:BOOL=ON

```
# Notes
- This repository is a fork of [FreeImage Source](http://freeimage.sourceforge.net/)
- Alternatively you can download the binary distribution from [here](http://freeimage.sourceforge.net/download.html)



可以支持cmake install  安装 



