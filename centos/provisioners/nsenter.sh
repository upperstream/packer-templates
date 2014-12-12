# nsenter
# depends: docker-io
if ! which docker; then
  echo "Docker (docker-io) must be installed in advance."
  exit 1
fi
if ! which nsenter > /dev/null; then
  test -d /usr/local/bin || mkdir -p /usr/local/bin
  service docker start
  while ! service docker status; do sleep 10; done
  docker run --rm jpetazzo/nsenter cat /nsenter > /usr/local/bin/nsenter && chmod +x /usr/local/bin/nsenter && strip /usr/local/bin/nsenter
fi
