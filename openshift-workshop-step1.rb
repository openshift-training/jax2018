#!/usr/bin/env ruby
require 'rubygems'
require 'hetzner-bootstrap'

# get your API login from Hetzner's customer panel at: https://robot.your-server.de/
# assign env variables:
#   HBC_ROBOT_USER
#   HBC_ROBOT_PASSWORD
#
# rbenv-tip: checkout rbenv-vars, it's awesome!
#            https://github.com/sstephenson/rbenv-vars/
otmaster = Hetzner::Bootstrap.new(api: Hetzner::API.new(
  ENV['HBC_ROBOT_USER'],
  ENV['HBC_ROBOT_PASSWORD']
))

otnode1 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
  ENV['HBC_ROBOT_USER'],
  ENV['HBC_ROBOT_PASSWORD']
))

otnode2 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
  ENV['HBC_ROBOT_USER'],
  ENV['HBC_ROBOT_PASSWORD']
))

otnode3 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
  ENV['HBC_ROBOT_USER'],
  ENV['HBC_ROBOT_PASSWORD']
))

# osnode4 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
#   ENV['HBC_ROBOT_USER'],
#   ENV['HBC_ROBOT_PASSWORD']
# ))

# osnode5 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
#   ENV['HBC_ROBOT_USER'],
#   ENV['HBC_ROBOT_PASSWORD']
# ))

# osnode6 = Hetzner::Bootstrap.new(api: Hetzner::API.new(
#   ENV['HBC_ROBOT_USER'],
#   ENV['HBC_ROBOT_PASSWORD']
# ))

template = <<EOT
DRIVE1 /dev/sda
DRIVE2 /dev/sdb
## ===============
##  SOFTWARE RAID:
## ===============
## activate software RAID?  < 0 | 1 >
SWRAID 1 
## Choose the level for the software RAID < 0 | 1 >
SWRAIDLEVEL 0
## which bootloader should be used?  < lilo | grub >
BOOTLOADER grub
HOSTNAME <%= hostname %>
## PART  <mountpoint/lvm>  <filesystem/VG>  <size in MB>
##
## * <mountpoint/lvm> mountpoint for this filesystem  *OR*  keyword 'lvm'
##                    to use this PART as volume group (VG) for LVM
## * <filesystem/VG>  can be ext2, ext3, reiserfs, xfs, swap  *OR*  name
##                    of the LVM volume group (VG), if this PART is a VG
## * <size>           you can use the keyword 'all' to assign all the
##                    remaining space of the drive to the *last* partition.
##                    you can use M/G/T for unit specification in MIB/GIB/TIB
##
## notes:
##   - extended partitions are created automatically
##   - '/boot' cannot be on a xfs filesystem!
##   - '/boot' cannot be on LVM!
##   - when using software RAID 0, you need a '/boot' partition
PART /boot ext4    2G
PART lvm   vg0    all
#LV <VG> <name> <mount> <filesystem> <size>
LV vg0 root /    ext4  1024G
LV vg0 swap swap swap     5G
LV vg0 home /home xfs    10G
## ========================
##  OPERATING SYSTEM IMAGE:
## ========================
## full path to the operating system image
##   supported image sources:  local dir,  ftp,  http,  nfs
##   supported image types:  tar,  tar.gz,  tar.bz,  tar.bz2,  tgz,  tbz
## examples:
#
# local: /path/to/image/filename.tar.gz
# ftp:   ftp://<user>:<password>@hostname/path/to/image/filename.tar.bz2
# http:  http://<user>:<password>@hostname/path/to/image/filename.tbz
# https: https://<user>:<password>@hostname/path/to/image/filename.tbz
# nfs:   hostname:/path/to/image/filename.tgz

# Default images provided by hetzner as of October 2014:
# Archlinux-2014-64-minmal.tar.gz
# CentOS-65-32-minimal.tar.gz
# CentOS-65-64-cpanel.tar.gz
# CentOS-65-64-minimal.tar.gz
# CentOS-70-64-minimal.tar.gz
# Debian-76-wheezy-32-minimal.tar.gz
# Debian-76-wheezy-64-LAMP.tar.gz
# Debian-76-wheezy-64-minimal.tar.gz
# openSUSE-131-64-minimal.tar.gz
# Ubuntu-1204-precise-64-minimal.tar.gz
# Ubuntu-1404-trusty-64-minimal.tar.gz
IMAGE /root/.oldroot/nfs/install/../images/CentOS-74-64-minimal.tar.gz
EOT

