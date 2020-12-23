apt_update
package 'wireguard'

execute 'networkctl-reload' do
  command 'networkctl reload'
  action :nothing
end


wireguard_key = search(:rmf_demo_wireguard_peers, "id:server").first
wireguard_peers = search(:rmf_demo_wireguard_peers, "NOT id:server")
template '/etc/systemd/network/wg0.netdev' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
    private_key: wireguard_key['private_key'],
    wireguard_peers: wireguard_peers
  ]
  notifies :run, 'execute[networkctl-reload]'
end

template '/etc/systemd/network/10-wg0.network' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
  ]
  notifies :run, 'execute[networkctl-reload]'
end

