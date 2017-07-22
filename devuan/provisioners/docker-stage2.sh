#!/bin/sh
set -e
set -x

apt-get -y install cgroupfs-mount
cat > /etc/init.d/docker << 'EOF'
#!/bin/sh

### BEGIN INIT INFO
# Provides:       docker
# Required-Start: $network
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start: 2 3 4 5
# Default-Stop:  0 1 6
# Short-Description: docker daemon
# Description: Daemon for Docker
### END INIT INFO

# Source function library.
. /lib/lsb/init-functions

prog=docker
executable=/usr/bin/${prog}d
pidfile=/var/run/$prog.pid
lockfile=/var/lock/subsys/$prog
logfile=/var/log/$prog

start() {
    log_daemon_msg "Starting $prog daemon" "$prog"
    start-stop-daemon --start --quiet --oknodo --pidfile $pidfile --exec $executable --background
    log_end_msg $?
}

stop() {
    log_daemon_msg "Stopping $prog daemon" "$prog"
    start-stop-daemon --stop --quiet --oknodo --retry 5 --pidfile $pidfile --exec $executable
    log_end_msg $?
}

restart() {
    stop
    start
}

reload() {
    restart
}

force_reload() {
    restart
}

case "$1" in
    start|stop|reload|force-reload|restart)
        $1
        ;;
    status)
        status_of_proc -p $pidfile "$executable" $prog
        exit $?
        ;;
    *)
        echo "Usage: $0 {start|stop|reload|force-reload|restart|status}"
        exit 1
esac

exit 0
EOF

chmod +x /etc/init.d/docker
/usr/sbin/update-rc.d docker defaults

apt-get -y install ${PYTHON_PIP:-python-pip}
pip install ${DOCKER_COMPOSE:=docker-compose}
