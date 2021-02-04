apt_update

package 'wireguard'

execute 'networkctl-reload' do
  command 'networkctl reload'
  action :nothing
end

sysctl 'ipv4-forwarding' do
  comment 'Forward IPv4 traffic for WireGuard VPN'
  key 'net.ipv4.ip_forward'
  value 1
end

wireguard_server = search(:rmf_demo_wireguard_peers, "id:server").first
wireguard_peers = search(:rmf_demo_wireguard_peers, "NOT id:server")
template '/etc/systemd/network/wg0.netdev' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
    private_key: wireguard_server['private_key'],
    wireguard_peers: wireguard_peers
  ]
  notifies :run, 'execute[networkctl-reload]'
end
template '/etc/systemd/network/10-wg0.network' do
  owner 'root'
  group 'systemd-network'
  mode '0640'
  variables Hash[
    address: wireguard_server['address']
  ]
  notifies :run, 'execute[networkctl-reload]'
end

# Set up ROS 2 and RMF
apt_repository 'ros2' do
  uri 'http://packages.ros.org/ros2/ubuntu'
  components %w[main]
  key 'https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc'
end

apt_repository 'gazebo' do
  uri 'https://packages.osrfoundation.org/gazebo/ubuntu-stable/'
  components %w[main]
  key 'https://packages.osrfoundation.org/gazebo.key'
end

#apt_repository 'rmf' do
#  uri 'http://rmf.servehttp.com/ubuntu/main'
#  components %w[main]
#  key 'http://rmf.servehttp.com/repos.key'
#end

#package 'ros-foxy-demos'
