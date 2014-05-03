class sshconfig::sshpass {

  # homebrew::formula {
  # 	'sshpass':
  # 	  source => 'puppet:///modules/sshconfig/sshpass.rb' ;
  # } 

  # package {
  # 	'boxen/brews/sshpass': 
  # 	  ensure => '1.05' ;
  # }

  $tarball = 'puppet:///modules/sshconfig/sshpass-1.05.tar.gz'
  $deployed = '/tmp/sshpass-1.05.tar.gz'
  file { $deployed:
  	source => $tarball,
  	mode   => '755',
  }

  exec { 'extract':
  	command => "/usr/bin/tar -xzf ${deployed} -C /tmp",
  	require => File[$deployed],
  }

  exec { 'configure':
    command => 'cd /tmp/sshpass-1.05 && ./configure',
    require => Exec['extract'],
  }

  exec { 'make_install':
    command => 'cd /tmp/sshpass-1.05 && make install',
    require => Exec['configure'],
    user    => 'root',
  }
}