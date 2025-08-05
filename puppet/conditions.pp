#onlyif --> it is used to define conditions

node default{
  exec{'Conditions':
    command => '/bin/echo "Apache is installed" > /tmp/software.txt',
    onlyif  => '/bin/which apache2',
  }
}