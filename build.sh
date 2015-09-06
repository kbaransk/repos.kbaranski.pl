#!/bin/sh

## Assign basic configuration
DIR=$(dirname $0)

mkdir -p ${DIR}/dists/jessie/main/binary-amd64/ ${DIR}/dists/jessie/main/binary-i386/ ${DIR}/dists/jessie/main/binary-all/ ${DIR}/dists/jessie/main/source/ ${DIR}/pool/

dpkg-scanpackages --multiversion --arch amd64 ${DIR}/pool /dev/null > ${DIR}/dists/jessie/main/binary-amd64/Packages
dpkg-scanpackages --multiversion --arch i386  ${DIR}/pool /dev/null > ${DIR}/dists/jessie/main/binary-i386/Packages
dpkg-scanpackages --multiversion --arch all   ${DIR}/pool /dev/null > ${DIR}/dists/jessie/main/binary-all/Packages
dpkg-scansources                              ${DIR}/pool /dev/null > ${DIR}/dists/jessie/main/source/Sources

for f in ${DIR}/dists/jessie/main/binary-amd64/Packages ${DIR}/dists/jessie/main/binary-i386/Packages ${DIR}/dists/jessie/main/binary-all/Packages ${DIR}/dists/jessie/main/source/Sources
do
  if [ -f $f ]
  then
    gzip -9c $f > $f.gz
  fi
done

apt-ftparchive -c=${DIR}/conf/apt-ftparchive.conf --arch amd64 contents ${DIR}/dists/jessie | gzip -9c > ${DIR}/dists/jessie/main/Contents-amd64.gz
apt-ftparchive -c=${DIR}/conf/apt-ftparchive.conf --arch i386  contents ${DIR}/dists/jessie | gzip -9c > ${DIR}/dists/jessie/main/Contents-i386.gz
apt-ftparchive -c=${DIR}/conf/apt-ftparchive.conf --arch all   contents ${DIR}/dists/jessie | gzip -9c > ${DIR}/dists/jessie/main/Contents-all.gz

/bin/rm ${DIR}/dists/jessie/Release
apt-ftparchive -c=${DIR}/conf/apt-ftparchive.conf release ${DIR}/dists/jessie > ${DIR}/tmp
mv ${DIR}/tmp ${DIR}/dists/jessie/Release


/bin/rm -f ${DIR}/dists/jessie/Release.gpg ${DIR}/dists/jessie/InRelease

gpg --no-tty --batch --default-key ${GPGKEY} --detach-sign -o ${DIR}/dists/jessie/Release.gpg ${DIR}/dists/jessie/Release
gpg --no-tty --batch --default-key ${GPGKEY} --clearsign -o ${DIR}/dists/jessie/InRelease ${DIR}/dists/jessie/Release