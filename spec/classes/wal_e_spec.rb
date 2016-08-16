require 'spec_helper'

describe 'wal_e' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      describe "wal_e class with default install method on #{os}" do
        let(:params) {
          {
            :storage_type => 'aws',
            :storage_configs => {
              'aws_access_key' => 'dummy',
              'aws_secret_key' => 'dummy',
              's3_prefix' => 's3://dummy',
              'aws_region' => 'us-east-1'
            }
          }
        }
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e.d /etc/wal-e.d/env /etc/wal-e.d/env/AWS_ACCESS_KEY_ID /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY /etc/wal-e.d/env/WALE_S3_PREFIX /etc/wal-e.d/env/AWS_REGION).each do | env_file|
          it { should contain_file(env_file)}
        end
      end

      describe "wal_e class install from source on #{os}" do
        let(:params) {
          {
            :storage_type => 'aws',
            :storage_configs => {
              'aws_access_key' => 'dummy',
              'aws_secret_key' => 'dummy',
              's3_prefix' => 's3://dummy',
              'aws_region' => 'us-east-1'
            },
            :install_method => 'source'
          }
        }
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e.d /etc/wal-e.d/env /etc/wal-e.d/env/AWS_ACCESS_KEY_ID /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY /etc/wal-e.d/env/WALE_S3_PREFIX).each do | env_file|
          it { should contain_file(env_file)}
        end

        it { should contain_exec('wal_e_install_src')}
        it { should contain_vcsrepo('/etc/wal-e.d/.src')}
      end

      describe "wal_e class install from source on #{os} with azure" do
        let(:params) {
          {
            :storage_type => 'azure',
            :storage_configs => {
              'wabs_prefix' => 'dummy',
              'wabs_account_name' => 'dummy',
              'wabs_access_key' => 'dummy'
            },
            :install_method => 'source'
          }
        }
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e.d /etc/wal-e.d/env /etc/wal-e.d/env/WALE_WABS_PREFIX /etc/wal-e.d/env/WABS_ACCOUNT_NAME /etc/wal-e.d/env/WABS_ACCESS_KEY ).each do | env_file|
          it { should contain_file(env_file)}
        end

        it { should contain_exec('wal_e_install_src')}
        it { should contain_vcsrepo('/etc/wal-e.d/.src')}
      end #describe

      describe "wal_e class install from source on #{os} with google" do
        let(:params) {
          {
            :storage_type => 'google',
            :storage_configs => {
              'gs_prefix' => 'dummy',
              'google_applcation_credentials' => '/etc/dummy',
            },
            :install_method => 'source'
          }
        }
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e.d /etc/wal-e.d/env /etc/wal-e.d/env/WALE_GS_PREFIX /etc/wal-e.d/env/GOOGLE_APPLCATION_CREDENTIALS).each do | env_file|
          it { should contain_file(env_file)}
        end

        it { should contain_exec('wal_e_install_src')}
        it { should contain_vcsrepo('/etc/wal-e.d/.src')}

        it { should contain_cron('wal_e_base_backup').with('ensure'=> 'absent')}

      end #describe


      describe "wal_e class install from source on #{os} with swift with cron" do
        let(:params) {
          {
            :storage_type => 'swift',
            :storage_configs => {
              'swift_prefix' => 'swift://dummy',
              'swift_authurl' => 'http://dummy',
              'swift_tenant' => 'org',
              'swift_user' => 'swift_user',
              'swift_password' => 'swift_pass'
            },
            :install_method => 'source',
            :base_backup_enabled => true,
          }
        }
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('wal_e')}
        it { should contain_class('wal_e::config')}
        it { should contain_class('wal_e::install')}
        %w(/etc/wal-e.d /etc/wal-e.d/env /etc/wal-e.d/env/WALE_SWIFT_PREFIX /etc/wal-e.d/env/SWIFT_AUTHURL /etc/wal-e.d/env/SWIFT_TENANT /etc/wal-e.d/env/SWIFT_USER).each do | env_file|
          it { should contain_file(env_file)}
        end

        it { should contain_exec('wal_e_install_src')}
        it { should contain_vcsrepo('/etc/wal-e.d/.src')}

        it { should contain_cron('wal_e_base_backup').with( 'ensure'=> 'present')}
      end #describe

    end
  end
end
