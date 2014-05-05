
# SSHConfig
# Reads a user's ssh config file to
#   - if specified, move the user's sshconfig file in place
#   - create the ssh key
#   - distribute it to all the servers in the user's sshconfig file

class sshconfig {

  $home_directory = "/Users/${::boxen_user}"
  $script_copy_id = "/usr/local/bin/ssh-copy-id"
  $tmpscript_distribute = "/tmp/distribute_ssh_keys"
  $tarball = 'puppet:///modules/sshconfig/sshpass-1.05.tar.gz'
  $sshpass_archive = '/tmp/sshpass-1.05.tar.gz'


#########################
# INSTALL SSHPASS
#########################
  file { $sshpass_archive:
  	source => $tarball,
  	mode   => '755',
  }

  exec { 'extract_sshpass':
  	command => "/usr/bin/tar -xzf ${sshpass_archive} -C /tmp",
  	require => File[$sshpass_archive],
  }

  exec { 'configure_sshpass':
    command => 'cd /tmp/sshpass-1.05 && ./configure',
    require => Exec['extract_sshpass'],
  }

  exec { 'install_sshpass':
    command => 'cd /tmp/sshpass-1.05 && make install',
    require => Exec['configure_sshpass'],
    user    => 'root',
    before  => Exec['distribute'],
  }

#########################
# SET UP SSH DIRECTORY
#########################

  file { "${home_directory}/.ssh":
    ensure => 'directory'
  }

  # install the user's ssh config file
  file { "${home_directory}/.ssh/config":
    source => "puppet:///modules/people/${::github_login}/ssh_config",
    require => File["${home_directory}/.ssh"],
  }

  exec { 'create_key':
    command => "ssh-keygen -t rsa -C '${::boxen_user}@${fqdn}' -f ${home_directory}/.ssh/id_rsa ",
    unless  => "test -e ${home_directory}/.ssh/id_rsa",
  }

#########################
# SET UP SSH SCRIPTS
#########################

  file { $script_copy_id:
  	owner    => 'root',
  	group    => 'wheel',
  	mode     => '755',
  	source   => 'puppet:///modules/sshconfig/ssh-copy-id',
  }

  file { $tmpscript_distribute:
  	source   => 'puppet:///modules/sshconfig/distribute_ssh_keys',
  	mode     => '755',
  }

#########################
# DISTRIBUTE KEYS
#########################

  exec { 'distribute':
    command => "$tmpscript_distribute /tmp/mp",
    require => File[$tmpscript_distribute] , 
  }

  exec { 'remove_pwd_file':
    command => "rm -f /tmp/mp",
    require => Exec['distribute'] , 
  }


}
