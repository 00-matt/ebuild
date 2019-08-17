# ebuild
> asymptotically's ebuild repository

### Installation

```bash
cat << EOF > /etc/portage/repos.conf/asymptotically.conf
[asymptotically]
location = /var/db/repos/asymptotically
sync-uri = https://github.com/00-matt/ebuild.git
sync-type = git
auto-sync = yes
EOF

emerge --sync
```