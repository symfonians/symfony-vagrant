Vagrant and Ansible receipe for Symfony development
===================================================

This project allow to easily start a symfony project using Vagrant and Ansible for environment and provisioning setup

## Before you start

This project aim to help you in your first steps with developing Symfony apps with a Vagrant environment.
If you notice anything that should be improved, please contribute :)

## Prerequisites

This project do not cover the installation and introduction to Vagrant and Ansible. It suppose you've already tried both tutorials and that you have installed the following softwares on your computer:

- VirtualBox (https://www.virtualbox.org/)
- Vagrant (http://www.vagrantup.com/)
- Ansible (http://www.ansible.com/home)

## Installation

After you have installed the prerequisites softwares, just clone this repository on the root of your Symfony project:

```bash
cd your-project
git clone https://github.com/symfonians/symfony-vagrant.git vagrant
```

Copy the Parameters.dist file into Parameters file:

```bash
cp vagrant/Parameters.dist vagrant/Parameters
```

Modify your Parameters files upon your wishes and then run vagrant:

```bash
cd vagrant
vagrant up
```

When you access the machine via ssh, your project is seen as /var/www/vhosts/symfony:

```bash
vagrant ssh
cd /var/www/vhosts/symfony
```

## Configuration

This project is pre-configured to install an Ubuntu Trusty 64bits with PHP-FPM, Postgresql and Nginx. It also create a network interface with the IP 192.168.100.100.

To access app_dev.php from your local machine, you can add 192.168.100.1 as allowed IP.

To modify the Vagrant configuration and IP address just edit the Vagrant configuration:

    Vagrantfile


To ajust the Ansible parameters, database and some flavors, edit the playbook global variables:

    provisioning/group_vars/all

Enjoy!

** Note: ** Feel free to contribute to this project :-)
