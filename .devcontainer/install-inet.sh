#!/bin/bash

#
# Copyright (C) 2023 Jannusch Bigge
#
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

# This script needs the following environment variables to be set:
#   - INET_VERSION: the version of INET to install (e.g. 4.5.0)

# abort if one of the environment variables is not set
if [ -z "$INET_VERSION" ]; then
    echo "INET_VERSION is not set"
    exit 1
fi

set -e

# download and unpack OMNeT++ if not already done
cd /opt
if [ ! -d inet-${INET_VERSION} ]; then
    mkdir -p inet-${INET_VERSION}
    cd inet-${INET_VERSION}
    curl --location https://github.com/inet-framework/inet/releases/download/v${INET_VERSION}/inet-${INET_VERSION}-src.tgz | tar -xzv --strip-components=1
fi

cd /opt
ln -sf inet-${INET_VERSION} inet

# enable ccache
export PATH=/usr/lib/ccache:$PATH

# build INET
cd /opt/inet
export PATH=$PATH:/opt/omnetpp/bin
source setenv
CC=clang-13 CXX=clang++-13 make makefiles
make -j$(nproc) MODE=debug
make -j$(nproc) MODE=release
