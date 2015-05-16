# == Class: multipathd
#
# This class sets up multipathd and will compile any built configurations.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class multipathd {
  concat_build { 'multipath_conf':
    order   => '*.conf',
    target  => '/etc/multipath.conf',
    quiet   => true,
    require => Package['device-mapper-multipath']
  }

  $multipath_frags = fragmentdir('multipath_conf')
  concat_build { 'multipath':
    parent_build => 'multipath_conf',
    order        => ['begin', '*.multipath', 'end'],
    target       => "${multipath_frags}/multipath.conf",
    quiet        => true
  }

  concat_build { 'multipath_devices':
    parent_build => 'multipath_conf',
    order        => ['begin', '*.device', 'end'],
    target       => "${multipath_frags}/devices.conf",
    quiet        => true
  }

  concat_build { 'multipath_blacklist_exception':
    parent_build => 'multipath_conf',
    order        => ['begin', '*.exception', 'end'],
    target       => "${multipath_frags}/blacklist_exceptions.conf",
    quiet        => true
  }

  concat_build { 'multipath_blacklist':
    parent_build => 'multipath_conf',
    order        => ['begin', '*.blacklist', 'end'],
    target       => "${multipath_frags}/blacklist.conf",
    quiet        => true
  }
  exec { 'make_dev_mpath':
    command     => '/sbin/multipath -v1',
    refreshonly => true,
    subscribe   => File['/etc/multipath.conf'],
    notify      => Service['multipathd'],
    require     => Package['device-mapper-multipath']
  }

  file { '/etc/multipath.conf':
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    require   => Package['device-mapper-multipath'],
    subscribe => Concat_build['multipath_conf'],
    audit     => content
  }

  package { 'device-mapper-multipath': ensure => 'latest' }

  service { 'multipathd':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['device-mapper-multipath']
  }
}
