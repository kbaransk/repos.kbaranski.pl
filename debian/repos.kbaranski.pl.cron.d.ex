#
# Regular cron jobs for the repos.kbaranski.pl package
#
0 4	* * *	root	[ -x /usr/bin/repos.kbaranski.pl_maintenance ] && /usr/bin/repos.kbaranski.pl_maintenance
