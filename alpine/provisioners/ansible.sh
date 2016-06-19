apk add python py-pip python-dev
apk add alpine-sdk
apk add libffi openssl
apk add libffi-dev openssl-dev
pip install ansible==2.1.0.0 testinfra==1.2.0
apk del alpine-sdk libffi-dev openssl-dev python-dev
