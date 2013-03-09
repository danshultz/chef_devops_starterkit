Chef DevOps Starter Kit
=======================

This project is put together to be a devops starter kit for building a new
Chef project. Provided is a predefined folder structure for storing your 
recipes and vagrant files to help validate and test your environement
scripts.

Getting Started
---------------

1. Fork this repository and clone it locally
1. Install Ruby 1.9.3
1. Install [VirtualBox][virtualbox]
1. Run ```gem install bundler && bundle install```
1. Commit your ```Gemfile.lock```

### Pieces and Parts

* [VirtualBox][virtualbox] is a VM product used by vagrant to create and launch virutal servers
* [Vagrant][vagrant] is used to define and spin up vms
* [VeeWee][veewee] is used to easity build vagrant base boxes
* [Chef][chef] is the automation platform used to script your server setups
* [Knife][knife] is the cli tool used to manage your cloud instances and your chef server
* [Chef Server][chefserver] is used to store your recipes, provision your servers and keep track of your servers

Uploading Data to Chef Server
-----------------------------

* upload all cookbooks ```knife cookbook upload -a```
* upload all roles ```knife role from file chef/roles/*.rb```
* upload all data bags ```knife data bag create users && knife data bag from file users chef/data_bags/users/*.json```


Managing Cookbooks
------------------

All cookbooks need to be uploaded to the chef server in order to use them for deploys

After adding/creating/modifying an existing cookbook/recipe.

* the changes should be committed to github
* cookbook should be pushed to chef server ```knife cookbook upload COOKBOOKS```


Managing Roles
--------------

All roles need to be uploaded to the chef server and any modifications need to be pushed also.

1. Edit or create a role in the ```chef/roles``` folder
1. Commit changes to github
1. Upload role to the server ```knife role from file chef/roles/web.rb```

more info on managing roles can be found [here](http://wiki.opscode.com/display/chef/Managing+Roles+With+Knife)

Managing Data Bags
------------------

All data bags need to be pushed to the ops code server. 

1. Edit or create a data bag in ```chef/data_bags```
1. Commit changes to github
1. If creating a new data bag it needs to be added to the chef server with ```knife data bag create BAG```, eg ```knife data bag create users```
1. Upload the data bag to the server using ```knife data bag from file BAG_NAME /path/to/file```, et ```knife data bag from file users chef/data_bags/users/rails.json```

more info on managing data bags can be found [here](http://wiki.opscode.com/display/chef/Managing+Data+Bags+With+Knife)

Installing Cookbooks from Git
-----------------------------

Most recipes are installed from git using the knife-github-cookbook gem. Usage instructions for this gem can be found on the 
[knife-github-cookbook github page](https://github.com/websterclay/knife-github-cookbooks#usage)

Basic usage is ```knife cookbook github install gituser/repo```, eg to install the opscode apt cookbook, ```knife cookbook github install opscode-cookbooks/apt```

Spinning up new Vagrant local instances
---------------------------------------

### Basebox Definitions

Create your basebox definition. 

Remember - your basebox should be bare bones to get up and running.

1. Run ```vagrant basebox templates``` to view all templates
1. Run ```vagrant basebox define 'BaseServer' 'ubuntu-12.04.1-server-amd64'``` to create your definition

Your basebox defintions will be created in ```defintions/BaseServer```

You may need to edit the ```defintions/BaseServer/postinstall.sh``` file to customize it a bit.
For instance, with this ubuntu definition, packages for libxml and readline need added or 
ruby should be pulled from a package instead of being build from source.

After reviewing and verifying your definition files, make sure to commit them.

### Creating a basebox

1. Run ```vagrant basebox build BaseServer```

Vagrant should download your initial iso file, launch a VirtualBox VM and set it up. 

After the basebox is build, the VM should stay in the window. 

1. Verify your basebox by running ```vagrant basebox validate BaseServer```
1. Export your box ```vagrant basebox export BaseServer```
1. Move the box to the ```boxes/``` folder - Run ```mv BaseBox.box ./boxes/```

These baseboxes are large and typically should not be checked in. You can upload these boxes to 
s3 or other network storage for future use.

### Create Instances with Vagrant

After you have created a basebox, you can move forward with setting up vagrant instances.

1. Run ```mkdir instances/cluster && cd instances/cluster```
1. Run ```vagrant init TestServer  ../../boxes/BaseServer.box```

This will create a Vagrantfile which is used to define your server(s) managed by this
vagrant definition. Open the file and have a look around

Run ```vagrant up``` to initially spin up your vagrant instance.

After your server has come up, you can run ```vagrant ssh``` to access your server and have a
look around

### Setting Up Your Vagrant Config

WIP



[virtualbox]: https://www.virtualbox.org/ "VirtualBox"
[vagrant]: http://www.vagrantup.com/ "Vagrant"
[veewee]: https://github.com/jedi4ever/veewee "VeeWee"
[chef]: http://www.opscode.com/chef/ "Chef"
[knife]: http://docs.opscode.com/knife.html "Knife"
[chefserver]: http://docs.opscode.com/chef_overview_server.html "Chef Server"
