#!/bin/sh -ex
apk add "${SLIM:-slim}" "${SLIM_THEMES:-slim-themes}"
rc-service slim start
rc-update add slim
