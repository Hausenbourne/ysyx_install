# !/bin/bash

# install tool
sudo apt-get update
sudo apt-get install build-essential man gcc-doc gdb git libreadline-dev libsdl2-dev llvm llvm-dev
# configuring vim
sudo cp -r vim_config/.vim ~/.vim
sudo cp -r vim_config/.vimrc ~/.vimrc

# configuring git
## configuring git
echo "student id:"
read ID
echo "name"
read NAME
echo "email"
read EMAIL
git config --global user.name $ID-$NAME
git config --global user.email $EMAIL
git config --global core.editor vim
git config --global color.ui true

## configuring ssh key
echo "github email:"
read GIT_EMAIL
ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -q -N ""
PUBLIC_KEY=$(cat ~/.ssh/id_ed25519.pub)
gh auth git-credential-osxkeychain remove
gh auth git-credential-osxkeychain add
gh auth status
gh auth login
gh ssh-key add -t ed25519 -f ~/.ssh/id_ed25519.pub -l "My New SSH Key"

# install ccache and configuring ccache 
sudo apt-get install ccache
sudo echo 'alias gcc="/usr/lib/ccache/gcc"' >> ~/.bashrc
source ~/.bashrc
# install verilator
sudo apt-get install git help2man perl python3 make autoconf g++ flex bison ccache
sudo apt-get install libgoogle-perftools-dev numactl perl-doc
git clone https://github.com/verilator/verilator
unset VERILATOR_ROOT
cd verilator
git pull
git tag
git checkout stable
autoconf
./configure
make -j `nproc`
sudo make install
cd ..
sudo rm -rf verilator
# install nvboard dependency package
sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev
# install yosys-sta dependency package
sudo apt install yosys 
sudo apt install libunwind-dev libyaml-cpp-dev libgomp1 libtcl8.6
# install Cross compilation environment 
sudo apt-get install g++-riscv64-linux-gnu binutils-riscv64-linux-gnu
sudo sed -i '5,5s/# include <gnu\/stubs-ilp32.h>/\/\/# include <gnu\/stubs-ilp32.h>/' /usr/riscv64-linux-gnu/include/gnu/stubs.h

