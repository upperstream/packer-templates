# ansible
# depends on python-devel
#if [ ! command -v ansible ]; then
  yum install -y gcc-4.4.7-17.el6 libffi-3.0.5-3.2.el6 libffi-devel-3.0.5-3.2.el6 python-devel-2.6.6-64.el6 gmp-devel-4.3.1-10.el6 openssl-devel-1.0.1e-48.el6_8.1
  curl https://bootstrap.pypa.io/get-pip.py | python -
  pip install ansible
#fi
