#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo -e "- Supply one parameter: the target triple to use!! e.g. x86_64-elf, i686-elf, etc.\n"
    exit 1
fi

# install dependencies for gcc and bin-utils
echo -e "\n\n+ Installing dependencies...\n"
sudo apt install libgmp3-dev libmpfr-dev libisl-dev libmpc-dev texinfo -y

cd "$(dirname "$0")"

# create the necessary directories
echo -e "\n\n+ Creating the necessary directories...\n"
mkdir cross
cd cross

mkdir path src
cd src

# download source code
echo -e "\n\n+ Downloading source code...\n"
wget https://ftp.gnu.org/gnu/binutils/binutils-2.42.tar.gz
wget https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.gz

# extract source code
echo -e "\n\n+ Extracting source code...\n"
tar -xvzf binutils-2.42.tar.gz
tar -xvzf gcc-13.2.0.tar.gz

# preparation for compilation
export TARGET=$1
export PREFIX="$(pwd)/../path/"
export PATH="$PREFIX/bin:$PATH"

echo -e "\n\n+ Starting the compilation process. This will take a while. Go grab a coffee or something.\n"

# compile bin-utils
mkdir build-binutils
cd build-binutils
../binutils-2.42/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j $(nproc)
make install

# compile gcc and lib-gcc
cd ..
mkdir build-gcc
cd build-gcc
../gcc-13.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make -j $(nproc) all-gcc
make -j $(nproc) all-target-libgcc
make install-gcc
make install-target-libgcc

echo -e "\n\n+ Done! You can now use your cross-compiler by adding the path to the bin folder to your PATH variable. Read the README.md for more information.\n"