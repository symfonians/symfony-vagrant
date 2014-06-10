Vagrant and Ansible receipe for Symfony development
===================================================

Quick start
-----------

Clone this repository inside your project, under a vagrant directory:

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



** Note: ** Feel free to contribute to this project :-)
