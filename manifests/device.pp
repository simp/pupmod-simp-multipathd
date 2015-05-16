# == Define: multipathd::device
#
# Set up the multipath.conf defaults per the 'devices section' of
# multipath.conf(5)
#
# == Parameters
#
# [*vendor*]
# [*product*]
# [*path_grouping_policy*]
# [*getuid_callout*]
# [*prio_callout*]
# [*path_checker*]
# [*path_selector*]
# [*failback*]
# [*rr_min_io*]
# [*product_blacklist*]
# [*blacklist*]
#   Whether or not to blacklist this device instead of adding it.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define multipathd::device (
  $vendor,
  $product,
  $path_grouping_policy = 'nil',
  $getuid_callout = 'nil',
  $prio_callout = 'nil',
  $path_checker = 'nil',
  $path_selector = 'nil',
  $failback = 'nil',
  $rr_min_io = 'nil',
  $product_blacklist = 'nil',
  $blacklist = false
) {

  if $blacklist {
    if !defined(Concat_fragment['multipath_blacklist+begin']) {
      concat_fragment {'multipath_blacklist+begin':
        content => 'blacklist {
'
      }
    }
    if !defined(Concat_fragment['multipath_blacklist+end']) {
      concat_fragment {'multipath_blacklist+end':
        content => '
}'
      }
    }
    concat_fragment { "multipath_blacklist+$name.device.blacklist":
      content => "device {\nvendor \"$vendor\"\nproduct \"$product\"\n}\n"
    }
  }
  else {
    if !defined(Concat_fragment['multipath_devices+begin']) {
      concat_fragment { 'multipath_devices+begin':
        content => 'multipaths {
'
      }
    }
    if !defined(Concat_fragment['multipath_devices+end']) {
      concat_fragment { 'multipath_devices+end':
        content => '
}'
      }
    }
    concat_fragment { "multipath_devices+$name.device":
      content => template('multipathd/device.erb')
    }
  }

  validate_bool($blacklist)
}
