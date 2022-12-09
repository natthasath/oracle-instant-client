#!/usr/bin/env bash

wget -P ./oracle-instantclient/ https://download.oracle.com/otn/linux/instantclient/122010/instantclient-sdk-linux.x64-12.2.0.1.0.zip
wget -P ./oracle-instantclient/ https://download.oracle.com/otn/linux/instantclient/122010/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip
wget -P ./oracle-instantclient/ https://download.oracle.com/otn/linux/instantclient/122010/instantclient-basic-linux.x64-12.2.0.1.0.zip

cp -r ./oracle-instantclient/ /tmp

sudo mkdir -p /opt/oracle
sudo chown -R $USER /opt/oracle/
sudo apt install unzip -y
sudo apt install zip libaio1 -y

unzip /tmp/oracle-instantclient/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /opt/oracle
unzip /tmp/oracle-instantclient/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /opt/oracle
unzip /tmp/oracle-instantclient/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /opt/oracle

mv /opt/oracle/instantclient_12_2 /opt/oracle/instantclient

rm -rf /tmp/oracle-instantclient/instantclient*

ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so

cp ./tnsnames.ora /opt/oracle/instantclient

cd ~/

echo 'export ORACLE_HOME=/opt/oracle/instantclient' >> /home/$1/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME' >> /home/$1/.bashrc
echo 'export OCI_HOME=/opt/oracle/instantclient' >> /home/$1/.bashrc
echo 'export OCI_LIB_DIR=/opt/oracle/instantclient' >> /home/$1/.bashrc
echo 'export OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include' >> /home/$1/.bashrc
echo 'export PATH=$ORACLE_HOME:$PATH' >> /home/$1/.bashrc

source ~/.bashrc
