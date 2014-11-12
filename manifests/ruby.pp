class scout::ruby {
    
  package { 'ruby':
    ensure  => present,
  }
  package { 'rubygems':
    ensure  => present,
  }
}
