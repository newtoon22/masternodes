#!/bin/bash
echo "Script para la instalación de AlanisWallet"

git clone https://github.com/AlanisDev/Alanis.git
cd Alanis
wget https://github.com/AlanisDev/Alanis/releases/download/v1.0/Alanis-qt-linux.tar.gz
# cambiar a su
add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev build-essential libtool autotools-dev autoconf pkg-config sudo libssl-dev libboost-all-dev git npm nodejs libminiupnpc-dev redis-server

tar -xzvf Alanis-qt-linux.tar.gz
sudo apt-get install g++ python-dev autotools-dev libicu-dev libbz2-dev
wget -O boost_1_58_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download
tar -xvzf boost_1_58_0.tar.gz

cd boost_1_58_0/

./bootstrap.sh --prefix=/usr/local
user_configFile=`find $PWD -name user-config.jam`
echo "using mpi ;" >> $user_configFile
n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`

sudo ./b2 --with=all -j $n install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf'
sudo ldconfig
sudo apt-get install qtdeclarative5-dev

cd ..

wget https://github.com/google/protobuf/releases/download/v2.6.0/protobuf-2.6.0.tar.gz
tar -xvzf protobuf-2.6.0.tar.gz
cd protobuf-2.6.0/
sudo ./configure
sudo make
sudo make check
sudo make install
sudo ldconfig

echo "Ya archivo finalizado correctamente"
exit




