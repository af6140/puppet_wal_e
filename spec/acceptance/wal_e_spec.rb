require 'spec_helper_acceptance'

describe 'wale' do
  it 'should install wal_e' do
      #need create user, since it's created in other class
      pp = <<-EOS
       package {'postgresql-server':
        ensure => 'present'
       } ->
       class {'wal_e':
         storage_type => 'aws',
         storage_configs => {
           'aws_access_key' => 'dummy',
           'aws_secret_key' => 'dummy',
           's3_prefix' => 's3://dummy',
           'aws_region' => 'us-east-1'
         }
       }
      EOS

      expect(apply_manifest(pp, :catch_failures => true, :debug => false).exit_code).to_not eq(1)
      expect(apply_manifest(pp, :catch_failures => true, :debug => false).exit_code).to eq(0)

  end
end
