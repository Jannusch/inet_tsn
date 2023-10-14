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

package soc_e_simulator.examples.rely;

import inet.networks.base.TsnNetworkBase;
import inet.node.contract.IEthernetNetworkNode;
import inet.node.ethernet.EthernetLink;

import inet.applications.ethernet.*;

import inet.node.tsn.TsnDevice;
import inet.node.tsn.TsnSwitch;

network TSNNetwork extends TsnNetworkBase
{
    parameters:
        *.eth[*].bitrate = default(1Gbps);
    submodules:
        talker: <default("TsnDevice")> like IEthernetNetworkNode {
        }
        traffic_generator: <default("TsnSwitch")> like IEthernetNetworkNode {
            numEthInterfaces=1;
        }
        switch[3]: <default("TsnSwitch")> like IEthernetNetworkNode {
            numEthInterfaces=5;
        }
        listener: <default("TsnDevice")> like IEthernetNetworkNode {
        }
    connections allowunconnected:
        talker.ethg++ <--> EthernetLink <--> switch[0].ethg[0];
        switch[0].ethg[1] <--> EthernetLink <--> switch[1].ethg[1];
        switch[1].ethg[4] <--> EthernetLink <--> switch[2].ethg[0];

        // connection from N12 to traffic generator
        switch[1].ethg[2] <--> EthernetLink <--> traffic_generator.ethg[0];
        //traffic_generator.ethg[4] <--> EthernetLink <--> switch[1].ethg[3];

        switch[2].ethg[1] <--> EthernetLink <--> listener.ethg++;
        

}