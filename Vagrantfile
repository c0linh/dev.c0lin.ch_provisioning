# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :libvirt do |prov|
    prov.cpu_mode="host-passthrough"
    prov.graphics_type="spice"
    prov.video_type="qxl"
    prov.storage_pool_name = "sdb_pool"
    prov.memory = 8192
    prov.cpus = 4
  end

  config.vm.define "mediacenter1" do |dev|
    dev.vm.box = "debian/bookworm64"
    dev.vm.hostname = "mediacenter"
    dev.vm.network :private_network, :ip => "192.168.121.74"
  end

  config.vm.define "userhome1" do |dev|
    dev.vm.network :private_network, :ip => "192.168.121.37"
    dev.vm.box = "debian/bookworm64"
    dev.vm.hostname = "userhome"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.galaxy_roles_path = ".vagrant/galaxy-roles"
    ansible.config_file = "provisioning/ansible.cfg"
    ansible.playbook = "provisioning/playbook.yml"
    ansible.inventory_path = "provisioning/environments/dev"
    ansible.galaxy_role_file = "provisioning/roles/requirements.yml"
    ansible.limit = "all"
  end
end