Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.name = "devops-desktop"
    vb.hostname = "devops-desktop"
    vb.gui = true
  end
end
