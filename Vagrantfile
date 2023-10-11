# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true

  config.vm.provider :libvirt do |prov|
    prov.cpu_mode="host-passthrough"
    prov.graphics_type="spice"
    prov.video_type="qxl"
    prov.storage_pool_name = "sdb_pool"
    prov.username = "root"
    prov.password = ""
    prov.memory = 2048
    prov.cpus = 2
  end

  config.vm.define "dev" do |dev|
    dev.vm.hostname = "mediacenter"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.galaxy_roles_path = ".vagrant/galaxy-roles"
    ansible.galaxy_role_file = "provisioning/requirements.yml"
    ansible.playbook = "provisioning/playbook.yml"
    # ansible.verbose = "-vvv"
    # ansible.host_vars = {
    # }
    ansible.groups = {
      "all:vars" => { "env" => "dev" }
    }
  end
end