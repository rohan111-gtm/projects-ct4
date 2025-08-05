node default{
  $packages= ['apache2','mysql-server']
  
  package{$packages:
    ensure => installed,
  }
}