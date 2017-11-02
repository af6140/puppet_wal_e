## Change Log

#### 0.4.0
- change purge_base_backup.sh to actually delete old base backup
- allow use command wrapper like sensu-wrapper to run the cron job so that it can do extra like reporting to sensu
- separate wal_e::cron as a individual class
- use assert_type other than validate
- change cron management to rmuller/cron other than default cron resource, this will generate cron def under /etc/cron.d

#### 0.3.0
- purge_base_backup.sh update, using template and retain days other than numbers of

#### 0.2.1
- merge PR from smithtrevor to fix purge command logic

#### 0.2.0
- do not use package to install gevent, when install wal-e 0.9.2 it pulls down latest gevent 1.1.2, which need to be compiled and is broken when /tmp is mouted as noexec
- use -b option to use wal_e::envdir as tmp dir when pip install with exec resource

#### 0.1.6
- enable purge old backup, maximum numbers to retain
- change cron commnad to purge backup if enabled

#### 0.1.5
- Remove --pool-size=8 from base backup options, it's seems only effective for wal-push.

#### 0.1.4
- Change python packages installed from native os repository: python-gevent. Pip installation has issue with /tmp mounted with **noexec** flag. **python-boto** is not installed from os repository, since at least on Centos, it's dependency **python-six** does not meet version requirements of **gcloud**.
