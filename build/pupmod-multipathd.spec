Summary: Multipathd Puppet Module
Name: pupmod-multipathd
Version: 4.1.0
Release: 2
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: pupmod-concat >= 4.0.0
Requires: puppet >= 3.3.0
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0
Obsoletes: pupmod-multipathd-test

Prefix:"/etc/puppet/environments/simp/modules"

%description
This Puppet module provides the ability to configure multipathd.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/multipathd

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/multipathd
done

mkdir -p %{buildroot}/usr/share/simp/tests/modules/multipathd

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/multipathd

%files
%defattr(0640,root,puppet,0750)
/etc/puppet/environments/simp/modules/multipathd

%post
#!/bin/sh

if [ -d /etc/puppet/environments/simp/modules/multipathd/plugins ]; then
  /bin/mv /etc/puppet/environments/simp/modules/multipathd/plugins /etc/puppet/environments/simp/modules/multipathd/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-2
- Changed puppet-server requirement to puppet

* Thu Jun 26 2014 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-1
- Removed MD5 checksums for FIPS compatibility.

* Mon Mar 03 2014 Kendall Moore <kmoore@keywcorp.com> - 4.1.0-0
- Refactored manifests to pass all lint tests for hiera and puppet 3.
- Added rspec tests for test coverage.

* Mon Oct 07 2013 Kendall Moore <kmoore@keywcorp.com> - 2.0.0-7
- Updated all erb templates to properly scope variables.

* Fri Feb 01 2013 Maintenance
2.0.0-6
- Created a Cucumber test to install and configure multipathd and make sure the service is running.

* Wed Apr 11 2012 Maintenance
2.0.0-5
- Moved mit-tests to /usr/share/simp...
- Updated pp files to better meet Puppet's recommended style guide.

* Fri Mar 02 2012 Maintenance
2.0.0-4
- Improved test stubs.

* Mon Dec 26 2011 Maintenance
2.0.0-3
- Updated the spec file to not require a separate file list.

* Mon Oct 10 2011 Maintenance
2.0.0-2
- Updated to put quotes around everything that need it in a comparison
  statement so that puppet > 2.5 doesn't explode with an undef error.

* Fri Feb 11 2011 Maintenance
2.0.0-1
- Updated to use concat_build and concat_fragment types.

* Tue Jan 11 2011 Maintenance
2.0.0-0
- Refactored for SIMP-2.0.0-alpha release

* Tue Oct 26 2010 Maintenance - 1-1
- Converting all spec files to check for directories prior to copy.

* Fri May 21 2010 Maintenance
1.0-0
- Code refactor and doc update.
