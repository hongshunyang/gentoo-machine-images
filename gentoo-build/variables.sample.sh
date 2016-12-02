
# export GB_ADD_STEPS=virtualbox
# export GB_ADD_STEPS="virtualbox vagrant"
# export GB_ADD_STEPS=gce
# export GB_ADD_STEPS=aws

## find your virtualbox editon
## TODO:gentoo.json guest_additions_path
export GB_VBOXGUESTADDITIONS_URL="http://download.virtualbox.org/virtualbox/5.1.10/VBoxGuestAdditions_5.1.10.iso"

### Stage3, portage snapshot
export GB_STAGE3=latest
###not support http if GB_STAGE3 is latest
export GB_STAGE3_MIRROR="ftp://ftp.gtlib.gatech.edu/pub/gentoo"

### Root devices
# used for disk partitioning and grub2 install destination
export GB_ROOTDEVICE=sda
export GB_ROOT=/mnt/gentoo

### Partitioning

#### automatic

# disk partitioning and mount

export GB_PARTITIONING=1

export GB_ROOT_FSTYPE=ext4

#### Manually

# Set this to 0 to disable automated partitioning. fstab are still autogenerated.
#  export GB_PARTITIONING=0

# This means /dev/${GB_ROOTDEVICE}2
#  export GB_ROOT_PARTITION=2
#  export GB_ROOT_FSTYPE=ext4

# these variables are optional.
#  export GB_BOOT_PARTITION=1
#  export GB_BOOT_FSTYPE=ext4


### Networking

# if omit, guessed by the active default route
#  export GB_IFACE=eth0
# by default generates DHCP configuration
#  export GB_NETWORK="[Network] Address=192.168.0.10/24 Gateway=192.168.0.1 Domains=corp DNS=8.8.8.8"


export GB_HOSTNAME=gentoo

### Portage

export GB_REMOVE_PORTAGE=1

### make.conf

#export GB_FEATURES=
#export GB_USE=
#export GB_CFLAGS="-O2 -pipe"

### Linux kernel

export GB_KERNEL_PACKAGE='>=sys-kernel/gentoo-sources-4.5.0'
## TODO:form local configs/kernel.config
export GB_KERNEL_CONFIG="https://raw.githubusercontent.com/hongshunyang/gentoo-machine-images/master/configs/kernel.config"

### Default user

export GB_USER_UID=999
# skip sudoers
# export GB_SKIP_SUDOERS=1


### Timezone

export GB_TIMEZONE=UTC
### distcc (optional)

# (not implemented)
# export GB_DISTCC_HOSTS=""
# export GB_DISTCC_MAKEOPTS=""

### grub

# export GB_GRUB_CONSOLE=1
# export GB_GRUB_NO_TIMEOUT=1

case "_${PACKER_BUILDER_TYPE}" in
_virtualbox*)
  export GB_ADD_STEPS="vagrant virtualbox ${GB_ADD_STEPS}"
  export GB_USER_PASSWORD=vagrant
  export GB_USER_LOGIN=vagrant
  export GB_GRUB_NO_TIMEOUT=1
  ;;
_amazon*)
  export GB_ADD_STEPS="cloud-init aws ${GB_ADD_STEPS}"
  export GB_USER_LOGIN=
  export GB_SKIP_SUDOERS=1
  export GB_ROOTDEVICE=xvda
  export GB_PARTITIONING=0
  export GB_ROOT_PARTITION=1
  export GB_GRUB_CONSOLE=1
  export GB_GRUB_NO_TIMEOUT=1
  export GB_IFACE='eth* eno* enp* ens*'
  ;;
esac

export MAKEOPTS="-j$(nproc)"

env | grep '^GB_'
env | grep 'PACKER'