##ftp -o "| tar --unlink -zxpf - -C /" ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-`uname -r`/`uname -m`/binary/sets/comp.tgz
pkg_add python27-2.7.9nb1 curl-7.42.0
curl -k https://bootstrap.pypa.io/get-pip.py | python2.7 -
pkg_add py27-paramiko
pip install ansible==2.1.0.0 testinfra==1.4.0