storage_node_template = <<EOT
DRIVE1 /dev/sda
# DRIVE2 /dev/sdb
## ===============
##  SOFTWARE RAID:
## ===============
## activate software RAID?  < 0 | 1 >
SWRAID 0 
## Choose the level for the software RAID < 0 | 1 >
# SWRAIDLEVEL 0
## which bootloader should be used?  < lilo | grub >
BOOTLOADER grub
HOSTNAME <%= hostname %>
## PART  <mountpoint/lvm>  <filesystem/VG>  <size in MB>
##
## * <mountpoint/lvm> mountpoint for this filesystem  *OR*  keyword 'lvm'
##                    to use this PART as volume group (VG) for LVM
## * <filesystem/VG>  can be ext2, ext3, reiserfs, xfs, swap  *OR*  name
##                    of the LVM volume group (VG), if this PART is a VG
## * <size>           you can use the keyword 'all' to assign all the
##                    remaining space of the drive to the *last* partition.
##                    you can use M/G/T for unit specification in MIB/GIB/TIB
##
## notes:
##   - extended partitions are created automatically
##   - '/boot' cannot be on a xfs filesystem!
##   - '/boot' cannot be on LVM!
##   - when using software RAID 0, you need a '/boot' partition
PART /boot ext4    2G
PART lvm   vg0    all
#LV <VG> <name> <mount> <filesystem> <size>
LV vg0 root /    ext4  1024G
LV vg0 swap swap swap     5G
LV vg0 home /home xfs    10G
## ========================
##  OPERATING SYSTEM IMAGE:
## ========================
## full path to the operating system image
##   supported image sources:  local dir,  ftp,  http,  nfs
##   supported image types:  tar,  tar.gz,  tar.bz,  tar.bz2,  tgz,  tbz
## examples:
#
# local: /path/to/image/filename.tar.gz
# ftp:   ftp://<user>:<password>@hostname/path/to/image/filename.tar.bz2
# http:  http://<user>:<password>@hostname/path/to/image/filename.tbz
# https: https://<user>:<password>@hostname/path/to/image/filename.tbz
# nfs:   hostname:/path/to/image/filename.tgz
# Default images provided by hetzner as of October 2014:
# Archlinux-2014-64-minmal.tar.gz
# CentOS-65-32-minimal.tar.gz
# CentOS-65-64-cpanel.tar.gz
# CentOS-65-64-minimal.tar.gz
# CentOS-70-64-minimal.tar.gz
# Debian-76-wheezy-32-minimal.tar.gz
# Debian-76-wheezy-64-LAMP.tar.gz
# Debian-76-wheezy-64-minimal.tar.gz
# openSUSE-131-64-minimal.tar.gz
# Ubuntu-1204-precise-64-minimal.tar.gz
# Ubuntu-1404-trusty-64-minimal.tar.gz
IMAGE /root/.oldroot/nfs/install/../images/CentOS-74-64-minimal.tar.gz
EOT

# the post_install hook is a great place to setup further
# software/system provisioning
#
post_install = <<EOT
  yum install python-rhsm-certificates yum-utils pyOpenSSL python-cryptography python-lxml NetworkManager -y
EOT

# duplicate entry for each system
otmaster << { ip: '136.243.53.206',
              template: template,        # string will be parsed by erubis
              hostname: 'otmaster',             # sets hostname
              public_keys: '~/.ssh/id_rsa.pub', # will be copied to your system
              post_install_remote: post_install }      # will be executed *locally* at the end

otnode1 << { ip: '144.76.98.107',
              template: storage_node_template,               # string will be parsed by erubis
              hostname: 'otnode1',              # sets hostname
              public_keys: '~/.ssh/id_rsa.pub', # will be copied to your system
              post_install_remote: post_install }      # will be executed *locally* at the end

otnode2 << { ip: '144.76.104.83',
              template: storage_node_template,  # string will be parsed by erubis
              hostname: 'otnode2',              # sets hostname
              public_keys: '~/.ssh/id_rsa.pub', # will be copied to your system
              post_install_remote: post_install }      # will be executed *locally* at the end

otnode3 << { ip: '5.9.29.135',
              template: storage_node_template,               # string will be parsed by erubis
              hostname: 'otnode3',              # sets hostname
              public_keys: '~/.ssh/id_rsa.pub', # will be copied to your system
              post_install_remote: post_install }      # will be executed *locally* at the end


t1 = Thread.new do
  otmaster.bootstrap!
end

t2 = Thread.new do
  otnode1.bootstrap!
end

t3 = Thread.new do
  otnode2.bootstrap!
end

t4 = Thread.new do
  otnode3.bootstrap!
end


t1.join
t2.join
t3.join
t4.join
