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

emerge virtual/fortran
emerge =sci-libs/blas-reference-20161223
emerge =sci-libs/cblas-reference-20151113-r2
emerge =sci-libs/lapack-reference-3.7.0
