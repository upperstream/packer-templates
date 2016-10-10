#!/bin/sh -ex

test -z "$SLIM" && SLIM=slim
test -z "$SLIM_THEMES" && SLIM_THEMES=slim-themes

pkg install -y $SLIM $SLIM_THEMES $ARNADR
echo 'slim_enable="YES"' >> /etc/rc.conf

cp /usr/local/etc/slim.conf /usr/local/etc/slim.conf.orig
sed '/current_theme/s/default/fbsd/' /usr/local/etc/slim.conf.orig > /usr/local/etc/slim.conf
