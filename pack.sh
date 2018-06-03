#!/bin/bash
echo "Script para la instalación de Librerias para Wallets"

#MODE SU PARA LOS PERMISOS
su

#REPOSITORIO
add-apt-repository ppa:bitcoin/bitcoin

#ACTUALIZAR
apt-get update && apt-get upgrade

#INSTALACION DE LIB Y PROGRAMAS
sudo apt-get install qtdeclarative5-dev libicu-dev libbz2-dev g++ python-dev autotools-dev libdb4.8-dev libdb4.8++-dev build-essential libtool autotools-dev autoconf pkg-config sudo libssl-dev libboost-all-dev git npm nodejs libminiupnpc-dev redis-server libminiupnpc-dev

#INSTALACION DE Boost 1.58
cd /
mkdir wallet && cd wallet
wget -O boost_1_58_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download
tar -xvzf boost_1_58_0.tar.gz
cd boost_1_58_0/

#Esto es para la instalacion del Boost, solo entiendo que ejecuta el bootstrap.sh que trae y utiliza el prefix para especificar la ruta,
#cosa que deberia ser innecesaria, pero lo deje tal cual porque asi me funciono.

./bootstrap.sh --prefix=/usr/local
user_configFile=`find $PWD -name user-config.jam`
echo "using mpi ;" >> $user_configFile
n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
sudo ./b2 --with=all -j $n install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf'
sudo ldconfig

#INSTALACION PROTOBUF
cd /wallet/
wget https://github.com/google/protobuf/releases/download/v2.6.0/protobuf-2.6.0.tar.gz
tar -xvzf protobuf-2.6.0.tar.gz
cd protobuf-2.6.0/
sudo ./configure
sudo make
sudo make check
sudo make install
sudo ldconfig

#Cuando hice la instalacion en VM con eso se completo con menos librerias que con la VPS, me imagino que se debe que la VPS hice la
#instalación minima y faltaron librerias.

#Hay que destacar que hizo falta la instalacion de un paquete, libdb4.8-dev, dejo la inslacion manual por si hace falta.

#Instalacion Libdb4.8
cd /wallet
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx
make
make install

# En los pasos anteriores, se debio instalar la lib, y lo que debio hacer falta fue estos comandos de indicaciones, sin embargo, volvi
#a descargar e instalar todo manualmente.
export BDB_INCLUDE_PATH=”/usr/local/BerkeleyDB.4.8/include”
export BDB_LIB_PATH=”/usr/local/BerkeleyDB.4.8/lib”
sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so

#Ya con todo esto logre instalar Alanis, lo que quedaba era descargar la wallet y el masternode, de lo cual, solo usamos la wallet.
echo "Instalacion de paquetes completas, feliz dia"
exit

#ARCHIVOS DE ALANIS
#cd && mkdir nodes && cd nodes
#git clone https://github.com/AlanisDev/Alanis.git
#cd Alanis
#wget https://github.com/AlanisDev/Alanis/releases/download/v1.0/Alanis-qt-linux.tar.gz
#tar -xzvf Alanis-qt-linux.tar.gz



