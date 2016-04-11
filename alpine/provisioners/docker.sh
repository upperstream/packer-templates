sed -i 's/#http://dl-6\.alpinelinux\.org/alpine/edge/community/http://dl-6.alpinelinux.org/alpine/edge/community' /etc/apk/repositories
if ! ( grep -q "^http://dl-6\.alpinelinux\.org/alpine/edge/community" /etc/apk/repositories ); then
  echo "http://dl-6.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
  echo "Updated /etc/apk/repositories"
fi
apk --update add docker
rc-update add docker boot
adduser vagrant docker
