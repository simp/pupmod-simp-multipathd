require 'spec_helper'

describe 'multipathd' do

  it { should create_class('multipathd') }
  it { should contain_package('device-mapper-multipath').with_ensure('latest') }
  it { should create_file('/etc/multipath.conf') }
  it { should contain_service('multipathd').with_ensure('running') }
end
