# -*- mode: ruby -*-
# vi: set ft=ruby :
domain="dev.c0lin.local"
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :libvirt do |prov|
    prov.cpu_mode="host-passthrough"
    prov.default_prefix = ""
    prov.graphics_type="spice"
    prov.video_type="qxl"
    prov.storage_pool_name = "pool"
    prov.memory = 4096
    prov.cpus = 1
    prov.management_network_name = "vagrant_dev_local"
    prov.management_network_keep = "true"
  end

  [ "cacheproxy1", "mediacenter1", "controller1" ].each { |name|
    config.vm.define "#{name}" do |dev|
      dev.vm.hostname = "#{name}.#{domain}"
      dev.vm.box = "debian/bookworm64"
    end
  }

  config.vm.provision "ansible" do |ansible|
    ansible.galaxy_roles_path = ".vagrant/galaxy-roles"
    ansible.galaxy_role_file = "provisioning/roles/requirements.yml"
    ansible.config_file = "ansible.cfg"
    ansible.playbook = "provisioning/playbook.yml"
    ansible.inventory_path = "provisioning/environments/dev"
    # ansible.limit = "all"
    # verbose = true
  end
end