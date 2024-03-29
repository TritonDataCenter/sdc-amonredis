<!--
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

<!--
    Copyright (c) 2014, Joyent, Inc.
    Copyright 2022 MNX Cloud, Inc.
-->

# sdc-amonredis

This repository is part of the Triton Data Center project.  For
contribution guidelines, issues, and general documentation, visit the main
[Triton](http://github.com/TritonDataCenter/triton) project page.

## SDC amonredis core zone

SDC 7 has an amonredis zone. This repo builds it. The "amonredis" core zone
runs redis **for Amon's use only**.

A redis instance can have a number of separate databases. By default this is
16, and the current redis config doesn't change that. A redis connection
can select the DB it is using with the
[SELECT](http://redis.io/commands/select) command.

**Warning: Do NOT use the [FLUSHALL](http://www.redis.io/commands/flushall)!
This will blow away data for other apps. Instead use
[FLUSHDB](http://www.redis.io/commands/flushdb).**

## DB index

| DB Index | Service                                              |
| -------- | ---------------------------------------------------- |
| 0        | None. `0` is the default index. By design, no SDC service should use this index. This forces legal redis clients to explicitly choose an assigned DB index.|
| 1        | Amon (the 'amon-master' service in the 'amon' zone). |

## Operators Guide

This section is intended to give necessary information for diagnosing and
dealing with issues with the "redis" zone in a SmartDataCenter installation.

To find the redis zone(s) use the following. Currently there is only one,
though redis clustering *might* be possible at some point.

    sdc-vmapi /vms?owner_uuid=$(bash /lib/sdc/config.sh -json | json ufds_admin_uuid) \
        | json -H -c "this.tags.smartdc_role=='amonredis'"

Look at the "redis" service.

## Logs

| service/path | where                | tail -f                                                 |
| ------------ | -------------------- | ------------------------------------------------------- |
| redis        | in each "redis" zone | `` sdc-login redis; tail -f /var/log/redis/redis.log `` |
