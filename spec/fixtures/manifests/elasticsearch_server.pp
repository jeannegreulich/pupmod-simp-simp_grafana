include '::simp_elasticsearch'
include '::tcpwrappers'
include '::iptables'

pki::copy { '/etc/httpd/conf':
  source => '/etc/pki/simp-testing/pki',
  before => Class['simp_elasticsearch'],
}

::tcpwrappers::allow{ 'sshd':
  pattern => 'ALL',
}

::iptables::add_tcp_stateful_listen { 'allow_ssh':
  client_nets => ['10.255.0.0/16', '10.0.2.0/24'],
  dports      => ['22'],
}
