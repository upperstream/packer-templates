# ansible
# depends on python-devel
if ! which nsenter > /dev/null; then
  yum -y install git
  git clone git://github.com/ansible/ansible.git --recursive
  yum -y install bash-4.1.2-29.el6
  curl https://bootstrap.pypa.io/ez_setup.py | python
  easy_install pip
  yum -y install gcc-4.4.7-11.el6 make-3.81-20.el6
  yum -y install glibc-2.12-1.149.el6
  yum -y install libyaml-0.1.3-1.4.el6
  yum -y install libyaml-devel-0.1.3-1.4.el6
  cd ./ansible && make install
  mkdir -p /home/vagrant/.python-eggs && chown vagrant:vagrant /home/vagrant/.python-eggs && chmod og-rwx /home/vagrant/.python-eggs
fi
