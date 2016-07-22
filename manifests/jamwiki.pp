# Class: profiles::jamwiki
# ===========================
#
# Installs and configures jamwiki
#
class profiles::jamwiki {
  include tomcat
  include jamwiki
}
