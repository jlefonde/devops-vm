packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

source "virtualbox-iso" "debian" {
  guest_os_type = "Debian_64"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = "vagrant"
  ssh_password = "vagrant"

  memory = 8192
  cpus = 8
  # TODO: remove
  disk_size = 20480

  ssh_timeout = "10m"
  output_directory = var.output_dir

  gfx_controller = "vmsvga"
  gfx_vram_size = 128
  gfx_accelerate_3d = true
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"

  http_directory = "${path.root}/${var.http_dir}"
  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "install ",
    "auto=true ",
    "priority=critical ",
    "netcfg/get_hostname=devops-desktop ",
    "netcfg/get_domain=localdomain ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<enter><wait>"
  ]
}

build {
  name = "devops"
  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    script = "${path.root}/../scripts/setup.sh"
    execute_command = "echo 'vagrant' | {{ .Vars }} su -c '{{ .Path }}'"
  }

  provisioner "shell" {
    only = ["virtualbox-iso.debian"]
    script = "${path.root}/../scripts/install-vbox-guest-additions.sh"
    execute_command = "echo 'vagrant' | {{ .Vars }} su -c '{{ .Path }}'"
  }

  provisioner "ansible" {
    playbook_file = "${path.root}/../ansible/packer.yml"
    user          = "vagrant"
  }

 post-processors {
  post-processor "vagrant" {
    output = "${var.output_dir}/${var.box_name}-{{.Architecture}}-{{.Provider}}.box"
    vagrantfile_template = "${path.root}/Vagrantfile.tpl"
  }

  post-processor "vagrant-registry" {
    box_tag       = "${var.organization}/${var.box_name}"
    version       = "${var.box_version}"
    architecture  = "${var.box_architecture}"
    client_id     = "${var.hcp_client_id}"
    client_secret = "${var.hcp_client_secret}"
  }
 }
}
