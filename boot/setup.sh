#!/usr/bin/bash
# -*- mode: shell-script; fill-column: 80; -*-
#
# Copyright (c) 2013 Joyent Inc., All rights reserved.
#

export PS4='[\D{%FT%TZ}] ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -o xtrace

PATH=/opt/redis/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin

role=amonredis

# Include common utility functions (then run the boilerplate)
source /opt/smartdc/boot/lib/util.sh
CONFIG_AGENT_LOCAL_MANIFESTS_DIRS=/opt/smartdc/$role
sdc_common_setup

# Cookie to identify this as a SmartDC zone and its role
mkdir -p /var/smartdc/amonredis

# Mount our delegate dataset at '/data'.
zfs set mountpoint=/data zones/$(zonename)/data

# Install Redis
cd /opt
/usr/bin/gtar -jxf /var/svc/redis-2.4.1.tar.bz2
mkdir -p /data/redis /var/log/redis
/usr/sbin/groupadd redis
/usr/sbin/useradd -d /opt/redis -s /usr/bin/bash -g redis redis
/usr/bin/passwd -l redis
/usr/sbin/projadd -c "Redis Tunings" -K "process.max-file-descriptor=(basic,65535,deny),(priv,65535,deny)" -U redis -G redis redis
/usr/bin/chown -R redis:redis /opt/redis /data/redis /var/log/redis
rm -f /var/svc/redis-2.4.1.tar.bz2

# Log rotation.
sdc_log_rotation_add amon-agent /var/svc/log/*amon-agent*.log 1g
sdc_log_rotation_add config-agent /var/svc/log/*config-agent*.log 1g
sdc_log_rotation_add registrar /var/svc/log/*registrar*.log 1g
sdc_log_rotation_setup_end

# All done, run boilerplate end-of-setup
sdc_setup_complete

exit 0
