$ar_databases = ['activerecord_unittest', 'activerecord_unittest2']
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

# Pick a Ruby version modern enough, that works in the currently supported Rails
# versions, and for which RVM provides binaries.
# $ruby_version = '2.1.2' - hard coded

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- SQLite -------------------------------------------------------------------

package { ['sqlite3', 'libsqlite3-dev']:
  ensure => installed;
}

# --- MySQL --------------------------------------------------------------------

class install_mysql {
  class { 'mysql': }

  class { 'mysql::server':
    config_hash => { 'root_password' => '' }
  }

  database { $ar_databases:
    ensure  => present,
    charset => 'utf8',
    require => Class['mysql::server']
  }

  database_user { 'rails@localhost':
    ensure  => present,
    require => Class['mysql::server']
  }

  database_grant { ['rails@localhost/activerecord_unittest', 'rails@localhost/activerecord_unittest2', 'rails@localhost/inexistent_activerecord_unittest']:
    privileges => ['all'],
    require    => Database_user['rails@localhost']
  }

  package { 'libmysqlclient15-dev':
    ensure => installed
  }
}
class { 'install_mysql': }

# --- Packages -----------------------------------------------------------------

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

# ExecJS runtime.
package { 'nodejs':
  ensure => installed
}

# RVM requirements
package { ['libgdbm-dev', 'libncurses5-dev', 'automake', 'libtool', 'bison', 'libffi-dev']:
	ensure => installed
}

# --- Ruby ---------------------------------------------------------------------

exec { 'curl_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm/scripts/rvm",
  require => Package['curl']
}


exec { 'install_ruby':
  # We run the rvm executable directly because the shell function assumes an
  # interactive environment, in particular to display messages or ask questions.
  # The rvm executable is more suitable for automated installs.
  #
  # use a ruby patch level known to have a binary
  command => "${as_vagrant} 'rvm install ruby-2.1.2 --binary --autolibs=enabled'",
  creates => "${home}/.rvm/bin/ruby",
  require => Exec['curl_rvm']
}

exec { 'update_gem':
  command => "${as_vagrant} 'gem update --system'",
  require => Exec['install_ruby']
}

# --- Rails ---------------------------------------------------------------------

exec { 'install_rails':
  #install rails
  command => "${as_vagrant} 'gem install --no-rdoc --no-ri rails'",
  require => Exec['update_gem']
}

exec { 'create_project':
  #create default project
  command => "${as_vagrant} 'rails new /vagrant/myapp'",
  require => Exec['install_rails']
}

exec { 'project_dir':
  #enter the new app dir
  command => "${as_vagrant} 'cd /vagrant/myapp'",
  require => Exec['create_project']
}

exec { 'start_rails':
  #starts the rails server
  command => "${as_vagrant} 'rails server'",
  require => Exec['project_dir']
}

# --- Locale -------------------------------------------------------------------

# Needed for docs generation.
exec { 'update-locale':
  command => 'update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8'
}
