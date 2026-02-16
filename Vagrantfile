Vagrant.configure("2") do |config|
  config.vm.box = "jlefonde/debian12-devops-desktop"
  config.vm.box_version = "1.0.1"
  
  config.vm.hostname = "devops-desktop"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "devops-desktop"
    # vb.memory = "16384"
    vb.cpus = "12"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/vagrant.yml"
    ansible.extra_vars = "ansible/vars/vagrant.yml"
  end
end
