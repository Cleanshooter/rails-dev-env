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
```
	cd $dir-path
    vagrant up
```

After about 400-500 seconds your should be able to open [your new site](http://localhost:3000)

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

Some commands to know when using Vagrant:

Save and Stop the VM

```
	vagrant suspend
```

Start a suspended VM

```
	vagrant resume
```

Shutdown VM

```
	vagrant halt
```

Start the VM

```
	vagrant up
```

Delete the VM

```
	vagrant destroy
```

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.