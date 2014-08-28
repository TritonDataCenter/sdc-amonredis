#!/usr/bin/bash
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2014, Joyent, Inc.
#

set -o xtrace
set -o errexit

RELEASE_TARBALL=$1
echo "Building ${RELEASE_TARBALL}"

ROOT=$(pwd)

tmpdir="/tmp/redis.$$"
mkdir -p ${tmpdir}/root/var/svc
mkdir -p ${tmpdir}/root/var/tmp
mkdir -p ${tmpdir}/site

cp ${ROOT}/redis.smf ${tmpdir}/root/var/tmp
cp ${ROOT}/redis-2.4.1.tar.bz2 ${tmpdir}/root/var/svc

mkdir -p ${tmpdir}/root/opt/smartdc/boot
cp -R ${ROOT}/deps/sdc-scripts/* ${tmpdir}/root/opt/smartdc/boot/
cp -R ${ROOT}/boot/* ${tmpdir}/root/opt/smartdc/boot/

mkdir -p ${tmpdir}/root/opt/smartdc/amonredis
cp -PR ${ROOT}/sapi_manifests ${tmpdir}/root/opt/smartdc/amonredis

(cd ${tmpdir}; tar -jcf ${ROOT}/${RELEASE_TARBALL} root site)

rm -rf ${tmpdir}
