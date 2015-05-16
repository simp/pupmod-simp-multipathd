# == Define: multipathd::blacklist_devnode
#
# Blacklist a devnode per the 'blacklist section' of multipath.conf(5)
#
# Put your pattern in single (') quotes.
#
# == Parameters
#
# [*pattern*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define multipathd::blacklist_devnode (
  $pattern
) {
  concat_fragment { "multipath_blacklist+$name.devnode.blacklist":
    content => "devnode \"$pattern\"\n"
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
