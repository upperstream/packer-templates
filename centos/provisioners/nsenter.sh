# nsenter
# depends: docker-io
if ! which nsenter > /dev/null; then
  test -d /usr/local/bin || mkdir -p /usr/local/bin
  service docker start
  while ! service docker status; do sleep 10; done
  docker run --rm jpetazzo/nsenter cat /nsenter > /usr/local/bin/nsenter && chmod +x /usr/local/bin/nsenter && strip /usr/local/bin/nsenter
fi
