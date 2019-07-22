# How to create a Vagrant base box with Consul installed as Systemd service and test it with KitchenCI.

![alt diagram](https://www.lucidchart.com/publicSegments/view/c91dcce6-400d-4e55-ac5b-95b9285c8486/image.png)

## Purpose

This repository's sole purpose is to demonstrate how to built a Vagrant box with virtual box provider using Packer which provides Consul, and then test it with KitchenCI.

## Technologies in use :

- Packer
- Vagrant
- VirtualBox
- KitchenCI
- Inspec

## How to install the needed technologies :

- [How to install Packer](https://www.packer.io/intro/getting-started/install.html)
- [How to install Vagrant](https://www.vagrantup.com/docs/installation/)
- [How to install VirtualBox](https://www.virtualbox.org/manual/ch02.html)

# How to use :

- Clone this git repository using `git clone https://github.com/martinhristov90/packer_consul.git`
- Switch into the directory of the project using : `cd packer-consul`
- Let Packer build the Vagrant box for you using : `packer build template.json`
- You should now have Vagrant box with Consul installed as Systemd service. 
- Use command `vagrant box add ubuntuConsul-vbox.box --name ubuntuConsul` to add the box to Vagrant.
- List available boxes with `vagrant box list`, the imported box should be listed.
- In order to boot the box with Vagrant, Vagrantfile needs to be generated. Use `vagrant init -m ubuntuConsul`, to generate simple Vagrantfile
- Type `vagrant up`.

# How to setup KitchenCI (MacOS Mojave).

- For using [KitchenCI](https://kitchen.ci/), ruby environment needs to be set up first.
- Run `brew install ruby`
- After previous command finish, run `gem install rbenv`, this would give you ability to choose particular version of Ruby. This is a prerequisite.
- Next, [Bundler](https://bundler.io) needs to be installed, run `gem install bundler`, this would provide the dependencies that KitchenCI needs. It is going to install the Gems defined in the `Gemfile`
- Run the following two commands, to setup Ruby environment for the local directory.
    ```bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    ```
- Reload your BASH interpreter or apply the changes to the profile :
    ```shell
    source ~/.bash_profile 
    ```
- Verify rbenv is installed properly with :
    ```shell
    type rbenv   # → "rbenv is a function"
    ```
- To install the particular version that we need, run the following command in the project directory:
    ```shell
    rbenv install 2.5.3
    ```
- Set local version to be used with command :
    ```shell
    rbenv local 2.5.3
    ```
- Previous step is going to create a file named .ruby-version, with the following content `2.5.3`
- Install the needed Gems for KitchenCI using Bundle with command :
    ```shell
    bundle install
    ```
- Run Kitchen in the context of Bundle with the following command : 
    ```shell
    bundle exec kitchen list
    ```
- Build the testing environment with:
    ```shell
    bundle exec kitchen converge
    ```
- Test it : 
    ```shell
    bundle exec kitchen verify
    ```
- If Consul is installed, you should get an output like this :
    ```shell
    Profile: Checking Consul installation (consul)
    Version: 1.0.0
    Target:  ssh://vagrant@127.0.0.1:2222

      ✔  consul_install: consul_install_check
         ✔  Command: `consul` should exist
         ✔  Command: `consul-template` should exist
         ✔  Command: `envconsul` should exist
      ✔  consul_user: consul_user_check
         ✔  Group consul should exist
         ✔  User consul should exist
         ✔  User consul shell should eq "/bin/false"
         ✔  User consul group should eq "consul"
         ✔  User consul home should eq "/etc/consul.d"
      ✔  consul_directory: consul_directory_check
         ✔  Directory /etc/consul.d/ should exist
         ✔  Directory /etc/consul.d/ owner should eq "consul"
         ✔  Directory /etc/consul.d/ mode should cmp == "0755"
         ✔  File /etc/consul.d/consul.hcl should exist
         ✔  File /etc/consul.d/consul.hcl owner should eq "consul"
         ✔  File /etc/consul.d/consul.hcl mode should cmp == "0640"
         ✔  File /etc/consul.d/consul.hcl size should eq 0
      ✔  consul_systemd: consul_check_systemd
         ✔  Service consul should be installed
         ✔  Service consul should not be enabled
         ✔  Service consul should not be running
    Profile Summary: 4 successful controls, 0 control failures, 0 controls skipped
    Test Summary: 18 successful, 0 failures, 0 skipped
    ```
- To destroy the testing environment use :
    ```shell
    bundle exec kitchen destroy
    ```
- (optional) To upload the box to Vagrant Cloud use :
    ```
    vagrant cloud publish (options)
    ```

