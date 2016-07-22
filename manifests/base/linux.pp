# Class: profiles::base::linux
# ===========================
#
# Installs and configures linux base modules
#
class profiles::base::linux {
  include motd
  include users
  include puppet_masterless
}

