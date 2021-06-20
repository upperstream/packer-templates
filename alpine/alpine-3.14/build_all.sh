#!/bin/sh
set -e
set -x

if [ "$1" = "-k" ]; then
  keep_going=yes
  shift
else
  keep_going=no
fi

error_count=0
error() {
  if [ $keep_going = "yes" ]; then
    error_count=`expr $error_count + 1`
    return 0
  else
    return 1
  fi
}

for f in vars-alpine-*.json; do
  for g in alpine-3.14-minimal.json alpine-3.14-ansible.json alpine-3.14-dwm.json; do
    packer build -var-file=$f $@ $g || error
  done
done
for f in vars-alpine-*-x86_64.json; do
  packer build -var-file=$f $@ alpine-3.14-docker.json || error
done

if [ "$keep_going" = "yes" ] && [ "$error_count" -gt 0 ]; then
  printf "%d build have failed.\n" "$error_count"
  return 1
fi
