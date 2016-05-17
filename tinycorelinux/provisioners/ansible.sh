tce-load -wi python
tce-load -wil python-dev gmp-dev libffi-dev
tce-load -wil gcc glibc_base-dev linux-4.2.1_api_headers
sudo ln -s /usr/local/lib/libffi-3.2.1/include /usr/include/ffi
tce-load -wil python-setuptools
sudo sed -i '/openssh start$/i\
sudo -u tc tce-load -il python-dev gmp-dev libffi-dev\
sudo -u tc tce-load -il gcc glibc_base-dev linux-4.2.1_api_headers\
sudo -u tc tce-load -il python-setuptools\
sudo easy_install pip\
test -d /usr/local/lib/libffi-3.2.1/include && ln -s /usr/local/lib/libffi-3.2.1/include /usr/include/ffi\
pip install --upgrade setuptools\
pip install ansible' /opt/bootsync.sh
