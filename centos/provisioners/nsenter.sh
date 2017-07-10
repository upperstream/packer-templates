# nsenter
# depends: docker-io
command -v docker || (
  echo "Docker (docker-io) must be installed in advance."
  exit 1
)
command -v nsenter || (
  test -d /usr/local/bin || mkdir -p /usr/local/bin
  service docker start
  docker run --rm jpetazzo/nsenter cat /nsenter > /usr/local/bin/nsenter && chmod +x /usr/local/bin/nsenter && strip /usr/local/bin/nsenter
  service docker stop
)
