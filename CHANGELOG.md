## Change Log

#### 0.1.6
- enable purge old backup, maximum numbers to retain
- change cron commnad to purge backup if enabled

#### 0.1.5
- Remove --pool-size=8 from base backup options, it's seems only effective for wal-push.

#### 0.1.4
- Change python packages installed from native os repository: python-gevent. Pip installation has issue with /tmp mounted with **noexec** flag. **python-boto** is not installed from os repository, since at least on Centos, it's dependency **python-six** does not meet version requirements of **gcloud**.
