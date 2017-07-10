# ansible
# depends on python-devel
if ! command -v ansible; then
  yum install -y gcc-${GCC:-4.4.7-17.el6} libffi-3.0.5-3.2.el6 libffi-devel-3.0.5-3.2.el6 python-devel-${PYTHON_DEVEL:-2.6.6-64.el6} gpm-devel-${GPM_DEVEL:-4.3.1-10.el6} openssl-devel-${OPENSSL_DEVEL:-1.0.1e-48.el6_8.1}
  curl https://bootstrap.pypa.io/get-pip.py | python -
  pip install ansible==${ANSIBLE:-2.2.1.0}
fi
