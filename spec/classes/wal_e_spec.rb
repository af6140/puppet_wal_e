require 'spec_helper'

describe 'wal_e' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      describe "profiles class without any parameters on #{os}" do
        let(:params) {
          {
            :storage_type => 'aws',
            :storage_configs => {
              'aws_access_key' => 'dummy',
              'aws_secret_key' => 'dummy',
              's3_prefix' => 's3://dummy'
            }
          }
        }
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e /etc/wal-e/env /etc/wal-e/env/AWS_ACCESS_KEY_ID /etc/wal-e/env/AWS_SECRET_ACCESS_KEY /etc/wal-e/env/WALE_S3_PREFIX).each do | env_file|
          it { should contain_file(env_file)}
        end
      end
    end
  end
end
