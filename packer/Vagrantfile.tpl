Vagrant.configure("2") do |config|
  config.vm.hostname = "devops-desktop"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "devops-desktop"
    vb.gui = true
  end
end
