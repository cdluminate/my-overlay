cat >> /etc/portage/make.conf <<EOF
GENTOO_MIRRORS="https://mirrors.tuna.tsinghua.edu.cn/gentoo"
EOF

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
