# used for a new container
emerge-webrsync
emerge vim
emerge layman

mkdir -p /etc/portage/repos.conf/
cat > /etc/portage/repos.conf/layman.conf <<EOF
[my]
priority = 100
location = /root/my
layman-type = git
auto-sync = No
EOF
