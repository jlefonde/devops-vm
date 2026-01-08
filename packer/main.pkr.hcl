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
    }
}

source "virtualbox-iso" "debian" {
  guest_os_type = "Debian_64"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = "vagrant"
  ssh_password = "vagrant"

  memory = 8192
  cpus = 4

  ssh_timeout = "10m"
  output_directory = var.output_directory

  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"

  http_directory = var.http_directory
  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "install ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US ",
    "netcfg/get_hostname={{ .Name }} ",
    "netcfg/get_domain=localdomain ",
    "time/zone=UTC ",
    "passwd/root-password=vagrant ",
    "passwd/root-password-again=vagrant ",
    "passwd/user-fullname=vagrant ",
    "passwd/username=vagrant ",
    "passwd/user-password=vagrant ",
    "passwd/user-password-again=vagrant ",
    "fb=false debconf/frontend=noninteractive ",
    "keyboard-configuration/xkb-keymap=us  ",
    "console-setup/ask_detect=false ",
    "<enter><wait>"
  ]
}

build {
  name = "devops"
  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    inline = [
      "echo 'vagrant ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant",
      "chmod 0440 /etc/sudoers.d/vagrant"
    ]
    execute_command = "echo 'vagrant' | {{ .Vars }} su -c '{{ .Path }}'"
  }

  provisioner "ansible" {
    playbook_file = "../ansible/main.yml"
  }
}