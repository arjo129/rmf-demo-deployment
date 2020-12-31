if node['platform'] != 'ubuntu'
  Chef::Log.fatal "Only Ubuntu releases are supported at this time."
  raise
end

case node['platform_version']
when '16.04'
  package 'wireguard-tools'
  package 'wireguard-dkms'
when '18.04'
  package 'wireguard-tools'
  package 'wireguard-dkms'
when '20.04'
  package 'wireguard'
else
  Chef::Log.fatal "Unsupported platform version #{node['platform_version']}"
  raise
end

wireguard_server = search(:rmf_demo_wireguard_peers, "id:server").first
Chef::Log.warn("WIRECUARD GLIENT ID: #{node['rmf_demo']['wireguard_client_id']}")
wireguard_self = search(:rmf_demo_wireguard_peers, "id:peer01").first
execute 'networkctl-reload' do
  command 'networkctl reload'
  action :nothing
end
template '/etc/systemd/network/wg0.netdev' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
    private_key: wireguard_self['private_key'],
    wireguard_peers: [wireguard_server]
  ]
  notifies :run, 'execute[networkctl-reload]'
end
template '/etc/systemd/network/10-wg0.network' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
    address: wireguard_self['address'],
    gateway: wireguard_server['address']
  ]
end

