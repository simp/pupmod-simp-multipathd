# == Class: multipathd::defaults
#
# Set up the multipath.conf defaults per the 'defaults section' of
# multipath.conf(5)
#
# == Parameters
#
# [*udev_dir*]
# [*polling_interval*]
# [*selector*]
# [*path_grouping_policy*]
# [*getuid_callout*]
# [*prio_callout*]
# [*path_checker*]
# [*rr_min_io*]
# [*max_fds*]
# [*rr_weight*]
# [*failback*]
# [*no_path_retry*]
# [*user_friendly_names*]
# [*bindings_file*]
#
class multipathd::defaults (
  $udev_dir = '/dev',
  $polling_interval = '10',
  $selector = 'round-robin 0',
  $path_grouping_policy = 'multibus',
  $getuid_callout = '/sbin/scsi_id -g -u -s /block/%n',
  $prio_callout = '/bin/true',
  $path_checker = 'readsector0',
  $rr_min_io = '100',
  $max_fds = '8192',
  $rr_weight = 'priorities',
  $failback = 'immediate',
  $no_path_retry = 'nil',
  $user_friendly_names = 'no',
  $bindings_file = 'nil'
) {
  concat_fragment { 'multipath_conf+defaults.conf':
    content => template('multipathd/defaults.erb'),
  }

  validate_integer($rr_min_io)
  validate_integer($max_fds)
}
