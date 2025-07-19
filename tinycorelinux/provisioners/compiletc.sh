#!/bin/sh
set -e
set -x
tce-load -wi compiletc git python perl5
tce-load -wi "linux-${LINUX_API:-4.2.1}_api_headers" linux-kernel-sources-env
