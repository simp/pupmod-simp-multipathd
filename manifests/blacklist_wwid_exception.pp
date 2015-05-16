# == Define: multipathd::blacklist_wwid_exception
#
# Prevent the blacklisting of a wwid per the 'blacklist_exceptions section' of
# multipath.conf(5)
#
# == Parameters
#
# [*name*]
#   The wwid you wish to except from blacklisting.
# [*wwid*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define multipathd::blacklist_wwid_exception (
  $wwid
) {
  concat_fragment { "multipath_blacklist_exception+$name.wwid.exception":
    content => "wwid $wwid\n"
  }
  if !defined(Concat_fragment['multipath_blacklist_exception+begin']) {
    concat_fragment {'multipath_blacklist_exception+begin':
      content => 'blacklist_exceptions {
'
    }
  }
  if !defined(Concat_fragment['multipath_blacklist_exception+end']) {
    concat_fragment {'multipath_blacklist_exception+end':
      content => '
}'
    }
  }
}
