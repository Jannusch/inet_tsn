//
// Copyright (C) 2023 Jannusch Bigge <jannusch.bigge@mailbox.tu-dresden.de>
//
//
// SPDX-License-Identifier: GPL-2.0-or-later
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.
//

package soc_e_simulator.base;

import inet.node.tsn.TsnSwitch;

module mTsnKit extends TsnSwitch
{
    parameters:
        @display("i=block/switch");
        // num 0-3 are the switching ports (1-4)
        // num 4 is the managment port
        numEthInterfaces=4;
        *.ethg[*].bitrate = default(1Gbps);

        // IEEE 802.1AS
        hasTimeSynchronization = true;



    
}
