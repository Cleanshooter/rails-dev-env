Ruby on Rails Development Environment
=====================================

This is a rails development environment for people new to Rails.  This environment was built for the [Web Application Arcitectures](https://class.coursera.org/webapplications-002) course out on Coursera.  This will get you up to the end of Module 2 Lecture 2.  So you will have a complete development environment with out having to do any work in Terminal (in your virtual machine) at all.  This is tested and works on Windows 7.

## Requirments

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## Instructions

* Create a directory for your project
* Put the Vagrantfile and puppet folder in your new directory

Open up CMD.exe go to your new directory
	cd $dir-path
    vagrant up

After about 400-500 seconds your shoudl be able to open [your new site](http://localhost:3000)

This was modeled and modifed from the [rails dev box](https://github.com/rails/rails-dev-box) project.

## What's In The Box

* RVM

* Ruby 2.1.2 (binary RVM install)

* Rails (with default myapp project created)

* Bundler

* SQLite3, MySQL

* System dependencies for nokogiri, sqlite3, mysql and mysql2

* Node.js for the asset pipeline

## Recommended Workflow

Since Vagrant syncs every file you change in the directory all you need to do is modify the files locally on your machine and they will automatically sync to your virtual server.  

This will create the default *myapp* rails project mentioned in the **Module 2 Lecture 2** video.  In the future you will need to ssh into the machine to create news ones on your own.  

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.

## Faster Rails test suites

The default mechanism for sharing folders is convenient and works out the box in
all Vagrant versions, but there are a couple of alternatives that are more
performant.

### rsync

Vagrant 1.5 implements a [sharing mechanism based on rsync](https://www.vagrantup.com/blog/feature-preview-vagrant-1-5-rsync.html)
that dramatically improves read/write because files are actually stored in the
guest. Just throw

    config.vm.synced_folder '.', '/vagrant', type: 'rsync'

to the _Vagrantfile_ and either rsync manually with

    vagrant rsync

or run

    vagrant rsync-auto

for automatic syncs. See the post linked above for details.

### NFS

If you're using Mac OS X or Linux you can increase the speed of Rails test suites with Vagrant's NFS synced folders.

With a NFS server installed (already installed on Mac OS X), add the following to the Vagrantfile:

    config.vm.synced_folder '.', '/vagrant', type: 'nfs'
    config.vm.network 'private_network', ip: '192.168.50.4' # ensure this is available

Then

    host $ vagrant up

Please check the Vagrant documentation on [NFS synced folders](http://docs.vagrantup.com/v2/synced-folders/nfs.html) for more information.

## License

Released under the MIT License, Copyright (c) 2012–<i>ω</i> Xavier Noria.
