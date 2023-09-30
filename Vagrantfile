Vagrant.configure("2") do |config|
  config.vm.define :pxeclient do |pxeclient|
    pxeclient.vm.provider :libvirt do |domain|
      domain.boot 'network'
    end
  end
end



# Vagrant.configure("2") do |config|
#   config.vm.box = "debian/bookworm64"
#   config.vm.network "private_network", type: "dhcp"
  
#   config.disksize.size = '5GB'
#   config.hostmanager.enabled = true
#   config.hostmanager.manage_guest = true

#   config.vm.provider :libvirt do |prov|
#     prov.cpu_mode="host-passthrough"
#     prov.graphics_type="spice"
#     prov.video_type="qxl"
#     prov.storage_pool_name = "sdb_pool"
#     prov.username = "root"
#     prov.password = ""
#     prov.memory = 512
#     prov.cpus = 1
#   end

#   config.vm.define "dev" do |dev|
#     dev.vm.hostname = "dev"
#   end

  
#   # config.vm.provision "ansible" do |ansible|
#   #   ansible.playbook = "provisioning/playbook.yml"
#   # end
# end