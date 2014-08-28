<!--
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

<!--
    Copyright (c) 2014, Joyent, Inc.
-->

# SDC "amonredis" core zone

- Repository: <git@git.joyent.com:amonredis.git>, <https://mo.joyent.com/amonredis>
- Who: Trent
- Docs: <https://mo.joyent.com/docs/amonredis>
- Tickets/bugs: <https://devhub.joyent.com/jira/browse/MON>
- CI builds: <https://jenkins.joyent.us/job/amonredis>,
  <https://bits.joyent.us/builds/amonredis/>


This repo is responsible for building the fs-tarball for the SmartDataCenter
(SDC) "amonredis" zone. See the docs for more details. This differs from the
"redis" sdc core zone in that it is used solely by Amon (to buffer against
load from the other caching-only users of redis).

