sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
python - << "EOF"
import ConfigParser
config = ConfigParser.SafeConfigParser()
config.read("/etc/yum.repos.d/CentOS-Base.repo")
if config.has_section("base"):
  config.remove_option("base", "mirrorlist")
  config.set("base", "baseurl", "http://vault.centos.org/7.0.1406/os/$basearch/")
if config.has_section("updates"):
  config.remove_option("updates", "mirrorlist")
  config.set("updates", "baseurl", "http://vault.centos.org/7.0.1406/updates/$basearch/")
if config.has_section("addons"):
  config.remove_option("addons", "mirrorlist")
  config.set("addons", "baseurl", "http://vault.centos.org/7.0.1406/addons/$basearch/")
if config.has_section("extras"):
  config.remove_option("extras", "mirrorlist")
  config.set("extras", "baseurl", "http://vault.centos.org/7.0.1406/extras/$basearch/")
if config.has_section("centosplus"):
  config.remove_option("centosplus", "mirrorlist")
  config.set("centosplus", "baseurl", "http://vault.centos.org/7.0.1406/centosplus/$basearch/")
if config.has_section("contrib"):
  config.remove_option("contrib", "mirrorlist")
  config.set("contrib", "baseurl", "http://vault.centos.org/7.0.1406/contrib/$basearch/")
with open("/etc/yum.repos.d/CentOS-Base.repo", "w") as configfile:
  config.write(configfile)
EOF
yum -y install sudo-1.8.6p7-11.el7
