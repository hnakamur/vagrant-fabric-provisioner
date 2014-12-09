# Vagrant Fabric Provisioner

This is a [Vagrant](http://www.vagrantup.com) plugin that adds an [Fabric](http://docs.fabfile.org/en/latest/)
provisioner to Vagrant, supporting to provision your virtual machines with fabric scripts.

## Installation

Run this command (or just type it on your vagrant environment):

```
vagrant plugin install vagrant-fabric-provisioner
```

## Usage

Place your fabfile next in the same directory as your Vagrant file.

An example fabfile.py

```
from fabric.api import run, task

@task(default=True)
def show_hostname():
    run('hostname')
```

Add a config for fabric provisioner in your Vagrant file.

This is an example using dynamic port.

```
Vagrant.configure("2") do |config|
  config.vm.provision :fabric do |s|
    s.uses_dynamic_port = true
    s.args = ['-D', '--colorize-errors', '-H', '127.0.0.1', 'show_hostname']
  end
end
```

This is an example not using dynamic port.

```
Vagrant.configure("2") do |config|
  config.vm.network :private_network, ip: "192.168.33.28"

  config.vm.provision :fabric do |s|
    s.uses_dynamic_port = false
    s.args = ['-D', '--colorize-errors', '-H', '192.168.33.28', 'show_hostname']
  end
end
```

Once configured, all you have to do is just:

```
vagrant up
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
