# fig
if ! which fig > /dev/null; then
  curl -Lso /usr/local/bin/fig https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m`
  chmod +x /usr/local/bin/fig
fi
