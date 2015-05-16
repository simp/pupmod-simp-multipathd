# == Define: multipathd::blacklist_wwid
#
# Blacklist a wwid per the 'blacklist section' of multipath.conf(5)
#
# == Parameters
#
# [*name*]
#   The wwid you wish to blacklist
# [*wwid*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define multipathd::blacklist_wwid (
  $wwid
) {
  concat_fragment { "multipath_blacklist+$name.wwid.blacklist":
    content => "wwid $wwid\n"
  }
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
}
