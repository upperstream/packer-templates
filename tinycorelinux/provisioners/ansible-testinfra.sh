tce-load -wi python
tce-load -wi python-dev gmp-dev libffi-dev
tce-load -wi gcc glibc_base-dev linux-4.2.1_api_headers
tce-load -wi squashfs-tools
tce-load -wi python-setuptools

cat << EOF > /tmp/python2tcz.sh
#!/bin/sh
name=\$(echo \$1 | cut -d'=' -f1)
version=\$(echo \$1 | cut -d'=' -f2)
cd /tmp
test -d /tmp/package && rm -rf /tmp/package
mkdir -p /tmp/package
pip install --root=/tmp/package \$name==\$version
mksquashfs package python-\$name-\$version.tcz
find package | sed 's:package/::' > python-\$name-\$version.tcz.list
md5sum python-\$name-\$version.tcz > python-\$name-\$version.tcz.md5.txt
mv python-\$name-\$version.tcz* /mnt/sda1/tce/optional/
tce-load -i python-\$name-\$version.tcz
EOF

chmod +x /tmp/python2tcz.sh

for p in pycparser=2.14 cffi=1.5.0; do
  /tmp/python2tcz.sh $p
done
echo "python-pycparser-2.14.tcz" > /mnt/sda1/tce/optional/python-cffi-1.5.0.tcz.dep

for p in idna=2.0 pyasn1=0.1.9 six=1.10.0 enum34=1.1.2 ipaddress=1.0.16 cryptography=1.3.2; do
  /tmp/python2tcz.sh $p
done
cat << EOF > /mnt/sda1/tce/optional/python-cryptography-1.3.2.tcz.dep
python-idna-2.0.tcz
python-pyasn1-0.1.9.tcz
python-six-1.10.0.tcz
python-enum34-1.1.2.tcz
python-setuptools.tcz
python-ipaddress-1.0.16.tcz
python-cffi-1.5.0.tcz
EOF

/tmp/python2tcz.sh paramiko=1.16.0
cat << EOF > /mnt/sda1/tce/optional/python-paramiko-1.16.0.tcz.dep
python-pyasn1-0.1.9.tcz
python-cryptography-1.3.2.tcz
EOF

for p in MarkupSafe=0.23 jinja2=2.8; do
  /tmp/python2tcz.sh $p
done
echo "python-MarkupSafe-0.23.tcz" > /mnt/sda1/tce/optional/python-jinja2-2.8.tcz.dep

/tmp/python2tcz.sh pycrypto=2.6.1

for p in PyYAML=3.11 ansible=2.1.1.0; do
  /tmp/python2tcz.sh $p
done
cat << EOF > /mnt/sda1/tce/optional/python-ansible-2.1.1.0.tcz.dep
python-paramiko-1.16.0.tcz
python-jinja2-2.8.tcz
python-PyYAML-3.11.tcz
python-setuptools.tcz
python-pycrypto-2.6.1.tcz
EOF

tce-load -i python-ansible-2.1.1.0
echo "python-ansible-2.1.1.0" >> /mnt/sda1/tce/onboot.lst

for p in py=1.4.31 pytest=3.0.1 testinfra=1.4.2; do
  /tmp/python2tcz.sh $p
done
cat << EOF > /mnt/sda1/tce/optional/python-testinfra-1.4.2.tcz.dep
python-py-1.4.31.tcz
python-pytest-3.0.1.tcz
python-six-1.10.0.tcz
EOF

tce-load -i python-testinfra-1.4.2
echo "python-testinfra-1.4.2" >> /mnt/sda1/tce/onboot.lst

tce-audit builddb
for c in squashfs-tools python-dev gmp-dev libffi-dev gcc glibc_base-dev linux-4.2.1_api_headers; do
  tce-audit delete $c
done

sudo filetool.sh -b
sudo reboot
sleep 60
