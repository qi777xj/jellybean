# jellybean
My overlay

**How to use**

Install layman
```
sudo emerge -a layman
```

Add below line to /etc/portage/repos.conf/layman.conf
```
[jellybean]
priority = 50
location = /var/lib/layman/
sync-type = git
sync-uri = https://github.com/qi777xj/jellybean.git
auto-sync = Yes
```

And sync it.
```
emerge --sync
```
