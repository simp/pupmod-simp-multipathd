require 'spec_helper'

describe 'multipathd::multipath' do

  let(:title) {'test_multipath'}
  let(:params) {{ :wwid => 'lkdfsgjkhsdfgjkhdsfgfd' }}

  it { should create_file('/test_multipath').with_ensure('directory') }
end
