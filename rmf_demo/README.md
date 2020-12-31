# rmf_demo

Scripts for deploying RMF demo nodes with wireguard as a transport.

## Recipes

This cookbook contains two recipes.
* The `server` recipe configures a host to act as a router and gateway for other wireguard peers.
* The `client` recipe configures a host to peer with the server.

## Required data bags and attributes

The most important configuration detail for this cookbook is the wireguard peer information.
The data bag `rmf_demo_wireguard_peers` should be populated with your peer information.

At least one peer is required with an id of `server`.
Any other peers can be added following the familiar format.
For an example see the [test data bag item](./test/integration/data_bags/rmf_demo_wireguard_peers/server.json).

