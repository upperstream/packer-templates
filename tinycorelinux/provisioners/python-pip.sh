set -e
set -x
cd /tmp
test -d package && rm -rf package
mkdir /tmp/package
wget -O - https://bootstrap.pypa.io/get-pip.py | python - --no-setuptools --no-wheel --root=/tmp/package
mksquashfs package python-pip.tcz
find package | sed 's:^package/::' > python-pip.tcz.list
md5sum python-pip.tcz > python-pip.tcz.md5.txt
mv python-pip.tcz* /mnt/sda1/tce/optional/
echo "python-pip" >> /mnt/sda1/tce/onboot.lst 
tce-load -i python-pip
