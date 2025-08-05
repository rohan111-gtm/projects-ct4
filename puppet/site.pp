node default{
  package{'nginx':
    ensure => installed,
  }
  file{'/tmp/status.txt':
    content => "nginx installed",
    mode    => '0644',
  }
}

---
 node 'ec2-3-80-48-105.compute-1.amazonaws.com' {}

 cd /etc/puppetlabs/code/environments/production/manifests
