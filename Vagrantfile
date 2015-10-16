parameters = File.expand_path("../Parameters", __FILE__)
load parameters

$bindmount = <<SCRIPT
echo Executing bindmount ...
mkdir -p /var/shared/cache/
mkdir -p /var/shared/logs/
chown -Rf vagrant:vagrant /var/shared/cache/
chown -Rf vagrant:vagrant /var/shared/logs/
mkdir -p /var/www/vhosts/$1/app/cache/
mkdir -p /var/www/vhosts/$1/app/logs/
sudo mount -o bind /var/shared/cache/ /var/www/vhosts/$1/app/cache/
sudo mount -o bind /var/shared/logs/ /var/www/vhosts/$1/app/logs/
echo ... DONE!
SCRIPT

Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  config.vm.hostname = $vhost
  config.vm.box = $base_box
  config.vm.network :private_network, ip: $private_network_ip
  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/var/vagrant/", type: "nfs"
  config.vm.synced_folder "../", "/var/www/vhosts/" + $app, type: "nfs"

  config.vm.provider :virtualbox do |v|
    v.gui = false
    v.name = $app

    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else
      # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
  end

  config.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  #config.vm.provision "shell", path: "bindmount.sh", run: "always"
  #config.vm.provision "shell", inline: $bindmount, run: "always"

  config.vm.provision :shell, run: "always" do |shell|
      shell.inline = $bindmount
      shell.args = $app
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/vagrant.yml"
    ansible.extra_vars = {
      private_interface: $private_network_ip,
      vhost: $vhost,
      app: $app,
      ntp_timezone: $ntp_timezone,
      database_name: $database_name,
      database_user: $database_user,
      database_password: $database_password,
      nginx_template: $nginx_template
    }
  end
end