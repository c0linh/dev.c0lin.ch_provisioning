# -*- mode: ruby -*-
# vi: set ft=ruby :
$playbook = "deploy.yml"
#$other_args ="--extra-vars 'server_groups=acesproxy'"
$storage_pool_name = "sdb_pool" #use "default" for a vanilla installation
$ssh_key = <<-SCRIPT
cat /vagrant/.ssh/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  config.vm.synced_folder "ansible", "/vagrant", type: "rsync"
  if Vagrant.has_plugin?("vagrant-hostmanager")
    #config.hostmanager.enabled = true
    config.hostmanager.manage_guest = true
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.network "private_network", type: "dhcp"

  config.vm.provider :libvirt do |prov|
    prov.cpu_mode="host-passthrough"
    prov.graphics_type="spice"
    prov.video_type="qxl"
    prov.storage_pool_name = $storage_pool_name
    prov.username = "root"
    prov.password = ""
    prov.memory = 8000
    prov.cpus = 2
  end

  config.vm.provision "add controllers public key", type: "shell", 
    privileged: false, inline: $ssh_key

  config.vm.define "development" do |dev|
    dev.vm.hostname = "development"
    dev.vm.provider :libvirt do |additional|
      additional.storage :file, :size => '4G', :device => 'sdb'
    end

    dev.vm.provision "locale and partition", type: "shell", 
    privileged: true, inline: <<-EOF
      #export DEBIAN_FRONTEND=noninteractive
      echo -e "en_US.UTF-8 UTF-8\nde_CH.UTF-8 UTF-8" > /etc/locale.gen 
      locale-gen
      apt-get -y install parted ntfs-3g
      parted -s /dev/vdb \
        mklabel gpt \
        mkpart primary ntfs 0% 100%
      mkfs -t ntfs -f -L DATA /dev/vdb1
    EOF
  end

  config.vm.define "controller" do |controller|
    controller.vm.hostname = "controller"

    #this ensures that ansible is installed and fixes the wired 
    #
    controller.vm.provision "install", type: "shell", 
    privileged: true, inline: <<-EOF
      export DEBIAN_FRONTEND=noninteractive
      echo -e "en_US.UTF-8 UTF-8\nde_CH.UTF-8 UTF-8" > /etc/locale.gen 
      locale-gen
      echo locales locales/default_environment_locale select en_US.UTF-8 | debconf-set-selections
      dpkg-reconfigure locales
      apt-get install -y ansible git
    EOF

    # install ansible and ssh private keys
    controller.vm.provision "ssh", type: "shell", 
    privileged: false, inline: <<-EOF
      cp -r /vagrant/.ssh /home/vagrant
      chown vagrant:vagrant /home/vagrant/.ssh
      chmod 600 /home/vagrant/.ssh/id_*
      ssh-keyscan github.com >> /home/vagrant/.ssh/known_hosts
    EOF

    # run ansible
    controller.vm.provision "ansible", type: "shell", 
    privileged: false, inline: <<-EOF
      rm -rf /tmp/provisioning
      cp -r /vagrant /tmp/provisioning
      cd /tmp/provisioning
      [ -s requirements.yml ] && ansible-galaxy install -r requirements.yml
      ansible-playbook -i dev-hosts.ini deploy.yml
    EOF

    controller.vm.provider :libvirt do |prov|
      prov.memory = 384
      prov.cpus = 1
    end
  end
end